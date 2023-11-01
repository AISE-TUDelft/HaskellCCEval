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


if __name__ == "__main__":
    main()
