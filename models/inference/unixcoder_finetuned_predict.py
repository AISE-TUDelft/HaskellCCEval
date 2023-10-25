import os

import torch
from transformers import RobertaTokenizer, RobertaConfig, RobertaModel

from Seq2Seq import Seq2Seq

device = torch.device("cuda")
config = RobertaConfig.from_pretrained("microsoft/unixcoder-base")
config.is_decoder = True
tokenizer = RobertaTokenizer.from_pretrained("microsoft/unixcoder-base")
encoder = RobertaModel.from_pretrained("microsoft/unixcoder-base", config=config)
model = Seq2Seq(encoder=encoder,decoder=encoder,config=config,beam_size=3,max_length=1024,sos_id=tokenizer.cls_token_id,eos_id=[tokenizer.sep_token_id])
# download these weights from huggingface timvandam/UniXcoder-Haskell
bin_path = os.path.join(os.path.dirname(__file__), "unixcoder_finetuned.bin")
model.load_state_dict(torch.load(bin_path), strict=False)
model.to(device)
model.eval()


def generate(left_context: str) -> str:
    max_length = 896

    tokens = tokenizer.tokenize(left_context)
    tokens = tokens[-(max_length - 3):]
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
            p.append(text)

    if len(p) == 0:
        return ''

    return p[0] or ''


unixcoder_finetuned = {
    "generate": generate
}
