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

# The maximum number of rows to process (- 1 since the first Excel row for reference is the header)
row_limit = 302 - 1


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
        t = Taxonomy(file)
        df = t.df

        taxonomy = get_taxonomy(df, include=lambda x: not x[0] and not x[2])
        print([x[0] for x in taxonomy["other"]["wrong type"]])

        # TODO: Do something with the taxonomy for the analysis of common pitfalls
        # Currently, playground:

        # print(json.dumps(_get_no_em_and_invalid_taxonomy_counts(taxonomy), indent=4))
        # print(json.dumps(get_taxonomy_percentages(
        #     _get_no_em_and_invalid_taxonomy_counts(taxonomy)), indent=4))

        # print(json.dumps(get_cumulative_scores(
        #     _get_no_em_and_invalid_taxonomy_counts(taxonomy)), indent=4))
        # print(json.dumps(get_cumulative_percentages(
        #     get_cumulative_scores(_get_no_em_and_invalid_taxonomy_counts(taxonomy))), indent=4))

        # print("Unique rows:", _get_unique_rows_taxonomy_counts(
        #     get_taxonomy(df), debug=True))

        # print("Unique rows:", _get_unique_rows_taxonomy_counts(
        #     get_taxonomy(df, include=lambda x: x[0] or x[2]), debug=False))

        # print(json.dumps(get_filtered_taxonomy_percentages(
        #     df, include=lambda x: not x[0] and not x[2], debug=True), indent=4))

        # __debug_check_last_row(df)


class Taxonomy:
    def __init__(self, filename: str, depth: int = row_limit):
        self.filename = filename
        self.depth = depth
        self.df = get_excel_as_dataframe(filename).head(depth)

    def _reload_df(self):
        self.df = get_excel_as_dataframe(self.filename).head(self.depth)


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


