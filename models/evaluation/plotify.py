from typing import Optional, Tuple
from taxonomify import *
import matplotlib.pyplot as plt
import seaborn as sns
import os
import json

current_dir = os.path.dirname(os.path.realpath(__file__))
annotated_dir = os.path.join(current_dir, "annotated")
output_dir = os.path.join(annotated_dir, "output")

sns.set_theme(style="whitegrid")


class TaxonomyPlotObject:
    def __init__(self, taxonomy: Taxonomy, name: str, include=lambda x: True, color: Optional[str] = None):
        self.taxonomy = taxonomy
        self.name = name
        self.include = include
        self.color = color


def main():
    print("Plotting...")

    # Taxonomy objects for both models
    codegpt = Taxonomy(os.path.join(
        annotated_dir, "codegpt_finetuned-test-humaneval.xlsx"))
    unixcoder = Taxonomy(os.path.join(
        annotated_dir, "unixcoder_finetuned-test-humaneval.xlsx"))

    if False:  # Distribution of annotations - Plots
        # CodeGPT vs UniXcoder: Plot the distribution of annotations for each category, only including annotations that are not exact match nor valid
        codegpt_not_exact_match_nor_valid = TaxonomyPlotObject(
            codegpt, "CodeGPT", include=lambda x: not x[0] and not x[2])
        unixcoder_not_exact_match_nor_valid = TaxonomyPlotObject(
            unixcoder, "UniXcoder", include=lambda x: not x[0] and not x[2])

        plot_distribution_annotations(
            t1=codegpt_not_exact_match_nor_valid,
            t2=unixcoder_not_exact_match_nor_valid,
            figure_name="distribution_annotations-codepgt_vs_unixcoder-not_exact_match_nor_valid.png",
            plot_title="Distribution of Annotations for Each Category - Not Exact Match Nor Valid"
        )

        # CodeGPT vs UniXcoder: Plot the distribution of annotations for each category, only including annotations that are exact match or valid
        codegpt_exact_match_or_valid = TaxonomyPlotObject(
            codegpt, "CodeGPT", include=lambda x: x[0] or x[2])
        unixcoder_exact_match_or_valid = TaxonomyPlotObject(
            unixcoder, "UniXcoder", include=lambda x: x[0] or x[2])

        plot_distribution_annotations(
            t1=codegpt_exact_match_or_valid,
            t2=unixcoder_exact_match_or_valid,
            figure_name="distribution_annotations-codepgt_vs_unixcoder-exact_match_or_valid.png",
            plot_title="Distribution of Annotations for Each Category - Exact Match Or Valid"
        )

        # CodeGPT vs CodeGPT: Plot the distribution of annotations for each category, non-EM and non-valid vs. total
        codegpt_not_exact_match_nor_valid_other_descr = TaxonomyPlotObject(
            codegpt, "Not EM and Not Valid", include=lambda x: not x[0] and not x[2])

        codegpt_total = TaxonomyPlotObject(
            codegpt, "Total", include=lambda x: True)

        plot_distribution_annotations(
            t1=codegpt_not_exact_match_nor_valid_other_descr,
            t2=codegpt_total,
            figure_name="distribution_annotations-codegpt_not_EM_and_not_valid-vs-codegpt_total.png",
            plot_title="Distribution of Annotations for Each Category - CodeGPT: Not EM and Not Valid vs. Total"
        )

        # UniXcoder vs UniXcoder: Plot the distribution of annotations for each category, non-EM and non-valid vs. total
        unixcoder_not_exact_match_nor_valid_other_descr = TaxonomyPlotObject(
            unixcoder, "Not EM and Not Valid", include=lambda x: not x[0] and not x[2])
        unixcoder_total = TaxonomyPlotObject(
            unixcoder, "Total", include=lambda x: True)

        plot_distribution_annotations(
            t1=unixcoder_not_exact_match_nor_valid_other_descr,
            t2=unixcoder_total,
            figure_name="distribution_annotations-unixcoder_not_EM_and_not_valid-vs-unixcoder_total.png",
            plot_title="Distribution of Annotations for Each Category - UniXcoder: Not EM and Not Valid vs. Total"
        )

        # CodeGPT vs CodeGPT: Plot the distribution of annotations for each category, EM or valid vs. total
        codegpt_exact_match_or_valid_other_descr = TaxonomyPlotObject(
            codegpt, "EM or Valid", include=lambda x: x[0] or x[2])

        plot_distribution_annotations(
            t1=codegpt_exact_match_or_valid_other_descr,
            t2=codegpt_total,
            figure_name="distribution_annotations-codegpt_EM_or_valid-vs-codegpt_total.png",
            plot_title="Distribution of Annotations for Each Category - CodeGPT: EM or Valid vs. Total"
        )

        # UniXcoder vs UniXcoder: Plot the distribution of annotations for each category, EM or valid vs. total
        unixcoder_exact_match_or_valid_other_descr = TaxonomyPlotObject(
            unixcoder, "EM or Valid", include=lambda x: x[0] or x[2])

        plot_distribution_annotations(
            t1=unixcoder_exact_match_or_valid_other_descr,
            t2=unixcoder_total,
            figure_name="distribution_annotations-unixcoder_EM_or_valid-vs-unixcoder_total.png",
            plot_title="Distribution of Annotations for Each Category - UniXcoder: EM or Valid vs. Total"
        )

    if False:  # Cross-overlaps - Data
        codegpt_total = TaxonomyPlotObject(codegpt, "CodeGPT")
        unixcoder_total = TaxonomyPlotObject(unixcoder, "UniXcoder")

        # Get cross overlaps
        print("Cross overlaps between CodeGPT and UniXcoder...")
        get_sorted_cross_overlaps(codegpt_total, unixcoder_total)

        print("Cross overlaps between UniXcoder and CodeGPT...")
        get_sorted_cross_overlaps(unixcoder_total, codegpt_total)

        print("Cross overlaps between CodeGPT and CodeGPT...")
        get_sorted_cross_overlaps(codegpt_total, codegpt_total)

        print("Cross overlaps between UniXcoder and UniXcoder...")
        get_sorted_cross_overlaps(unixcoder_total, unixcoder_total)

    # Cross-overlaps - Plots
    if False:  # CodeGPT vs UniXcoder:
        for name, values in read_cross_overlaps(
                filename="cross_overlaps-CodeGPT_vs_UniXcoder.json",
                filter_func=lambda item: item["percentage"] > 5 and item["t1_category"] == "other comments" and item["t2_category"] == "other comments"):

            left_name = name.split(" vs. ")[0].ljust(50).replace("CodeGPT, ", "").replace(
                "UniXcoder, ", "").replace("(", "").replace(")", "").replace("other comments, ", "")
            right_name = name.split(" vs. ")[1].ljust(50).replace("CodeGPT, ", "").replace(
                "UniXcoder, ", "").replace("(", "").replace(")", "").replace("other comments, ", "")
            print(
                f"{left_name} & {right_name} & {values['percentage']:.2f}\\% ({values['count_overlap']}/{values['count_total']}) \t \\\\")

    if False:  # UniXcoder vs CodeGPT:
        for name, values in read_cross_overlaps(
                filename="cross_overlaps-UniXcoder_vs_CodeGPT.json",
                filter_func=lambda item: item["percentage"] > 5 and item["t1_category"] == "other comments" and item["t2_category"] == "other comments"):

            left_name = name.split(" vs. ")[0].ljust(50).replace("CodeGPT, ", "").replace(
                "UniXcoder, ", "").replace("(", "").replace(")", "").replace("other comments, ", "")
            right_name = name.split(" vs. ")[1].ljust(50).replace("CodeGPT, ", "").replace(
                "UniXcoder, ", "").replace("(", "").replace(")", "").replace("other comments, ", "")
            print(
                f"{left_name} & {right_name} & {values['percentage']:.2f}\\% ({values['count_overlap']}/{values['count_total']}) \t \\\\")

    if False:  # CodeGPT vs CodeGPT:

        for name, values in read_cross_overlaps(
            filename="cross_overlaps-CodeGPT_vs_CodeGPT.json",
            filter_func=lambda item: item["percentage"] > 10
                and item["overlap_count"] > 2
                and (item["t1_subcategory"] != "extra comment" and item["t2_subcategory"] != "extra comment")
                and item["t1_subcategory"] != item["t2_subcategory"]):

            left_name = name.split(" vs. ")[0].ljust(50).replace("CodeGPT, ", "").replace(
                "UniXcoder, ", "").replace("(", "").replace(")", "").replace("other comments, ", "").replace("other, ", "").ljust(50)
            right_name = name.split(" vs. ")[1].ljust(50).replace("CodeGPT, ", "").replace(
                "UniXcoder, ", "").replace("(", "").replace(")", "").replace("other comments, ", "").replace("other, ", "").ljust(50)

            print(
                f"{left_name} & {right_name} & {values['percentage']:.2f}\\% ({values['count_overlap']}/{values['count_total']}) \t \\\\")

    if True:  # UniXcoder vs UniXcoder:

        for name, values in read_cross_overlaps(
            filename="cross_overlaps-UniXcoder_vs_UniXcoder.json",
            filter_func=lambda item: item["percentage"] > 10
                and item["overlap_count"] > 2
                and (item["t1_subcategory"] != "extra comment" and item["t2_subcategory"] != "extra comment")
                and item["t1_subcategory"] != item["t2_subcategory"]):

            left_name = name.split(" vs. ")[0].ljust(50).replace("CodeGPT, ", "").replace(
                "UniXcoder, ", "").replace("(", "").replace(")", "").replace("other comments, ", "").replace("other, ", "").ljust(50)
            right_name = name.split(" vs. ")[1].ljust(50).replace("CodeGPT, ", "").replace(
                "UniXcoder, ", "").replace("(", "").replace(")", "").replace("other comments, ", "").replace("other, ", "").ljust(50)

            print(
                f"{left_name} & {right_name} & {values['percentage']:.2f}\\% ({values['count_overlap']}/{values['count_total']}) \t \\\\")


