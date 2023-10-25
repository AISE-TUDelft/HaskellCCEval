"""
Generates one JSON file with input/outputs for line completion.
The splits for the input/output are based on all the haskell files in this directory that contain "⭐️".
The script splits on the "⭐️" symbol iff available in the line and takes max(x) of the splits and concatenates the output.    
"""
import json
import os
import random
from argparse import ArgumentParser
import re


def main(split_symbol: str = "⭐️"):
    parser = ArgumentParser()
    parser.add_argument("--split_symbol", type=str, default="⭐️")
    parser.add_argument("-i", "--input_dir", type=str, default=".")
    parser.add_argument("-o", "--output_dir", type=str, default="./data")
    parser.add_argument("-s", "--seed", type=int, default=42)
    parser.add_argument("-m", "--max_splits", type=int, default=5)
    args = parser.parse_args()

    random.seed(args.seed)

    if not os.path.exists(args.input_dir):
        raise ValueError(f"Input directory {args.input_dir} does not exist.")

    haskell_file_names = [
        file_name
        for file_name in os.listdir(args.input_dir)
        if file_name.endswith(".hs")
    ]

    os.makedirs(args.output_dir, exist_ok=True)
    output_path = os.path.join(args.output_dir, f"test-humaneval.json")

    with open(output_path, "w") as f_out:
        for haskell_file_name in haskell_file_names:
            haskell_file_path = os.path.join(args.input_dir, haskell_file_name)

            with open(haskell_file_path) as f_in:
                haskell_file_content = f_in.read()

            haskell_file_content = extract_haskell_implementation(haskell_file_content)
            haskell_file_content = add_special_tokens(haskell_file_content)

            split_indices = [i for i in range(len(haskell_file_content)) if haskell_file_content.startswith(split_symbol, i)]
            split_indices = random.sample(split_indices, min(args.max_splits, len(split_indices)))

            for split_index in split_indices:
                left = haskell_file_content[:split_index].rstrip()
                right = haskell_file_content[split_index + len(split_symbol):].lstrip()

                right = read_to_eol(right)

                left, right = remove_split_symbols(left), remove_split_symbols(right)

                obj = {"input": left, "gt": right}
                json.dump(obj, f_out)
                f_out.write("\n")


def extract_haskell_implementation(file_content: str):
    return file_content.split("-- Haskell Implementation:")[1].strip()


def add_special_tokens(file_content: str):
    file_content = "<s>" + file_content + "</s>"
    file_content = re.sub(r"\n+", " <EOL> ", file_content)
    return file_content


def remove_split_symbols(text: str, split_symbol: str = "⭐️"):
    splits = text.split(split_symbol)
    for i in range(len(splits)):
        if i > 0:
            splits[i] = splits[i].lstrip()
        if i < len(splits) - 1:
            splits[i] = splits[i].rstrip()
    return " ".join(splits)


def read_to_eol(text: str):
    line = text.split("</s>")[0]
    line = line.split("<EOL>")[0]
    return line


if __name__ == "__main__":
    main()
