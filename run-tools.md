### Running CARD RGI AMR pipeline for mNGS and WGS data

To run the AMR pipeline on test samples, we used the runner script `run-select-final.sh` to call sub-scripts to run each tool (`main-amr`, `main-species`, `kma-amr`, `kma-species`)

The script was run as follows:

```
bash run-select-final.sh INPUT_R1.fastq INPUT_R2.fastq INPUT_contigs.fasta
```

Here is a specific example:

```
bash run-select-final.sh amr-experiment-mrsa-files/RR108e_00071_S1_207817_reads_nh_R1.fastq.gz amr-experiment-mrsa-files/RR108e_00071_S1_207817_reads_nh_R2.fastq.gz amr-experiment-mrsa-files/RR108e_00071_S1_207817_contigs_nh.fasta
```


### Combining outputs

The final results were combined be merging the `*-amr` and `*-species` results for each of `main` and `kma`, and then finally merging the `main` and `kma` outputs into a combined result table. This was done using the jupyter notebook `preview_results_per_sample.ipynb`. The output was a .tsv file.

The combined results were then parsed into final small and large table formats to be used in UXR testing (or otherwise ingested into the web app). This was done using the notebook `configure_results.ipynb`. There was some additional manual formatting done to generate the final UXR samples.