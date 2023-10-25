import json
from argparse import ArgumentParser

import torch.cuda


def main():
    print("GPU =", torch.cuda.is_available())

    parser = ArgumentParser()
    parser.add_argument('-m', '--models', choices=["unixcoder-base", "codegpt-base","unixcoder-finetuned", "codegpt-finetuned"], required=True, nargs="+")
    parser.add_argument('-t', '--test-set', required=True)

    args = parser.parse_args()

    if not args.test_set.endswith(".json"):
        raise ValueError("Test set must be a .json file.")

    models = []
    if "unixcoder-base" in args.models:
        from unixcoder_predict import unixcoder
        models.append(unixcoder)
    if "codegpt-base" in args.models:
        from codegpt_predict import codegpt
        models.append(codegpt)

    with open(args.test_set) as f:
        print("Loading test set... " + args.test_set)
        for sample in f:
            sample_obj = json.loads(sample)

            input = sample_obj["input"]
            gt = sample_obj["gt"]

            for model in models:
                generate = model["generate"]
                args = {}
                if model["supports_left_context"]:
                    args["left_context"] = input

                prediction = generate(**args)
                prediction_lines = prediction.splitlines()
                prediction = "" if len(prediction_lines) == 0 else prediction_lines[0]

                sample_obj["prediction"] = prediction
                with open(model["output_file"], "w") as f:
                    f.write(json.dumps(sample_obj) + "\n")


if __name__ == "__main__":
    main()

