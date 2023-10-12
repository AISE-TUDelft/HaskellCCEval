import os
from argparse import ArgumentParser
from datasets import load_dataset


def main():
    parser = ArgumentParser()
    parser.add_argument('-s', '--seed', type=int, default=42)
    args = parser.parse_args()

    if not os.path.exists(args.models):
        raise Exception(f'File {args.models} does not exist')

    haskell_dataset = load_dataset("blastwind/github-code-haskell-function", split="train")
    # TODO: Possibly discard data with "n_ast_errors > 0", 700k / 3.2m

    train, test = load_data(haskell_dataset, args.seed)
    # TODO: Load the models
    # TODO: Evaluate the models


def load_data(haskell_dataset, seed):
    dataset = haskell_dataset.train_test_split(test_size=0.2, seed=seed)
    return dataset['train'], dataset['test']


if __name__ == "__main__":
    main()
