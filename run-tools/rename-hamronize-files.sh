#!/bin/bash
  
# $1 input file #output_106_L001_98495_reads_nh.hamronize.amrfp.o
echo "-----"
echo $1

new_name=$(echo $1 | cut -d'/' -f2 |  cut -d'_' -f1-3)
echo $new_name

a=$(less $1 | cut -f1 | head -2 | tail -1)
echo $a

# actual work:
sed "s/$a/$new_name/g" "$1" > $1.renamed
