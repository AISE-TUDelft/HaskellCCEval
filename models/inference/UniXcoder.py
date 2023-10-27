from typing import Callable, Optional
import torch
from transformers import RobertaTokenizer, RobertaConfig, RobertaModel
from Seq2Seq import Seq2Seq


def create_predict_fn(checkpoint_path: Optional[str]) -> Callable[[str], str]:
    max_input_length = 896
    max_output_length = 128

    assert max_input_length + max_output_length <= 1024


    device = torch.device("cuda")
    config = RobertaConfig.from_pretrained("microsoft/unixcoder-base")
    config.is_decoder = True
    tokenizer = RobertaTokenizer.from_pretrained("microsoft/unixcoder-base")
    encoder = RobertaModel.from_pretrained("microsoft/unixcoder-base", config=config)
    model = Seq2Seq(encoder=encoder, decoder=encoder, config=config, beam_size=3, max_length=max_output_length,
                    sos_id=tokenizer.cls_token_id, eos_id=[tokenizer.sep_token_id])

    if checkpoint_path is not None:
        model.load_state_dict(torch.load(checkpoint_path), strict=False)
    model.to(device)
    model.eval()

    def generate(left_context: str) -> str:
        if checkpoint_path is not None:
            # the model were trained with this replacement, so we need to do it here as well
            left_context = left_context.replace("<EOL>", "</s>")
        else:
            # the pretrained model does not use EOL
            left_context = left_context.replace(" <EOL> ", "\n")

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
                if not checkpoint_path and "\n" in text:
                    # the pretrained model does not end at the end of a line
                    # hence, we do this as a post processing step
                    text = text[:text.index("\n")]
                p.append(text)

        if len(p) == 0:
            return ''

        return p[0] or ''

    return generate