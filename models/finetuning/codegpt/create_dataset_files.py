"""
Loads CodeSearchNet from HuggingFace,
creates code fragments including comments,
and saves test and train files to ./data/codesearchnet
"""

import os
import datasets
import re
import random
import json
import tqdm


EOL_TOKEN = "<EOL>"
S_TOKEN = "<s>"
S_END_TOKEN = "</s>"


def main():
    if not os.path.exists("./data/codesearchnet"):
        os.makedirs("./data/codesearchnet")

    # load CodeSearchNet from HuggingFace (all languages)
    dataset: datasets.DatasetDict = datasets.load_dataset("code_search_net", "all")

    print("Loaded dataset")

    # write test.json
    # test_dataset: datasets.Dataset = dataset["test"]
    #
    # test.json format:
    # each line contains a json object with the following fields:
    # - "input": the code fragment (including comment), split in some line
    # - "gt": the rest of that line
    # the input starts with <s> and newlines are replaced by <EOL>

    # the test data created here randomly picks a non-empty line, and splits on some whitespace
    with open("./data/codesearchnet/test.json", "w") as f:
        for sample in tqdm.tqdm(test_dataset, desc="Creating test.json"):
            original_function_text = sample["func_code_string"].strip()
            commented_function_text = get_commented_sample(sample).strip()

            # we need to skip the comment lines, and the first line of the fn to ensure that we give enough context
            skipped_line_count = len(commented_function_text.splitlines()) - len(original_function_text.splitlines())
            skipped_line_count += 1

            # non empty line indices, excluding leading comments
            non_empty_line_indices = [
                skipped_line_count + i
                for i, line in enumerate(commented_function_text.splitlines()[skipped_line_count:])
                if len(line.split()) > 2
            ]

            if len(non_empty_line_indices) == 0:
                # skip this sample, there are only empty lines
                continue

            split_line_idx = random.choice(non_empty_line_indices)
            line_to_split = commented_function_text.splitlines()[split_line_idx]
            line_indent_str = line_to_split[:line_to_split.index(line_to_split.split()[0])]
            unindented_line = line_to_split[len(line_indent_str):]
            assert line_indent_str + unindented_line == line_to_split

            fragments = unindented_line.split()
            split_fragment_idx = random.randint(1, len(fragments) - 1)

            gt = " ".join(fragments[split_fragment_idx:])
            line_input = line_indent_str + " ".join(fragments[:split_fragment_idx])
            input = f" {EOL_TOKEN} ".join(commented_function_text.splitlines()[:split_line_idx] + [line_input])

            obj = {"gt": gt, "input": input, "fn": commented_function_text, "language": sample["language"]}

            json_obj = json.dumps(obj)
            f.write(json_obj + "\n")

    # write train.txt
    train_dataset: datasets.Dataset = dataset["train"]

    # train.txt format:
    # each line contains a training sample, which is a string where newlines have been replaced by <EOL>.
    # the string starts with <s> and ends with </s>

    with open("./data/codesearchnet/train.txt", "w") as f:
        for sample in tqdm.tqdm(train_dataset, desc="Creating train.txt"):
            commented_function_text = get_commented_sample(sample).strip()
            commented_function_text = f" {EOL_TOKEN} ".join(commented_function_text.splitlines())
            f.write(f"{S_TOKEN} {commented_function_text} {S_END_TOKEN}\n")

    # write dev.txt
    dev_dataset: datasets.Dataset = dataset["validation"]

    # dev.txt format:
    # same as train

    with open("./data/codesearchnet/dev.txt", "w") as f:
        for sample in tqdm.tqdm(dev_dataset, desc="Creating dev.txt"):
            commented_function_text = get_commented_sample(sample).strip()
            commented_function_text = f" {EOL_TOKEN} ".join(commented_function_text.splitlines())
            f.write(f"{S_TOKEN} {commented_function_text} {S_END_TOKEN}\n")


def get_commented_sample(sample: dict) -> str:
    comment = get_sample_comment(sample)
    code = sample["func_code_string"]
    return (comment + "\n" + code).strip()


def get_sample_comment(sample: dict):
    language: str = sample["language"]
    code: str = sample["func_code_string"]
    comment_text: str = sample["func_documentation_string"]

    if len(comment_text.strip()) == 0:
        return ""

    if language in ["java", "javascript", "php"]:
        line_count = len(comment_text.splitlines())
        if line_count == 1:
            return create_cpp_singleline_comment(comment_text)
        else:
            # is docblock when it has @[a-zA-Z]+ at the start of a line
            docblock_line_pattern = re.compile(r"^@\w+")
            is_docblock = any([docblock_line_pattern.match(line) for line in comment_text.splitlines()])
            if is_docblock:
                return create_cpp_docblock_comment(comment_text)
            else:
                return create_cpp_multiline_comment(comment_text)
    elif language == "python":
        # comment may already be present in code (inside """ doc """ blocks)
        comment_already_present = all(comment_line in code for comment_line in comment_text.splitlines())
        if comment_already_present:
            return ""
        else:
            return create_python_comment(comment_text)
    elif language == "go":
        # for some reason go comments already come with // at the start of each line
        return comment_text
        # return create_cpp_singleline_comment(comment_text)
    elif language == "ruby":
        # ruby also has multi line comments (=begin ... =end) but they appear not to be used very commonly
        # instead, the same style as in python (a single line comment for every line) is used
        return create_python_comment(comment_text)

    raise ValueError(f"Language {language} not supported")


def create_cpp_docblock_comment(comment: str) -> str:
    res = "/**\n"
    for line in comment.splitlines():
        res += " * " + line + "\n"
    res += " */"
    return res


def create_cpp_multiline_comment(comment: str) -> str:
    res = "/*\n"
    for line in comment.splitlines():
        res += line + "\n"
    res += "*/"
    return res


def create_cpp_singleline_comment(comment: str) -> str:
    res = ""
    for line in comment.splitlines():
        res += "// " + line + "\n"
    return res.strip()


def create_python_comment(comment: str) -> str:
    res = ""
    for line in comment.splitlines():
        res += "# " + line + "\n"
    return res.strip()


if __name__ == "__main__":
    main()