def plot_distribution_annotations(t1: TaxonomyPlotObject, t2: TaxonomyPlotObject, figure_name: str = "distribution_annotations.png", plot_title: str = "Distribution of Annotations for Each Category"):
    """
    Plots the distribution of annotations for each category.
    """
    codegpt = t1.taxonomy
    unixcoder = t2.taxonomy

    # Get the (filtered) counts for each category
    codegpt_counts = get_taxonomy_counts(get_taxonomy(
        codegpt.df, include=t1.include))
    unixcoder_counts = get_taxonomy_counts(get_taxonomy(
        unixcoder.df, include=t2.include))

    # Plot the distribution of annotations for each category (10 categories)

    fig, ax = plt.subplots(10, 1, figsize=(15, 25))
    fig.suptitle(plot_title)
    fig.tight_layout(pad=3.0)

    i = 0
    for category in categories:
        # Get the counts for each category
        codegpt_count = codegpt_counts[category]
        unixcoder_count = unixcoder_counts[category]

        # Plot the distribution of annotations for each category using a barplot
        subcategories = []
        subcounts = []
        model = []
        for subcategory in categories[category]:
            subcategories.append(subcategory)
            subcounts.append(codegpt_count[subcategory])
            model.append(t1.name)

            subcategories.append(subcategory)
            subcounts.append(unixcoder_count[subcategory])
            model.append(t2.name)

        sns.barplot(x=subcategories, y=subcounts,
                    hue=model, ax=ax[i])

        for j in ax[i].containers:
            ax[i].bar_label(j, label_type="edge",
                            color="dimgrey", weight="bold")

        ax[i].set_title(category)
        ax[i].set_xlabel("")
        ax[i].set_ylabel("")

        # Set height for the subplot to be relative the the maximum count in either codegpt_subcounts or unixcoder_subcounts
        ax[i].set_ylim(0, max(subcounts) + 0.2 * max(subcounts))

        i += 1

    # Save the plot
    plt.plot()
    plt.savefig(os.path.join(output_dir, figure_name))
    print(f"Saved plot {figure_name}")


