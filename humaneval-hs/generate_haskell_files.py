"""
Generates Haskell files for the HumanEval library.
The files include the Python Implementation that should be translated,
and a Haskell function to be implemented.
"""

import datasets
from math import ceil
import re

assignees = [
    "A",
    "C",
    "E",
    "D",
    "B",
]

humaneval = datasets.load_dataset("openai_humaneval")
humaneval_instances = humaneval["test"]
instances_per_assignee = ceil(len(humaneval_instances) / len(assignees))

for i, instance in enumerate(humaneval_instances):
    assignee = assignees[i // instances_per_assignee]
    python_implementation = instance["prompt"] + instance["canonical_solution"]
    task_id = instance["task_id"]
    fn_name = re.search(r"def\s+(\w+)\(", python_implementation).group(1)

    with open(f"{task_id.replace('/', '-')}.hs", "w") as f:
        f.write(f"-- Task ID: {task_id}\n")
        f.write(f"-- Assigned To: {assignee}\n\n")
        f.write(f"-- Python Implementation:\n\n")
        for line in python_implementation.split("\n"):
            f.write(f"-- {line}\n")
        f.write("\n\n")
        f.write(f"-- Haskell Implementation:\n\n")
        f.write("-- ???\n")
        f.write(f"{fn_name} :: ???\n")
        f.write(f"{fn_name} = ???\n")
