from CodeGPT import create_predict_fn

codegpt = {
    "name": "CodeGPT-Multilingual",
    "generate": create_predict_fn("AISE-TUDelft/CodeGPT-Multilingual"),
    "supports_left_context": True,
    "supports_right_context": False,
    "output_file": "../inference_output/codegpt_base/output.json"
}
