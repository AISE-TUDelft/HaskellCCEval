from typing import Callable, Optional
import torch
from transformers import RobertaTokenizer, RobertaConfig, RobertaModel
from Seq2Seq import Seq2Seq


UNIXCODER_BASE_CHECKPOINT = "microsoft/unixcoder-base"


def create_predict_fn(checkpoint_path_or_url: str = UNIXCODER_BASE_CHECKPOINT) -> Callable[[str], str]:

    max_input_length = 896
    max_output_length = 128

    assert max_input_length + max_output_length <= 1024


    device = torch.device("cuda")
    tokenizer = RobertaTokenizer.from_pretrained(checkpoint_path_or_url)
    model = Seq2Seq.from_pretrained(checkpoint_path_or_url, max_length=max_output_length)
    model.to(device)
    model.eval()

    def generate(left_context: str) -> str:
        if checkpoint_path_or_url == UNIXCODER_BASE_CHECKPOINT:
            # the pretrained model does not use EOL
            left_context = left_context.replace(" <EOL> ", "\n")
        else:
            # the model were trained with this replacement, so we need to do it here as well
            left_context = left_context.replace("<EOL>", "</s>")

        tokens = tokenizer.tokenize(left_context)
        tokens = tokens[-(max_input_length - 3):]
        tokens = [tokenizer.cls_token, "<decoder-only>", tokenizer.sep_token] + tokens
        source_ids = tokenizer.convert_tokens_to_ids(tokens)
        source_ids = torch.tensor([source_ids], dtype=torch.long, device=device)

        p = []
        with torch.no_grad():
            preds = model(source_ids=source_ids)
            for pred in preds:
                t = pred[0].cpu().numpy()
                t = list(t)
                if 0 in t:
                    t = t[:t.index(0)]
                text = tokenizer.decode(t, clean_up_tokenization_spaces=False)
                if "</s>" in text:
                    text = text[:text.index("</s>")]
                if checkpoint_path_or_url == UNIXCODER_BASE_CHECKPOINT and "\n" in text:
                    # the pretrained model does not end at the end of a line
                    # hence, we do this as a post processing step
                    text = text[:text.index("\n")]
                p.append(text)

        if len(p) == 0:
            return ''

        return p[0] or ''

    return generate