# this file reads model outputs and runs various metrics on them
import inspect
import json
from argparse import ArgumentParser
import os
import re
from collections import defaultdict
from typing import List

from fuzzywuzzy import fuzz


def main():
    parser = ArgumentParser()
    parser.add_argument('-m', '--models', required=True, nargs="+")
    parser.add_argument('-o', '--output-folder', required=True)
    args = parser.parse_args()

    if not os.path.exists(args.output_folder):
        raise ValueError("Output folder does not exist.")

    available_models = [
        re.sub(r"\.json$", "", d)
        for d in os.listdir(args.output_folder)
        if d.endswith(".json")
    ]

    invalid_models = set(args.models) - set(available_models)
    if len(invalid_models) > 0:
        raise ValueError(f"Invalid models: [{', '.join(invalid_models)}]. Must be one of [{', '.join(available_models)}]")

    for model in args.models:
        print(f"Evaluating {model}")

        predictions = []
        targets = []

        output_file_path = os.path.join(args.output_folder, f"{model}.json")
        with open(output_file_path) as f:
            for sample in f:
                sample_obj = json.loads(sample)
                predictions += [sample_obj["prediction"]]
                targets += [sample_obj["gt"]]

        metric_values = compute_metrics(predictions, targets)

        for metric_name, metric_values in metric_values.items():
            print(f"{metric_name}: {100 * sum(metric_values) / len(metric_values):.4f}")

        print("-" * 10)


def preprocess(text: str) -> str:
    text = text.strip()
    text = " ".join(text.split())
    return text


class Metric:
    @staticmethod
    def em(prediction: str, ground_truth: str) -> float:
        return float(prediction == ground_truth)

    @staticmethod
    def es(prediction: str, ground_truth: str) -> float:
        return fuzz.ratio(prediction, ground_truth) / 100

    @staticmethod
    def empty(prediction: str, ground_truth: str) -> float:
        return float(prediction == '')

def compute_metrics(predictions: List[str], targets: List[str]):
    metrics = ["em", "es", "empty"]

    values = defaultdict(list)

    for prediction, target in zip(predictions, targets):
        prediction = preprocess(prediction)
        target = preprocess(target)
        for metric in metrics:
            metric_fn = getattr(Metric, metric)
            values[metric].append(metric_fn(prediction, target))

    return values


if __name__ == "__main__":
    main()
