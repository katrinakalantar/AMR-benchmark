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

conda activate amrfinderplusenv
bash ./run-amrfinderplus/run-amrfinderplus.sh $3 $output_root.amrfp
conda deactivate

conda activate aribaenv
bash ./run-ariba/run-ariba.sh $1 $2 $output_root.ariba
conda deactivate

conda activate grootenv
bash ./run-groot/run-groot.sh $1 $2 $output_root.groot
conda deactivate

# not yet tested
conda activate rgienv
bash ./run-rgi/run-rgi-bwt-bowtie2.sh $1 $2 $output_root.rgi.bowtie2
bash ./run-rgi/run-rgi-bwt-kma.sh $1 $2 $output_root.rgi.kma
bash ./run-rgi/run-rgi-main.sh $3 $output_root.rgi.main
bash ./run-rgi/run-rgi-main-loose.sh $3 $output_root.rgi.main.loose
conda deactivate

conda activate srst2env
bash ./run-srst2/run-srst2-card.sh $1 $2 $output_root.srst2.card
bash ./run-srst2/run-srst2-argannot.sh $1 $2 $output_root.srst2.argannot
conda deactivate

conda activate staramrenv
bash ./run-staramr/run-staramr.sh $3 $output_root.staramr
conda deactivate


conda activate hamronizationenv

hamronize amrfinderplus $output_root.amrfp --input_file_name $output_root.amrfp --analysis_software_version 3.10.18 --reference_database_version 2021-09-30.1 --format tsv --output $output_root.hamronize.amrfp.o
hamronize ariba $output_root.ariba/report.tsv --input_file_name $output_root.ariba/report.tsv --analysis_software_version 2.14.4 --reference_database_id resfinder --reference_database_version x.x.x --format tsv --output $output_root.hamronize.ariba.o
hamronize groot $output_root.groot --input_file_name $output_root.groot --analysis_software_version 1.1.2 --reference_database_id card --reference_database_version 90 --format tsv --output $output_root.hamronize.groot.o

python3 ./run-rgi/process-rgi-bwt-output.py $output_root.rgi.bowtie2.gene_mapping_data.txt
hamronize rgi $output_root.rgi.bowtie2.gene_mapping_data.txt.pidmod --input_file_name $output_root.rgi.bowtie2.gene_mapping_data.txt.pidmod --analysis_software_version 5.2.0 --reference_database_version 3.1.4 --format tsv --output $output_root.hamronize.rgi.bowtie2.o

python3 ./run-rgi/process-rgi-bwt-output.py $output_root.rgi.kma.gene_mapping_data.txt
hamronize rgi $output_root.rgi.kma.gene_mapping_data.txt.pidmod --input_file_name $output_root.rgi.kma.gene_mapping_data.txt.pidmod --analysis_software_version 5.2.0 --reference_database_version 3.1.4 --format tsv --output $output_root.hamronize.rgi.kma.o

hamronize rgi $output_root.rgi.main.txt --input_file_name $output_root.rgi.main.txt --analysis_software_version 5.2.0 --reference_database_version 3.1.4 --format tsv --output $output_root.hamronize.rgi.main.o
hamronize rgi $output_root.rgi.main.loose.txt --input_file_name $output_root.rgi.main.loose.txt --analysis_software_version 5.2.0 --reference_database_version 3.1.4 --format tsv --output $output_root.hamronize.rgi.main.loose.o

hamronize srst2 $output_root.srst2.card__fullgenes__CARD_v3.0.8_SRST2__results.txt --input_file_name $output_root.srst2.card__fullgenes__CARD_v3.0.8_SRST2__results.txt --analysis_software_version 0.2.0 --reference_database_version 3.0.8 --format tsv --output $output_root.hamronize.srst2.card.o
hamronize srst2 $output_root.srst2.argannot__fullgenes__ARGannot_r3__results.txt --input_file_name $output_root.srst2.argannot__fullgenes__ARGannot_r3__results.txt --analysis_software_version 0.2.0 --reference_database_version 3.0.8 --format tsv --output $output_root.hamronize.srst2.argannot.o

hamronize staramr $output_root.staramr/resfinder.tsv --input_file_name $output_root.staramr/resfinder.tsv --analysis_software_version 0.7.2 --reference_database_version 2021-09-06 --format tsv --output $output_root.hamronize.staramr.o

conda deactivate
