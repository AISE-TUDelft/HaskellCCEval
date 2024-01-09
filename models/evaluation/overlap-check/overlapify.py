import os
import json

filenames = ['codegpt_finetuned-test-humaneval.json',
             'unixcoder_finetuned-test-humaneval.json']

# Each .json file contains a list of {}. For the value of the key "input" and "prediction", check how many overlapping {}s are there in the file between the version in the /new folder and /old folder.


def get_overlap_count(filename):
    this_dir = os.path.dirname(os.path.abspath(__file__))
    old_path = os.path.join('old', filename)
    new_path = os.path.join('new', filename)

    # Check if file exists in both folders
    if not os.path.exists(os.path.join(this_dir, old_path)):
        print(f'Old file {old_path} does not exist')
        return
    if not os.path.exists(os.path.join(this_dir, new_path)):
        print(f'New file {new_path} does not exist')
        return

    # Load both files
    with open(os.path.join(this_dir, old_path), 'r') as f_old:
        old_data = [json.loads(line) for line in f_old]
    with open(os.path.join(this_dir, new_path), 'r') as f_new:
        new_data = [json.loads(line) for line in f_new]

    # Check if both files have the same number of entries
    if len(old_data) != len(new_data):
        print(
            f'Old file {old_path} and new file {new_path} have different number of entries')
        return

    # Check if both files have the same inputs
    for i in range(len(old_data)):
        if old_data[i]['input'] != new_data[i]['input']:
            print(
                f'Old file {old_path} and new file {new_path} have different inputs')
            return

    print(f"Old file and new file have the same inputs ({filename})")

    # Check how many overlapping "prediction"s there are
    overlapping = []
    line = []
    for i in range(len(old_data)):
        if old_data[i]['prediction'] == new_data[i]['prediction']:
            overlapping.append(i + 1)  # +1 because line number starts from 1
            line.append(new_data[i])

    print(f"Number of overlapping predictions: {len(overlapping)}")
    print(
        f"Percentage of overlapping predictions: {len(overlapping) / len(old_data) * 100:.2f}%")
    print(f"Indices of overlapping predictions: {overlapping}")
    print()

    # Write overlapping predictions to file (line)
    with open(os.path.join(this_dir, 'overlapping-' + filename), 'w') as f:
        json.dump(line, f, indent=4)


if __name__ == '__main__':
    for filename in filenames:
        get_overlap_count(filename)
