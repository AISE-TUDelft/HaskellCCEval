import os
from UniXcoder import create_predict_fn

current_dir = os.path.dirname(os.path.realpath(__file__))
finetuned_checkpoint_folder = os.path.join(current_dir, "../finetuning/unixcoder/output/checkpoint-best-acc")

unixcoder_finetuned = {
    "generate": create_predict_fn(finetuned_checkpoint_folder)
}