def get_taxonomy(df: pd.DataFrame, include=lambda x: True) -> dict:
    """
    Returns a taxonomy of the annotations in the Excel file.

    Args:
        df (pd.DataFrame): The Excel file as a pandas DataFrame.
        include (lambda, optional): A filter to include only certain annotations. Defaults to including all annotations.

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
                    (i + sheet_offset, value, get_scores_of_row(df, i + sheet_offset)) for i, value in enumerate(df[column].tolist()) if value is not None and subcategory in value and include(get_scores_of_row(df, i + sheet_offset))]

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

                                correlated_scores = get_scores_of_row(
                                    df, row + sheet_offset)
                                if include(correlated_scores):
                                    taxonomy["_undefined"][column].append(
                                        (row + sheet_offset, annotation.strip(), correlated_scores))
                    else:
                        if value.strip() not in all_subcategories:
                            if column not in taxonomy["_undefined"]:
                                taxonomy["_undefined"][column] = []

                            correlated_scores = get_scores_of_row(
                                df, row + sheet_offset)
                            if include(correlated_scores):
                                taxonomy["_undefined"][column].append(
                                    (row + sheet_offset, value.strip(), correlated_scores))

    return taxonomy


def get_taxonomy_counts(taxonomy: dict, include=lambda x: True) -> dict:
    """
    Returns the number of annotations in each category.

    Args:
        taxonomy (dict): The taxonomy.
        include (lambda, optional): A filter to include only certain annotations. Defaults to including all annotations.

    Returns:
        dict: The number of annotations in each category.
    """
    counts = {}
    for category in taxonomy:
        counts[category] = {}

        if category == "_undefined":
            counts[category] = len(taxonomy[category])
            continue

        for subcategory in taxonomy[category]:
            values = [value for value in taxonomy[category]
                      [subcategory] if include(value[2])]  # value[2] is the tuple (EM, ES, if 'valid' in 'other comments')
            counts[category][subcategory] = len(values)

    return counts


"""
Predefined filters for get_taxonomy_counts.
"""


def _get_valid_taxonomy_counts(taxonomy: dict) -> dict:
    return get_taxonomy_counts(taxonomy, include=lambda x: x[2])


def _get_invalid_taxonomy_counts(taxonomy: dict) -> dict:
    return get_taxonomy_counts(taxonomy, include=lambda x: not x[2])


def _get_em_taxonomy_counts(taxonomy: dict) -> dict:
    return get_taxonomy_counts(taxonomy, include=lambda x: x[0])


def _get_no_em_taxonomy_counts(taxonomy: dict) -> dict:
    return get_taxonomy_counts(taxonomy, include=lambda x: not x[0])


def _get_no_em_but_valid_taxonomy_counts(taxonomy: dict) -> dict:
    return get_taxonomy_counts(taxonomy, include=lambda x: not x[0] and x[2])


def _get_em_or_valid_taxonomy_counts(taxonomy: dict) -> dict:
    return get_taxonomy_counts(taxonomy, include=lambda x: x[0] or x[2])


def _get_no_em_and_invalid_taxonomy_counts(taxonomy: dict) -> dict:
    return get_taxonomy_counts(taxonomy, include=lambda x: not x[0] and not x[2])


def _get_es_above_x_taxonomy_counts(taxonomy: dict, x: float) -> dict:
    return get_taxonomy_counts(taxonomy, include=lambda x: x[1] >= x)


def _get_es_below_x_taxonomy_counts(taxonomy: dict, x: float) -> dict:
    return get_taxonomy_counts(taxonomy, include=lambda x: x[1] < x)


def _get_unique_rows_taxonomy_counts(taxonomy: dict, debug: bool = False) -> int:
    row_numbers = set()
    for category in taxonomy:
        if category == "_undefined":
            for row in taxonomy[category]:
                row_numbers.add(row[0])  # row[0] is the row number
            continue
        for subcategory in taxonomy[category]:
            for row in taxonomy[category][subcategory]:
                row_numbers.add(row[0])
    if debug:
        disregarded_rows = set()
        for i in range(1, row_limit + 1):
            if i not in row_numbers:
                disregarded_rows.add(i)

        print("\nDisregarded rows:", len(disregarded_rows),
              "\nIn specific:", disregarded_rows)
        print("\nIncluded rows:", len(row_numbers),
              "\nIn specific:", row_numbers, "\n")
    return len(row_numbers)


def get_taxonomy_percentages(taxonomy_counts: dict, divisor: int = row_limit) -> dict:
    """
    Returns the percentages of the taxonomy.

    Args:
        taxonomy_counts (dict): The taxonomy counts.
        divisor (int, optional): The divisor to use for the percentages. Defaults to row_limit.

    Returns:
        dict: The percentages of the taxonomy.
    """
    percentages = {}
    for category in taxonomy_counts:
        if category == "_undefined":
            percentages[category] = taxonomy_counts[category] / \
                float(divisor) * 100
            continue
        percentages[category] = {}
        for subcategory in taxonomy_counts[category]:
            percentages[category][subcategory] = taxonomy_counts[category][subcategory] / \
                float(divisor) * 100

    return percentages


def get_filtered_taxonomy_percentages(df: pd.DataFrame, include=lambda x: True, debug: bool = False) -> dict:
    filtered_taxonomy = get_taxonomy(df, include)
    return get_taxonomy_percentages(
        taxonomy_counts=get_taxonomy_counts(filtered_taxonomy),
        divisor=_get_unique_rows_taxonomy_counts(
            filtered_taxonomy, debug=debug)
    )


def get_cumulative_counts(taxonomy_counts: dict) -> dict:
    """
    Returns the cumulative counts of the taxonomy.

    Args:
        taxonomy_counts (dict): The taxonomy counts.

    Returns:
        dict: The cumulative scores of the taxonomy.
    """
    cumulative_scores = {}
    for category in taxonomy_counts:
        cumulative_scores[category] = 0
        if category == "_undefined":
            cumulative_scores[category] = taxonomy_counts[category]
            continue
        for subcategory in taxonomy_counts[category]:
            cumulative_scores[category] += taxonomy_counts[category][subcategory]

    return cumulative_scores


def get_cumulative_percentages(taxonomy_cumulative_counts: dict, divisor: int = row_limit) -> dict:
    """
    Returns the cumulative percentages of the taxonomy.

    Args:
        taxonomy_cumulative_counts (dict): The taxonomy cumulative counts.
        divisor (int, optional): The divisor to use for the percentages. Defaults to row_limit.

    Returns:
        dict: The cumulative percentages of the taxonomy.
    """
    cumulative_percentages = {}
    for category in taxonomy_cumulative_counts:
        cumulative_percentages[category] = taxonomy_cumulative_counts[category] / \
            float(divisor) * 100

    return cumulative_percentages


def get_filtered_cumulative_percentages(df: pd.DataFrame, include=lambda x: True, debug: bool = False) -> dict:
    filtered_taxonomy = get_taxonomy(df, include)
    return get_cumulative_percentages(
        taxonomy_cumulative_counts=get_cumulative_counts(
            get_taxonomy_counts(filtered_taxonomy)),
        divisor=_get_unique_rows_taxonomy_counts(
            filtered_taxonomy, debug=debug)
    )


def get_scores_of_row(df: pd.DataFrame, row: int) -> (bool, float, bool):
    """
    Returns the scores of a row in the Excel file in the form of a tuple (EM, ES, if 'valid' in 'other comments').

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
    return (False if em is None or em == 'False' else True, float(es), False if other_comments is None else "valid" in other_comments)


def __debug_check_last_row(df: pd.DataFrame) -> None:
    """
    Checks if the last row is correct.

    Args:
        df (pd.DataFrame): the dataframe
    """
    print("Row limit:", row_limit)
    print("Dataframe length:", len(df))

    last_row = df.iloc[-1:]
    print("Last row:", last_row)


if __name__ == "__main__":
    main()
