
# M27 alignment from the beginning using the original raw data

### Unzip the files and concatenate reads

gunzip *
concat 863_LIB6292_LDI5172_GTGAAA_L00*R1.fastq.gz > m27_read1.fa

### Check the quality of the Reads:


Data quality was visualised using fastqc:

```bash
  for RawData in $(ls raw_dna/paired/*/*/*/*.fastq.gz); do
    echo $RawData;
    ProgDir=/home/gomeza/git_repos/emr_repos/tools/seq_tools/dna_qc;
    qsub $ProgDir/run_fastqc.sh $RawData;
  done
```

Trimming was performed on data to trim adapters from sequences and remove poor quality data.
This was done with fastq-mcf


```bash
  Read_F=raw_dna/paired/N.ditissima/*/F/*.fastq.gz
  Read_R=raw_dna/paired/N.ditissima/*/R/*.fastq.gz
  IluminaAdapters=/home/gomeza/git_repos/emr_repos/tools/seq_tools/illumina_full_adapters.fa
  ProgDir=/home/gomeza/git_repos/emr_repos/tools/seq_tools/rna_qc
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