def overlap_specific_annotations(t1: TaxonomyPlotObject, category1: str, subcategory1: str, t2: TaxonomyPlotObject, category2: str, subcategory2: str, print_overlap: bool = False):
    taxonomy1 = get_taxonomy(t1.taxonomy.df)
    taxonomy2 = get_taxonomy(t2.taxonomy.df)

    # Get the "empty", "extra comments", "wrong type", "incomplete", "undefined"

    def annotation_exists(taxonomy: dict, category: str, subcategory: str, line_number: int):
        for line_nr, annotation, score in taxonomy[category][subcategory]:
            if line_nr == line_number:
                return True
        return False

    total = []
    overlap = []
    for line_nr, annotation, score in taxonomy1[category1][subcategory1]:
        total.append((line_nr, annotation, score))
        if annotation_exists(taxonomy2, category2, subcategory2, line_nr):
            overlap.append((line_nr, annotation, score))

    if print_overlap:
        print(f"\n{t1.name} \"{subcategory1}\" vs. {t2.name} \"{subcategory2}\"")
        print(len(overlap), len(total))

    return overlap, total


def get_sorted_cross_overlaps(t1: TaxonomyPlotObject, t2: TaxonomyPlotObject, write_to_file: bool = True):
    """
    Gets the sorted cross-overlaps between two taxonomies.
    """
    overlaps = {}

    for i, category1 in enumerate(categories):
        print(f"{i + 1}/{len(categories)}")
        for subcategory1 in categories[category1]:
            for j, category2 in enumerate(categories):
                print(f"-- {j + 1}/{len(categories)}")
                for subcategory2 in categories[category2]:
                    overlap, total = overlap_specific_annotations(
                        t1, category1, subcategory1, t2, category2, subcategory2)
                    overlap_name = f"({t1.name}, {category1}, {subcategory1}) vs. ({t2.name}, {category2}, {subcategory2})"
                    overlaps[overlap_name] = {
                        "overlap": overlap,
                        "total": total,
                        "count_overlap": len(overlap),
                        "count_total": len(total),
                        "percentage": 0 if len(total) <= 0 else len(overlap) / float(len(total)) * 100
                    }

    if write_to_file:
        filename = f"cross_overlaps-{t1.name}_vs_{t2.name}.json"
        with open(os.path.join(output_dir, filename), "w") as f:
            json.dump(overlaps, f, indent=4)

    return overlaps


def read_cross_overlaps(filename: str, filter_func=lambda item: item["percentage"] > 0):
    overlaps = json.load(open(os.path.join(output_dir, filename)))

    filtered = {}
    for key, value in overlaps.items():
        t1, t2 = key.split(" vs. ")
        t1 = t1.replace("(", "").replace(")", "").split(", ")
        t2 = t2.replace("(", "").replace(")", "").split(", ")
        filter_object = {
            "t1_name": t1[0],
            "t1_category": t1[1],
            "t1_subcategory": t1[2],
            "t2_name": t2[0],
            "t2_category": t2[1],
            "t2_subcategory": t2[2],
            "percentage": value["percentage"],
            "overlap_count": value["count_overlap"],
            "total_count": value["count_total"]
        }

        if filter_func(filter_object):
            filtered[key] = value

    return sorted(filtered.items(), key=lambda item: item[1]["percentage"], reverse=True)


if __name__ == "__main__":
    main()
