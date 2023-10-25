import json
import os
from argparse import ArgumentParser


def main():
    parser = ArgumentParser()
    parser.add_argument('-m', '--models', choices=["unixcoder_base", "codegpt_base", "unixcoder_finetuned", "codegpt_finetuned"], required=True, nargs="+")
    parser.add_argument('-t', '--test-set', required=True)
    parser.add_argument('-o', '--output-folder', required=True, default="output")
    args = parser.parse_args()

    models = []

    if "unixcoder_base" in args.models:
        from unixcoder_predict import unixcoder
        models.append(("unixcoder_base", unixcoder['generate']))

    if "codegpt_base" in args.models:
        from codegpt_predict import codegpt
        models.append(("codegpt_base", codegpt['generate']))

    if "unixcoder_finetuned" in args.models:
        from unixcoder_finetuned_predict import unixcoder_finetuned
        models.append(("unixcoder_finetuned", unixcoder_finetuned['generate']))

    if "codegpt_finetuned" in args.models:
        from codegpt_finetuned_predict import codegpt_finetuned
        models.append(("codegpt_finetuned", codegpt_finetuned['generate']))

    os.makedirs(args.output_folder, exist_ok=True)

    for name, generate in models:
        print(f'Running model {name}')

        output_file_path = os.path.join(args.output_folder, f"{name}.json")
        with open(args.test_set) as f_test, \
             open(output_file_path, "w") as f_out:
            for sample in f_test:
                sample_obj = json.loads(sample)
                prediction = generate(left_context=sample_obj["input"])
                prediction_lines = prediction.splitlines()
                prediction = (prediction_lines + [''])[0]

                sample_obj["prediction"] = prediction
                json.dump(sample_obj, f_out)
                f_out.write("\n")


if __name__ == "__main__":
    main()

