import json
import os
import random
import re
from argparse import ArgumentParser
from typing import Tuple, Union
from itertools import takewhile
from datasets import Dataset, DatasetDict, load_dataset
from tqdm import tqdm

__DIRNAME = os.path.dirname(__file__)


def main():
    """
    Parses command line arguments, loads the dataset, splits it into train and test sets, and creates the train and test inputs for the specified model.
    """
    parser = ArgumentParser()
    parser.add_argument('-s', '--seed', type=int, default=42)
    parser.add_argument('-t', '--test-ratio', type=float, default=0.2)
    parser.add_argument('-j', '--test-json-ratio', type=float, default=1)
    args = parser.parse_args()

    random.seed(args.seed)

    haskell_dataset: Union[Dataset, DatasetDict] = load_dataset("blastwind/github-code-haskell-function", split="train")

    filtered_dataset = filter_dataset(haskell_dataset)
    train, test = split_data(filtered_dataset, args.seed, args.test_ratio)

    create_train(train)
    create_test(test, args.test_json_ratio)


# TODO: in another script:
# TODO: Load the models
# TODO: Evaluate the models

def filter_dataset(haskell_dataset: Union[Dataset, DatasetDict]) -> Union[Dataset, DatasetDict]:
    """
    Filters the given dataset using numerous criteria to ensure the data is of high quality.

    Args:
    - haskell_dataset: A Dataset or DatasetDict object containing the dataset to be filtered.

    Returns:
    - The filtered dataset.
    """
    MINIMUM_SIZE = 75
    MINIMUM_LOC = 2

    def sample_filter(sample):
        if 'full_code' not in sample or sample['full_code'] is None:
            return False

        if 'full_size' not in sample or sample['full_size'] is None or sample['full_size'] < MINIMUM_SIZE:
            return False

        if 'is_commented' not in sample or not sample['is_commented']:
            return False

        if 'is_signatured' not in sample or not sample['is_signatured']:
            return False

        if 'n_ast_errors' not in sample or sample['n_ast_errors'] > 0:
            return False

        if 'loc' not in sample or sample['loc'] is None or sample['loc'] < MINIMUM_LOC:
            return False

        return True

    return haskell_dataset.filter(sample_filter)


def split_data(haskell_dataset: Union[Dataset, DatasetDict], seed: int, test_ratio: float) -> Tuple[Union[Dataset, DatasetDict], Union[Dataset, DatasetDict]]:
    """
    Splits the given dataset into training and testing sets based on the given test ratio and seed.

    Args:
    - haskell_dataset: A Dataset or DatasetDict object containing the dataset to be split.
    - seed: An integer value representing the seed for the random number generator used in the split.
    - test_ratio: A float value representing the ratio of the dataset to be used for testing.

    Returns:
    - A tuple containing the training and testing sets respectively.
    """
    dataset = haskell_dataset.train_test_split(test_size=test_ratio, seed=seed)
    return dataset['train'], dataset['test']


def preprocess_input(text: str) -> str:
    """
    Preprocesses raw text by stripping leading/trailing whitespace, replacing
    newlines with '<EOL>', and adding '<s>' and '</s>' tags to the beginning
    and end of the text, respectively.

    Args:
        text (str): The raw text to preprocess.

    Returns:
        str: The preprocessed text.
    """
    text = text.strip()
    text = re.sub(r'\n+', '<EOL>', text)
    text = '<s>' + text + '</s>'
    return text


def create_train(train) -> None:
    """
    The models use <EOL> instead of newline (max 1), start sequences with <s> and end them with </s>.
    All the inputs should be saved in a text file with one input per line.

    Args:
        train (list): A list of training samples based on 'full code' field entries.

    Returns:
        None
    """
    with open(os.path.join(__DIRNAME, './finetuning/data/train.txt'), 'w') as f:
        for sample in tqdm(train, desc="Writing train.txt"):
            full_code = preprocess_input(sample['full_code'])
            f.write(full_code + '\n')


def create_test(test, test_json_ratio) -> None:
    """
    We create a test.txt that is used to compute loss, and a test.json that has some test cases for computing the accuracy.

    Args:
        train (list): A list of test samples based on 'full code' field entries.

    Returns:
        None
    """

    # test.txt
    with open(os.path.join(__DIRNAME, './finetuning/data/test.txt'), 'w') as f:
        for sample in tqdm(test, desc="Writing test.txt"):
            full_code = preprocess_input(sample['full_code'])
            f.write(full_code + '\n')

    # test.json
    with open(os.path.join(__DIRNAME, './finetuning/data/test.json'), 'w') as f:
        for sample in tqdm(test, desc="Writing test.json"):
            # test json takes much longer. so we have the option to take only a small part if we want a preview during training
            if random.random() > test_json_ratio:
                continue

            full_code = preprocess_input(sample['full_code'])
            space_split = full_code.split(' ')

            MIN_PREFIX_TOKENS = 5
            MIN_SUFFIX_TOKENS = 2

            split_indices = [
                i
                for i in range(5, len(space_split))
                if len(space_split[:i]) >= MIN_PREFIX_TOKENS
                   and len(list(takewhile(lambda x: x != '<EOL>', space_split[i:]))) >= MIN_SUFFIX_TOKENS
            ]

            if len(split_indices) == 0:
                continue

            split_index = random.choice(split_indices)
            model_input = ' '.join(space_split[:split_index])
            model_output = ' '.join(space_split[split_index:]).split('<EOL>')[0]

            obj = {"input": model_input, "gt": model_output}

            json.dump(obj, f)
            f.write('\n')


if __name__ == "__main__":
    main()
