import json
import os
import random
import re
from argparse import ArgumentParser
from typing import Tuple, Union, List, Optional
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
    parser.add_argument('-hp', '--huggingface-path', required=False, help='An optional path to store the dataset in the HuggingFace Hub. Requires you to be logged in')
    args = parser.parse_args()

    random.seed(args.seed)

    haskell_dataset: Union[Dataset, DatasetDict] = load_dataset("blastwind/github-code-haskell-function", split="train")
    original_dataset_size = len(haskell_dataset)
    print(f"Loaded {original_dataset_size} samples")

    haskell_dataset = filter_dataset(haskell_dataset)
    filtered_dataset_size = len(haskell_dataset)
    print(f"Filtered out {original_dataset_size - filtered_dataset_size} samples")

    haskell_dataset = deduplicate_dataset(haskell_dataset)
    deduplicated_dataset_size = len(haskell_dataset)
    print(f"Removed {filtered_dataset_size - deduplicated_dataset_size} duplicates")

    train, test = split_data(haskell_dataset, args.seed, args.test_ratio, args.huggingface_path)

    create_train(train)
    create_test(test)


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

        full_code = sample['full_code']

        if len(full_code) < MINIMUM_SIZE:
            return False

        if 'is_commented' not in sample or not sample['is_commented']:
            return False

        if 'is_signatured' not in sample or not sample['is_signatured']:
            return False

        if 'n_ast_errors' not in sample or sample['n_ast_errors'] > 0:
            return False

        full_code_lines = full_code.splitlines()
        non_comment_loc = sum([len(line.strip()) > 0 and not line.strip().startswith('--') for line in full_code_lines])

        if non_comment_loc < MINIMUM_LOC:
            return False

        return True

    return haskell_dataset.filter(sample_filter, desc="Filtering out low-quality samples")


def deduplicate_dataset(haskell_dataset: Union[Dataset, DatasetDict]) -> Union[Dataset, DatasetDict]:
    """
    Deduplicates the given dataset by removing any duplicate entries.
    Tokenizes every sample's 'full code' field and uses the resulting tokens to determine duplicates.
    The last duplicate is kept as the only sample.

    :param haskell_dataset:
    :return:
    """
    dataset_size = len(haskell_dataset)
    known_samples = set()
    idx_is_unique = [False] * dataset_size

    for i in tqdm(reversed(range(dataset_size)), desc="Finding duplicates", total=dataset_size):
        full_code = ' '.join(haskell_dataset[i]['full_code'].split())
        if full_code in known_samples:
            continue
        known_samples.add(full_code)
        idx_is_unique[i] = True

    # idx_is_unique = [True] * dataset_size
    # for i in tqdm(range(dataset_size), desc="Finding duplicates", total=dataset_size):
    #     full_code = haskell_dataset[i]['full_code']
    #
    #     for j in range(i + 1, dataset_size):
    #         other_full_code = haskell_dataset[j]['full_code']
    #         bleu_score = sentence_bleu([full_code], other_full_code, smoothing_function=SmoothingFunction().method2)
    #         if bleu_score > 0.75:
    #             idx_is_unique[j] = False
    #             break

    def sample_filter(_, idx):
        return idx_is_unique[idx]

    return haskell_dataset.filter(sample_filter, with_indices=True, desc="Filtering out duplicates")


def split_data(haskell_dataset: Union[Dataset, DatasetDict], seed: int, test_ratio: float, huggingface_path: Optional[str]) -> Tuple[Union[Dataset, DatasetDict], Union[Dataset, DatasetDict]]:
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

    if huggingface_path is not None:
        dataset.push_to_hub(huggingface_path)

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
    # special tokens must be surrounded by spaces so we can detect them easily
    text = re.sub(r'\n+', ' <EOL> ', text)
    text = '<s> ' + text + ' </s>'
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


def create_test(test) -> None:
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
            full_code = preprocess_input(sample['full_code'])
            code_tokens = full_code.split(' ')

            MIN_PREFIX_TOKENS = 5
            MIN_PREFIX_LINE_TOKENS = 1
            MIN_SUFFIX_LINE_TOKENS = 2

            def get_non_empty_tokens(tokens):
                return list(filter(lambda x: len(x) > 0, tokens))

            def get_tokens_to_eol(right_tokens):
                return get_non_empty_tokens(takewhile(lambda x: x != '<EOL>' and x != '</s>', right_tokens))

            def get_tokens_to_bol(left_tokens): # bol = beginning of line
                return get_non_empty_tokens(takewhile(lambda x: x != '<EOL>' and x != '<s>', left_tokens[::-1]))[::-1]

            def in_singleline_comment(left_tokens):
                line_tokens = get_tokens_to_bol(left_tokens)
                line = ' '.join(line_tokens)
                return line.strip().startswith('--')

            def in_multiline_comment(left_tokens):
                txt = ' '.join(left_tokens)
                comment_open_idx = txt.rfind('{-')
                if comment_open_idx == -1:
                    return False
                comment_close_idx = txt.rfind('-}', comment_open_idx + 2)
                return comment_close_idx == -1

            split_indices = [
                i
                for i in range(len(code_tokens))
                if len(code_tokens[i - 1]) > 0
                   and len(get_non_empty_tokens(code_tokens[:i])) >= MIN_PREFIX_TOKENS
                   and len(get_tokens_to_bol(code_tokens[:i])) >= MIN_PREFIX_LINE_TOKENS
                   and len(get_tokens_to_eol(code_tokens[i:])) >= MIN_SUFFIX_LINE_TOKENS
                   and not in_singleline_comment(code_tokens[:i])
                   and not in_multiline_comment(code_tokens[:i])
            ]

            if len(split_indices) == 0:
                continue

            split_index = random.choice(split_indices)
            model_input = ' '.join(code_tokens[:split_index]).rstrip()
            model_output = ' '.join(get_tokens_to_eol(code_tokens[split_index:])).lstrip()

            obj = {"input": model_input, "gt": model_output}

            json.dump(obj, f)
            f.write('\n')


if __name__ == "__main__":
    main()
