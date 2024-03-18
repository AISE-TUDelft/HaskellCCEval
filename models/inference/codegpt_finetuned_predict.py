from CodeGPT import create_predict_fn
import os

current_dir = os.path.dirname(os.path.realpath(__file__))
finetuned_checkpoint_folder = os.path.join(current_dir, "../finetuning/codegpt/output/checkpoint-180000-2.9038")

codegpt_finetuned = {
    "generate": create_predict_fn(finetuned_checkpoint_folder)
}
