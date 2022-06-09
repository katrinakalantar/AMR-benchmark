#!/bin/bash

source ~/anaconda3/etc/profile.d/conda.sh

# $1 (R1) $2 (R2) $3 (contigs)

file_root=$(echo $1 | cut -d'/' -f2 | cut -d. -f1 | sed 's/_R1//g')
echo $file_root

out_dir=$(echo output_$file_root)
echo $out_dir
mkdir $out_dir

output_root=$(echo $out_dir/$out_dir)
echo $output_root

conda activate rgi
# amr gene-calling using rgi (kma and main)
bash ./run-rgi/run-rgi-bwt-kma.sh $1 $2 $output_root.rgi.kma
bash ./run-rgi/run-rgi-main.sh $3 $output_root.rgi.main

# species-calling on rgi.main
bash ./run-rgi/run-rgi-kmer-main.sh $output_root.rgi.main.json $output_root.rgi.main.kmerspecies

# species-calling on rgi.bwt
bash ./run-rgi/run-rgi-kmer-bwt.sh $output_root.rgi.kma.sorted.length_100.bam $output_root.rgi.kma.kmerspecies

conda deactivate


