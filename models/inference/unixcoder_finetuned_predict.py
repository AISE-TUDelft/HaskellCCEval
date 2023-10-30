import os
from UniXcoder import create_predict_fn

# download these weights from huggingface timvandam/ML4SE23_G7_UniXcoder-Haskell
bin_path = os.path.join(os.path.dirname(__file__), "unixcoder_finetuned.bin")


unixcoder_finetuned = {
    "generate": create_predict_fn(bin_path)
}
