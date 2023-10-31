import os
from UniXcoder import create_predict_fn


unixcoder_finetuned = {
    "generate": create_predict_fn("timvandam/ML4SE23_G7_UniXcoder-Haskell")
}
