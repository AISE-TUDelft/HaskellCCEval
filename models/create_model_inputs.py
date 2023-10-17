import os
import random
from argparse import ArgumentParser
from datasets import load_dataset
import re
import json

from tqdm import tqdm


def main():
    parser = ArgumentParser()
    parser.add_argument('-s', '--seed', type=int, default=42)
    parser.add_argument('-m', '--model', type=str, choices=['unixcoder'], required=True)
    parser.add_argument('-t', '--test-ratio', type=float, default=0.2)
    args = parser.parse_args()

    random.seed(args.seed)

    haskell_dataset = load_dataset("blastwind/github-code-haskell-function", split="train")
    # TODO: Possibly discard data with "n_ast_errors > 0", 700k / 3.2m

    train, test = load_data(haskell_dataset, args.seed, args.test_ratio)

    if args.model == 'unixcoder':
        create_unixcoder_train(train)
        # we use the test set as validation set just to get some accuracy numbers during training, to ensure our code is functional
        # we do not make any changes based on this
        create_unixcoder_dev(test)


# TODO: in another script:
# TODO: Load the models
# TODO: Evaluate the models

def load_data(haskell_dataset, seed, test_ratio):
    dataset = haskell_dataset.train_test_split(test_size=test_ratio, seed=seed)
    return dataset['train'], dataset['test']


def preprocess_unixcoder(text):
    text = text.strip()
    text = re.sub(r'\n+', '<EOL>', text)
    text = '<s>' + text + '</s>'
    return text


dirname = os.path.dirname(__file__)
def create_unixcoder_train(train):
    """
    UniXcoder uses <EOL> instead of newline (max 1), starts sequences with <s> and ends them with </s>.
    All the inputs should be saved in a text file with one input per line
    """
    with open(os.path.join(dirname, './finetuning/unixcoder/data/train.txt'), 'w') as f:
        for sample in tqdm(train, desc="Writing train.txt"):
            if 'full_code' not in sample or sample['full_code'] is None:
                continue
            full_code = preprocess_unixcoder(sample['full_code'])
            f.write(full_code + '\n')

def create_unixcoder_dev(test):
    """
    We create a dev.txt that is used to compute loss, and a dev.json that has some test cases for computing the accuracy
    """
    # dev.txt
    with open(os.path.join(dirname, './finetuning/unixcoder/data/dev.txt'), 'w') as f:
        for sample in tqdm(test, desc="Writing dev.txt"):
            if 'full_code' not in sample or sample['full_code'] is None:
                continue
            full_code = preprocess_unixcoder(sample['full_code'])
            f.write(full_code + '\n')

    # dev.json
    with open(os.path.join(dirname, './finetuning/unixcoder/data/dev.json'), 'w') as f:
        for sample in tqdm(test, desc="Writing dev.json"):
            if 'full_code' not in sample or sample['full_code'] is None:
                continue
            full_code = preprocess_unixcoder(sample['full_code'])
            space_split = full_code.split(' ')
            split_indices = [i for i in range(1, len(space_split) - 1) if not " ".join(space_split[i:]).strip().startswith('<EOL>')]
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
