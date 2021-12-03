#!/bin/bash

source ~/anaconda3/etc/profile.d/conda.sh

# $1 (R1) $2 (R2) $3 (contigs)

file_root=$(echo $1 | cut -d. -f1 | sed 's/_R1//g')
echo $file_root

out_dir=$(echo output_$file_root)
echo $out_dir
mkdir $out_dir

output_root=$(echo $out_dir/$out_dir)
echo $output_root

#conda activate amrfinderplusenv
#bash ./run-amrfinderplus/run-amrfinderplus.sh $3 $output_root.amrfp
#conda deactivate

#conda activate aribaenv
#bash ./run-ariba/run-ariba.sh $1 $2 $output_root.ariba
#conda deactivate

#conda activate grootenv
#bash ./run-groot/run-groot.sh $1 $2 $output_root.groot
#conda deactivate

# not yet tested
#conda activate rgienv
#bash ./run-rgi/run-rgi-bwt-bowtie2.sh $1 $2 $output_root.rgi.bowtie2
#bash ./run-rgi/run-rgi-bwt-kma.sh $1 $2 $output_root.rgi.kma
#bash ./run-rgi/run-rgi-main $3 $output_root.rgi.main
#bash ./run-rgi/run-rgi-main-loose $3 $output_root.rgi.main.loose
#conda deactivate rgienv

#conda activate srst2env
#bash ./run-srst2/run-srst2-card.sh $1 $2 $output_root.srst2.card
#bash ./run-srst2/run-srst2-card.sh $1 $2 $output_root.srst2.argannot
#conda deactivate

conda activate staramrenv
bash ./run-staramr/run-staramr.sh $3 $output_root.staramr
conda deactivate



