import os
from UniXcoder import create_predict_fn

# download these weights from huggingface timvandam/UniXcoder-Haskell
bin_path = os.path.join(os.path.dirname(__file__), "unixcoder_finetuned.bin")


unixcoder_finetuned = {
    "generate": create_predict_fn(bin_path)
}
