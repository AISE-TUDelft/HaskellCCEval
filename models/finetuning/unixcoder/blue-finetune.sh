#!/bin/bash
#
#SBATCH --job-name="UniXcoder x Haskell"
#SBATCH --account=research-eemcs-st
#SBATCH --partition=gpu
#SBATCH --time=27:30:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=16G
#SBATCH --output=/home/tovandam/haskell/models/finetuning/unixcoder/output/finetune-unixcoder-haskell-%j.out

module load 2022r2
module load openmpi
module load py-torch
module load python/3.8.12
module load py-pip
#python -m pip install --user -r ~/haskell/models/requirements.txt

python3 -u ~/haskell/models/finetuning/unixcoder/run.py \
	--do_train \
	--do_eval \
	--model_name_or_path microsoft/unixcoder-base \
	--train_filename ~/haskell/models/finetuning/data/train.txt \
	--dev_filename ~/haskell/models/finetuning/data/dev.json \
  --output_dir ~/haskell/models/finetuning/unixcoder/output \
  --max_source_length 936 \
  --max_target_length 64 \
  --beam_size 3 \
  --train_batch_size 2 \
  --eval_batch_size 2 \
  --gradient_accumulation_steps 1 \
  --learning_rate 2e-5 \
  --num_train_epochs 10
