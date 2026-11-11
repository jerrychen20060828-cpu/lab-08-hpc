#!/bin/bash
# Job script for Part 1, Step 2 of README.md: update and complete this script before submitting with sbatch.
# Slurm reads #SBATCH lines only above the first command, so keep them at the top.

#SBATCH --account=ds2022
#SBATCH --job-name=summarize
#SBATCH --partition=gpu-mig
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=00:05:00
#SBATCH --array=1-101
#SBATCH --output=logs/summarize-%A_%a.out

export HF_HUB_OFFLINE=1 # use the downloaded model in $HF_HOME only, without contacting the Hugging Face Hub

module load uv

uv run python src/book_analysis/summarize.py "$1" "$SLURM_ARRAY_TASK_ID"
