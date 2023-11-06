"""
Creates a dataset and uploads it to the HuggingFace Hub.
Uses ALL split symbols in the dataset.
"""

from argparse import ArgumentParser
import os
from datasets import Dataset, DatasetDict
from generate_splits import get_file_input_outputs
import pandas as pd

def main():
    parser = ArgumentParser()
    parser.add_argument('-hp', '--huggingface-path', type=str, required=True, help='An optional path to store the dataset in the HuggingFace Hub. Requires you to be logged in')
    parser.add_argument('-i', '--input-dir', type=str, default=".", help='The directory containing the dataset to be uploaded')
    parser.add_argument("--split_symbol", type=str, default="⭐", help="The split symbol used to indicate interesting places to perform code completion")
    args = parser.parse_args()

    if not os.path.exists(args.input_dir):
        print(f"Input directory {args.input_dir} does not exist.")
        return

    haskell_file_names = [
        file_name
        for file_name in os.listdir(args.input_dir)
        if file_name.endswith(".hs")
    ]

    df = pd.DataFrame(
        columns=["file_name", "input", "output"],
        data=[
            [haskell_file_name, sample["input"], sample["gt"]]
            for haskell_file_name in haskell_file_names
            for sample in get_file_input_outputs(os.path.join(args.input_dir, haskell_file_name), args.split_symbol, None, False)
        ]
    )

    test_split = Dataset.from_pandas(df)
    dataset = DatasetDict({"test": test_split})

    dataset.push_to_hub(args.huggingface_path)


if __name__ == "__main__":
    main()