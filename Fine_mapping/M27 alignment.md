
# M27 alignment from the beginning using the original raw data

### Unzip the files and concatenate reads

gunzip *
cat 863_LIB6292_LDI5172_GTGAAA_L002_R1.fastq 863_LIB6292_LDI5172_GTGAAA_L003_R1.fastq 863_LIB6292_LDI5172_GTGAAA_L004_R1.fastq 863_LIB6292_LDI5172_GTGAAA_L005_R1.fastq > m27_read1.fa

cat 863_LIB6292_LDI5172_GTGAAA_L002_R2.fastq 863_LIB6292_LDI5172_GTGAAA_L003_R2.fastq 863_LIB6292_LDI5172_GTGAAA_L004_R2.fastq 863_LIB6292_LDI5172_GTGAAA_L005_R2.fastq > m27_read1.fa

### Check the quality of the Reads:

Data quality was visualised using fastqc:

```bash
  for RawData in $(ls raw_dna/paired/*/*/*/*.fastq); do
    echo $RawData;
    ProgDir=/home/gomeza/git_repos/emr_repos/tools/seq_tools/dna_qc;
    qsub $ProgDir/run_fastqc.sh $RawData;
  done
```
```bash
  for RawData in $(ls raw_seq/m27/*.fastq); do
    echo $RawData;
    ProgDir=/home/magdac/git_repos/emr_repos/tools/seq_tools/dna_qc;
    qsub $ProgDir/run_fastqc.sh $RawData;
  done
```

Trimming was performed on data to trim adapters from sequences and remove poor quality data.
This was done with fastq-mcf
