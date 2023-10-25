"""
Generates one JSON file with input/outputs for line completion.
The splits for the input/output are based on all the haskell files in this directory that contain "⭐️".
The script splits on the "⭐️" symbol iff available in the line and takes max(x) of the splits and concatenates the output.    
"""
import os
import random

files = {}
io = {}


def haskell_files_to_str(directory=os.path.dirname(os.path.realpath(__file__))):
    # Read all .hs files and put them in a dictorionary with as key the filename and as value the content of the file as a string
    for filename in os.listdir(directory):
        if filename.endswith(".hs"):
            with open(os.path.join(directory, filename), "r") as f:
                files[int(filename.split("-")[1].split(".hs")[0])] = f.read()


def filter_haskell_implementation_from_files():
    # Go through 'files' and update each key/value pair with a new value split on ("-- Haskell Implementation:")
    for key, value in files.items():
        files[key] = value.split("-- Haskell Implementation:")[1].strip()


def split_on_split_symbol(split_symbol: str = "⭐️"):
    for key, value in files.items():
        io[key] = {}
        i = 0

        # Read per line and split on the split_symbol
        lines = value.split("\n")
        for line in lines:
            if (split_symbol not in line):
                continue

            splits = line.split(split_symbol)

            for j in range(len(splits)):
                if (j >= len(splits) - 1):
                    break
                io[key][i] = {}
                # TODO: Add context of previous lines to input
                io[key][i]["input"] = splits[j].strip()
                io[key][i]["output"] = "".join(splits[j+1:]).strip()
                i += 1

# TODO: Add function that writes to JSON file


if __name__ == "__main__":
    haskell_files_to_str()
    filter_haskell_implementation_from_files()
    split_on_split_symbol()
    print(files[4])
    print(io[4])
