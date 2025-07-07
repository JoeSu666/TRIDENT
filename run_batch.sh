#!/bin/bash
#SBATCH --account PAS3015
#SBATCH --job-name trident
#SBATCH --time=02:00:00 # Requesting for 1 min
#SBATCH --ntasks-per-node=1 # Number of cores on a single node or number of tasks per requested node. Default is a single core.
#SBATCH --gpus-per-node=1 # Number of gpus per node. Default is none.
#SBATCH --cpus-per-gpu=1 # number of CPUs required per allocated GPU
#SBATCH --mem=100gb # Specify the (RAM) main memory required per node. # to request 24gb use --mem=24gb or --mem=24000mb (Other flags which are mutually exclusive: >> 1st flag. --mem-per-gpu=0 # real memory required per allocated GPU # usage: can be 0 (all memory), 40G, 80G. >> 2nd flag. --mem-per-cpu=0 # MB # maximum amount of real memory per allocated cpu required by the job. --mem >= --mem-per-cpu if --mem is specified. # usage e.g.: type `4G` for 4 gigbytes)
#SBATCH --output=logs/slurm_%A_%a.out #Standard output log
#SBATCH --error=logs/slurm_%A_%a.err #Standard error log
#SBATCH --cluster=ascend # Can also explicitly specify which cluster to submit the job to. Or, log in to the node and submit the job.


# can add these lines here if you haven't called them first in the terminal
source activate trident

# run the python file
python run_batch_of_slides.py --task seg --wsi_dir /fs/scratch/PAS2942/Datasets/TCGA2/COAD --job_dir ./trident_tcgacoad --gpu 0 --segmenter hest \
                            --custom_list_of_wsis  /fs/scratch/PAS3015/Users/ziyu/distillfm/tcgacoadfilelist.csv
# python run_batch_of_slides.py --task coords --wsi_dir ../MIL/data/sampleslides/ --job_dir ./trident_processed --mag 20 --patch_size 896 --overlap 0

# run FEATURE EXTRACTION with BACKBONE. OUTPUTS 768-dim

# python run_batch_of_slides.py --task feat --wsi_dir ../MIL/data/sampleslides/ --job_dir ./trident_processed \
#                             --patch_encoder univ2_distill \
#                             --patch_encoder_ckpt_path /fs/scratch/PAS3015/Users/ziyu/distillfm/distillfm/outputs/distill_uni_to_vit_base_pretrain_48x24bsize/checkpoints/student_ema_ep9.ckpt \
#                             --mag 20 --patch_size 896 

# run FEATURE EXTRACTION with BACKBONE+HEAD. OUTPUTS 1536-dim

# python run_batch_of_slides.py --task feat --wsi_dir ../MIL/data/sampleslides/ --job_dir ./trident_processed \
#                             --patch_encoder univ2_distill_head \
#                             --patch_encoder_ckpt_path /fs/scratch/PAS3015/Users/ziyu/distillfm/distillfm/outputs/distill_uni_to_vit_base_pretrain_48x24bsize/checkpoints/student_ema_head_ep9.ckpt \
#                             --mag 20 --patch_size 896

# run FEATURE EXTRACTION with BACKBONE (CLS+avg(Tokens)). OUTPUTS 768x2-dim

# python run_batch_of_slides.py --task feat --wsi_dir ../MIL/data/sampleslides/ --job_dir ./trident_processed \
#                             --patch_encoder univ2_distill_concat \
#                             --patch_encoder_ckpt_path /fs/scratch/PAS3015/Users/ziyu/distillfm/distillfm/outputs/distill_uni_to_vit_base_pretrain_48x24bsize/checkpoints/student_ema_ep9.ckpt \
#                             --mag 20 --patch_size 896

# run FEATURE EXTRACTION with BACKBONE (ViT-Small). OUTPUTS 384-dim

# python run_batch_of_slides.py --task feat --wsi_dir ../MIL/data/sampleslides/ --job_dir ./trident_processed \
#                             --patch_encoder univ2_distill_small \
#                             --patch_encoder_ckpt_path /fs/scratch/PAS3015/Users/ziyu/distillfm/distillfm/outputs/distill_uni_to_vit_small_pretrain_48x24bsize/checkpoints/student_ema_ep9.ckpt \
#                             --mag 20 --patch_size 896 