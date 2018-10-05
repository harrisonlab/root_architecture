
# M27 alignment from the beginning using the original raw data

Unzip the files and concatenate reads in a fq file

gunzip *
cat 863_LIB6292_LDI5172_GTGAAA_L002_R1.fastq 863_LIB6292_LDI5172_GTGAAA_L003_R1.fastq 863_LIB6292_LDI5172_GTGAAA_L004_R1.fastq 863_LIB6292_LDI5172_GTGAAA_L005_R1.fastq > m27_read1.fq

cat 863_LIB6292_LDI5172_GTGAAA_L002_R2.fastq 863_LIB6292_LDI5172_GTGAAA_L003_R2.fastq 863_LIB6292_LDI5172_GTGAAA_L004_R2.fastq 863_LIB6292_LDI5172_GTGAAA_L005_R2.fastq > m27_read2.fq


### Check the quality of the Reads and trim adaptors:

Data quality was visualised using fastqc:

```bash
for RawData in $(ls raw_seq/m27/m27_read1.fq); do
echo $RawData;
ProgDir=/home/magdac/git_repos/emr_repos/tools/seq_tools/dna_qc
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
for RawData in $(ls qc_dna/m27/m27_read1.fa.gz); do
echo $RawData
ProgDir=/home/magdac/git_repos/emr_repos/tools/seq_tools/dna_qc
qsub $ProgDir/run_fastqc.sh $RawData
done
```

```bash
for RawData in $(ls qc_dna/m27/m27_read2.fa.gz); do
echo $RawData
ProgDir=/home/magdac/git_repos/emr_repos/tools/seq_tools/dna_qc
qsub $ProgDir/run_fastqc.sh $RawData
done
```

### PhiX removal

Removal of phix

 ```shell
 cd $ROOTSTOCK/rootstock_genetics

for d in [mg]*;
 do
  $ROOTSTOCK/scripts/bowtie.sh $ROOTSTOCK/rootstock_genetics/$d/conc/${d}_r1.fq.trim $ROOTSTOCK/rootstock_genetics/$d/conc/${d}_r2.fq.trim /home/groups/harrisonlab/ref_genomes/phix/phix $ROOTSTOCK/rootstock_genetics/$d/conc/ phix_filtered 250 500
 done

./bowtie_se.sh $ROOTSTOCK/rootstock_genetics/o3/conc/o3_r1.fq.trim /home/groups/harrisonlab/ref_genomes/phix/phix $ROOTSTOCK/rootstock_genetics/o3/conc/ phix_filtered
 ```

 ```shell
 cd $ROOTSTOCK/root_architecture

 for d in [mg]*;
 do
  $ROOTSTOCK/scripts/bowtie.sh $ROOTSTOCK/rootstock_genetics/$d/conc/${d}_r1.fq.trim $ROOTSTOCK/rootstock_genetics/$d/conc/${d}_r2.fq.trim /home/groups/harrisonlab/ref_genomes/phix/phix $ROOTSTOCK/rootstock_genetics/$d/conc/ phix_filtered 250 500
 done

 ./bowtie_se.sh $ROOTSTOCK/rootstock_genetics/o3/conc/o3_r1.fq.trim /home/groups/harrisonlab/ref_genomes/phix/phix $ROOTSTOCK/rootstock_genetics/o3/conc/ phix_filtered
 ```
