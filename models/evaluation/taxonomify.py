"""
Creates a taxonomy of the annotations in order to evaluate the performance of humaneval-hs.
Ultimately, the results of this script are used to find the common pitfalls of the models.
"""
import json
import os
from argparse import ArgumentParser

import openpyxl
import pandas as pd

categories = {
    "if/then/else": ["all", "if", "then", "else"],
    "generators": ["complete", "body"],
    "guards (= |)": ["complete", "body"],
    "functions": ["complete", "parameter(s)", "argument(s)", "body"],
    "lists": ["++", ":", "!!", "list comprehension", "range"],
    "logical operators": ["all", "&&", "||", "==", ">", "<", ">=", "<=", "/=", "not"],
    "arithmetic operators": ["all", "+", "-", "*", "/", "^", "mod"],
    "case expressions": ["complete", "parameter(s)", "argument(s)", "body"],
    "other": ["variable name", "wrong type", "wrong value", "wrong function"],
    "other comments": ["empty", "extra comment", "valid", "incomplete", "variable definition", "arithmetic logic", "wrong syntax", "import", "complex", "not exhaustive", "undefined"]
}

# The offset needed to match the indices of the first annotation in the Excel file
sheet_offset = 2  # One for the header, one for the fact that Excel starts at 1


def main():
    parser = ArgumentParser()
    parser.add_argument('-f', '--file', required=True, nargs="+")
    parser.add_argument('-o', '--output-folder', required=True)
    args = parser.parse_args()

    if not os.path.exists(args.output_folder):
        os.makedirs(args.output_folder)

    for file in args.file:
        if not os.path.exists(file):
            raise ValueError(f"File {file} does not exist.")

    for file in args.file:
        df = get_excel_as_dataframe(file)
        taxonomy = get_taxonomy(df)
        print(json.dumps(taxonomy, indent=4))

        # TODO: Do something with the taxonomy for the analysis of common pitfalls


def get_excel_as_dataframe(filename: str) -> pd.DataFrame:
    """
    Reads an Excel file and returns its contents as a pandas DataFrame.

    Args:
        filename (str): The path to the Excel file.

    Returns:
        pd.DataFrame: A pandas DataFrame containing the contents of the Excel file.
    """
    wb = openpyxl.load_workbook(filename)
    ws = wb.active

    data = ws.values
    cols = next(data)[1:]
    data = list(data)
    return pd.DataFrame((r[1:] for r in data), index=[r[0] for r in data], columns=[col.split('\n')[0] if col is not None and '\n' in col else col for col in cols])


def get_taxonomy(df: pd.DataFrame) -> dict:
    """
    Returns a taxonomy of the annotations in the Excel file.

    Args:
        df (pd.DataFrame): The Excel file as a pandas DataFrame.

    Returns:
        dict: The taxonomy.
    """
    taxonomy = {"_undefined": {}}
    for category in categories:
        taxonomy[category] = {}
        for subcategory in categories[category]:
            taxonomy[category][subcategory] = []

    # Get annotations for each (sub)category
    # Row index is +1 since Excel starts at 1
    for column in df.columns:
        if column in categories:
            for subcategory in categories[column]:
                # Remove empty cells
                taxonomy[column][subcategory] = [
                    (i + sheet_offset, value, get_scores_of_row(df, i + sheet_offset)) for i, value in enumerate(df[column].tolist()) if value is not None and subcategory in value]

            # Collect all the undefined annotations
            all_subcategories = [
                subcategory for subcategory in categories[column]]
            for row, value in enumerate(df[column].tolist()):
                if value is not None:
                    if "," in value:
                        for annotation in value.split(","):
                            if annotation.strip() not in all_subcategories:
                                if column not in taxonomy["_undefined"]:
                                    taxonomy["_undefined"][column] = []
                                taxonomy["_undefined"][column].append(
                                    (row + sheet_offset, annotation.strip(), get_scores_of_row(df, row + sheet_offset)))
                    else:
                        if value.strip() not in all_subcategories:
                            if column not in taxonomy["_undefined"]:
                                taxonomy["_undefined"][column] = []
                            taxonomy["_undefined"][column].append(
                                (row + sheet_offset, value.strip(), get_scores_of_row(df, row + sheet_offset)))

        else:
            print(f"Column {column} not in categories.")

    return taxonomy


def get_taxonomy_counts(taxonomy: dict) -> dict:
    """
    Returns the number of annotations in each category.

    Args:
        taxonomy (dict): The taxonomy.

    Returns:
        dict: The number of annotations in each category.
    """
    counts = {}
    for category in taxonomy:
        counts[category] = {}
        for subcategory in taxonomy[category]:
            counts[category][subcategory] = len(
                taxonomy[category][subcategory])
    return counts


def get_scores_of_row(df: pd.DataFrame, row: int) -> (bool, float, bool):
    """_summary_

    Args:
        df (pd.DataFrame): the dataframe
        row (int): index of the Excel row

    Returns:
        (bool, float, bool): (EM, ES, if 'valid' in 'other comments')
    """
    row = row - sheet_offset
    if row < 0 or row >= len(df):
        raise ValueError(f"Row {row} is out of bounds.")

    em = df.iloc[row]["EM"]
    es = df.iloc[row]["ES"]
    other_comments = df.iloc[row]["other comments"]
    return (False if em is None or em == 'False' else True, es, False if other_comments is None else "valid" in other_comments)


if __name__ == "__main__":
    main()
