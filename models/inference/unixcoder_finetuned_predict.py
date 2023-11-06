import os
from UniXcoder import create_predict_fn


unixcoder_finetuned = {
    "generate": create_predict_fn("AISE-TUDelft/ML4SE23_G7_UniXcoder-Haskell")
}
