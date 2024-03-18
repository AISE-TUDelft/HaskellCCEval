#!/bin/bash
#
#SBATCH --job-name="CodeGPT haskell finetune"
#SBATCH --account=research-eemcs-st
#SBATCH --partition=gpu
#SBATCH --time=119:59:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=32G
#SBATCH --output=/home/tovandam/haskell/models/finetuning/codegpt/output/finetune-%j.log

module load 2022r2
module load openmpi
module load py-torch
module load python/3.8.12
module load py-pip
#python -m pip install --user -r ~/haskell/models/requirements.txt

python3 -u ~/haskell/models/finetuning/codegpt/run_lm.py \
	--do_train \
	--data_dir ~/haskell/models/finetuning/data \
	--output_dir ~/haskell/models/finetuning/codegpt/output \
	--langs python \
	--overwrite_output_dir \
	--log_file ~/haskell/models/finetuning/codegpt/output/finetune-1.log \
  --model_type gpt2 \
  --pretrain_dir AISE-TUDelft/CodeGPT-Multilingual \
  --not_pretrain \
  --weight_decay 0.01 \
  --learning_rate 8e-5 \
  --per_gpu_train_batch_size 2 \
  --per_gpu_eval_batch_size 2 \
  --num_train_epochs 10 \
  --evaluate_during_training \
  --save_steps 30000
