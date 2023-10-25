from CodeGPT import create_predict_fn

codegpt_finetuned = {
    "generate": create_predict_fn("timvandam/CodeGPT-Multilingual-Haskell")
}
