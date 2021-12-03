#!/bin/bash

srst2 --input_pe $1 $2 --forward _R1 --reverse _R2 --output $3 --log --gene_db /home/ubuntu/comp-bio-secure/AMR-research/srst2-source/srst2/data/ARGannot_r3.fasta --min_coverage 10 --min_depth 2 --max_divergence 10

