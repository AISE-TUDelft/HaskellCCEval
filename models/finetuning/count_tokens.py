"""
Script that can count the number of tokens in a train.txt file
"""
from transformers import AutoTokenizer
from argparse import ArgumentParser
import os
from tqdm import tqdm

def main():
    parser = ArgumentParser()
    parser.add_argument('-f', '--file', type=str, required=True)
    parser.add_argument('-m', '--model', type=str, default="microsoft/unixcoder-base")
    args = parser.parse_args()

    if not os.path.exists(args.file):
        print(f"File {args.file} does not exist")
        return

    tokenizer = AutoTokenizer.from_pretrained(args.model)
    token_count = 0

    line_count = 0
    with open(args.file, 'r') as f:
        for line in f:
            line_count += 1

    with open(args.file, 'r') as f:
        for line in tqdm(f, desc="Counting tokens", total=line_count):
            input_tokens = tokenizer.tokenize(line)
            token_count += len(input_tokens)

    print(f"Total number of tokens: {token_count}")


if __name__ == "__main__":
    main()
