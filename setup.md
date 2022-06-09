
Here, I outline the set-up for CARD RGI (including RGI tool, CARD database, wildCARD and kmer databases). This is based on instructions at https://github.com/arpcard/rgi .

### Installing RGI Tool

**note:** this was the initial way that installation was done / recommended  
```
conda create -n rgienv  
conda activate rgienv  
conda install --channel conda-forge --channel bioconda --channel defaults rgi=5.2.0 # SUCCESS!  
conda install -c bioconda tbb=2020.2 # to mitigate issue with bowtie2 downstream
```

However, at some point I ran into an error with the tool that required modification of the code.  Therefore, I opted to install using this method:

```
git clone https://github.com/arpcard/rgi
conda env create -f conda_env.yml
conda activate rgi
# modified the code of RGI see note below
python setup.py build
python setup.py test
python setup.py install
```


**note:** modification of the code involved the following changes...

Make the kmer_query.py script parse based on `___` instead of `__` and modify the function `get_bwt_sequences(self)` to deal with kma inputs.

**line 101:** updates to `___` parsing
```
fasta.write(">{orf}___{hsp}___{model}___{type_hit}\n{dna}\n"
    .format(orf=contig_id, hsp=hsp, model=model, type_hit=type_hit, dna=dna))
```
**line 124:** updates to `___` and additional `elif` option
```
if aligner == "":
    os.system("""samtools view -F 4 -F 2048 {bam} | while read line; do awk '{cmd}'; done > {out}"""
      .format(bam=self.input_bam_file, cmd="""{print ">"$1"___"$4"___"$3"___"$5"\\n"$11}""", out=self.fasta_file))
# added by KK for dealing with kma
elif  "ID:KMA"  in aligner:
    print("inside ID:KMA aligner")
    os.system("""samtools view -F 4 -F 2048 {bam} | while read line; do awk '{cmd}'; done > {out}"""
      .format(bam=self.input_bam_file, cmd="""{print ">"$1"___"$4"___"$3"___"$5"\\n"$11}""", out=self.fasta_file))
# end section added by KK
else:
    os.system("""samtools view -F 4 -F 2048 {bam} | while read line; do awk '{cmd}'; done > {out}"""
      .format(bam=self.input_bam_file, cmd="""{print ">"$1"___"$3"___"$2"___"$5"\\n"$10}""", out=self.fasta_file))
```

### Installing associated CARD DBs

``` 
mkdir CARD_DBs  
cd CARD_DBs  
 ```

 obtain CARD data  
```
wget https://card.mcmaster.ca/latest/data  
tar -xvf data ./card.json
```
load the CARD data  
```
rgi card_annotation -i /home/ubuntu/comp-bio-secure/AMR-research/CARD_DBs/card.json > card_annotation.log 2>&1  
rgi load -i /home/ubuntu/comp-bio-secure/AMR-research/CARD_DBs/card.json --card_annotation card_database_v3.1.4.fasta  
  ```
  
obtain wildcard data:   
```
wget -O wildcard_data.tar.bz2 https://card.mcmaster.ca/latest/variants  
mkdir -p wildcard  
tar -xjf wildcard_data.tar.bz2 -C wildcard  
gunzip wildcard/*.gz  
```

load the wildcard data: 
```
rgi wildcard_annotation -i wildcard --card_json /home/ubuntu/comp-bio-secure/AMR-research/CARD_DBs/card.json -v 3.0.9 > wildcard_annotation.log 2>&1 # note: version number comes from web downloads page - [https://card.mcmaster.ca/download](https://card.mcmaster.ca/download)

#local install:
rgi load --wildcard_annotation wildcard_database_v3.0.9.fasta --wildcard_index /home/ubuntu/comp-bio-secure/AMR-research/CARD_DBs/wildcard/index-for-model-sequences.txt --card_annotation card_database_v3.1.4.fasta --local

#system install:
rgi load --wildcard_annotation wildcard_database_v3.0.9.fasta --wildcard_index /home/ubuntu/comp-bio-secure/AMR-research/CARD_DBs/wildcard/index-for-model-sequences.txt --card_annotation card_database_v3.1.4.fasta
```
 
#### Enabling “pathogen-of-origin analysis”

```
#local install:
rgi load --kmer_database /home/ubuntu/comp-bio-secure/AMR-research/CARD_DBs/wildcard/61_kmer_db.json --amr_kmers /home/ubuntu/comp-bio-secure/AMR-research/CARD_DBs/wildcard/all_amr_61mers.txt --kmer_size 61 --local --debug > kmer_load.61.log 2>&1

#system install:
rgi load --kmer_database /home/ubuntu/comp-bio-secure/AMR-research/CARD_DBs/wildcard/61_kmer_db.json --amr_kmers /home/ubuntu/comp-bio-secure/AMR-research/CARD_DBs/wildcard/all_amr_61mers.txt --kmer_size 61 --debug > kmer_load.61.log 2>&1
```

Close the environment
```  
mkdir run-rgi
conda deactivate
```
  

