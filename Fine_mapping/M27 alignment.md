
# M27 alignment from the beginning using the original raw data

### Unzip the files and concatenate reads

gunzip *
cat 863_LIB6292_LDI5172_GTGAAA_L002_R1.fastq 863_LIB6292_LDI5172_GTGAAA_L003_R1.fastq 863_LIB6292_LDI5172_GTGAAA_L004_R1.fastq 863_LIB6292_LDI5172_GTGAAA_L005_R1.fastq > m27_read1.fa

cat 863_LIB6292_LDI5172_GTGAAA_L002_R2.fastq 863_LIB6292_LDI5172_GTGAAA_L003_R2.fastq 863_LIB6292_LDI5172_GTGAAA_L004_R2.fastq 863_LIB6292_LDI5172_GTGAAA_L005_R2.fastq > m27_read2.fa


### Check the quality of the Reads:

Data quality was visualised using fastqc:

```bash
  for RawData in $(ls raw_seq/m27/*.fa); do
    echo $RawData;
    ProgDir=/home/magdac/git_repos/emr_repos/tools/seq_tools/dna_qc;
    qsub $ProgDir/run_fastqc.sh $RawData;
  done
```

Trimming was performed on data to trim adapters from sequences and remove poor quality data.
This was done with fastq-mcf

```bash
  Read_F=raw_seq/m27/m27_read1.fa
  Read_R=raw_seq/m27/m27_read2.fa
  IluminaAdapters=/home/magdac/git_repos/emr_repos/tools/seq_tools/illumina_full_adapters.fa
  ProgDir=/home/magdac/git_repos/emr_repos/tools/seq_tools/rna_qc
  qsub $ProgDir/rna_qc_fastq-mcf.sh $Read_F $Read_R $IluminaAdapters DNA
```

Data quality was visualised once again following trimming:

```bash
  for RawData in $(ls qc_dna/paired/N.ditissima/*/*/*.fq.gz); do
  echo $RawData;
  ProgDir=/home/gomeza/git_repos/emr_repos/tools/seq_tools/dna_qc;
  qsub $ProgDir/run_fastqc.sh $RawData;
  done
```
