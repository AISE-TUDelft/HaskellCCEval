from CodeGPT import create_predict_fn

codegpt_finetuned = {
    "name": "CodeGPT-Multilingual-Haskell",
    "generate": create_predict_fn("timvandam/CodeGPT-Multilingual-Haskell"),
    "supports_left_context": True,
    "supports_right_context": False,
    "output_file": "../inference_output/codegpt_finetuned/output.json"
}
