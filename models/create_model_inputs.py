import json
import os
import random
import re
from argparse import ArgumentParser
from typing import Tuple, Union

from datasets import Dataset, DatasetDict, load_dataset
from tqdm import tqdm

__DIRNAME = os.path.dirname(__file__)


def main():
    """
    Parses command line arguments, loads the dataset, splits it into train and test sets, and creates the train and dev inputs for the specified model. 
    """
    parser = ArgumentParser()
    parser.add_argument('-s', '--seed', type=int, default=42)
    parser.add_argument('-m', '--model', type=str, choices=['unixcoder', 'codegpt'], required=True)
    parser.add_argument('-t', '--test-ratio', type=float, default=0.2)
    args = parser.parse_args()

    random.seed(args.seed)

    haskell_dataset: Union[Dataset, DatasetDict] = load_dataset("blastwind/github-code-haskell-function", split="train")
    # TODO: Possibly discard data with "n_ast_errors > 0", 700k / 3.2m

    train, test = load_data(haskell_dataset, args.seed, args.test_ratio)

    create_train(train)
    # we use the test set as validation set just to get some accuracy numbers during training, to ensure our code is functional
    # we do not make any changes based on this
    create_dev(test)


# TODO: in another script:
# TODO: Load the models
# TODO: Evaluate the models

def load_data(haskell_dataset: Union[Dataset, DatasetDict], seed: int, test_ratio: float) -> Tuple[Union[Dataset, DatasetDict], Union[Dataset, DatasetDict]]:
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
            if 'full_code' not in sample or sample['full_code'] is None:
                continue
            full_code = preprocess_input(sample['full_code'])
            f.write(full_code + '\n')


def create_dev(test) -> None:
    """
    We create a dev.txt that is used to compute loss, and a dev.json that has some test cases for computing the accuracy.

    Args:
        train (list): A list of test samples based on 'full code' field entries.

    Returns:
        None
    """

    # dev.txt
    with open(os.path.join(__DIRNAME, './finetuning/data/dev.txt'), 'w') as f:
        for sample in tqdm(test, desc="Writing dev.txt"):
            if 'full_code' not in sample or sample['full_code'] is None:
                continue
            full_code = preprocess_input(sample['full_code'])
            f.write(full_code + '\n')

    # dev.json
    with open(os.path.join(__DIRNAME, './finetuning/data/dev.json'), 'w') as f:
        for sample in tqdm(test, desc="Writing dev.json"):
            if 'full_code' not in sample or sample['full_code'] is None:
                continue
            full_code = preprocess_input(sample['full_code'])
            space_split = full_code.split(' ')
            split_indices = [i for i in range(1, len(
                space_split) - 1) if not ' '.join(space_split[i:]).strip().startswith('<EOL>')]
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
