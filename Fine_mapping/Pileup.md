#Pileup rootstock genomes

### Test pileup with 2 genomes only

```bash
samtools mpileup -o test.out -r Chr11:32800005-40097135 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
```

This is a very quick test which will print out to screen the first 1000 lines of variants in m13 - not working. error message says "Set max per-file depth to 8000"

```bash
samtools mpileup -r Chr11:32800005-40097135 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam|bcftools view|head -n 1000
```

Try to change default settings

```bash
samtools mpileup -d 8000 -r Chr11:32800005-40097135 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam|bcftools view|head -n 1000
```

## Pileup chromosomes 5, 11 and 13 to call variants only is these regions


STEP1. mpileup is single threaded. Multiple instances can be launched to pileup different chromosome regions.
Index all BAM files (included in bam_files txt file). This step no needed since I indexed the bams when I did the alignment.

```bash
cat bam_files|xargs -I file samtools index file
```
STEP2. Create a region file with the regions of chr 5, 11 and 13

STEP3. Pileup the bam files with samtools mpileup and a region files

```bash
samtools mpileup -o allpiledup -u -r Chr11:1-8200001 -f home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam)
```
Then run pileup2.sh regions have been defined in the regions file. Finally concatenate output files (the regions file is sorted alphabetically rather than by chromosome - temp fix is to create an ordered list of output file names)

```bash
./pileup2.sh /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta bam_files /home/groups/harrisonlab/project_files/root_architecture/test_pileup piledup.bcf regions
```

```bash
samtools mpileup -r Chr11:32800005-40097135 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam|bcftools view|head -n 1000
```

```bash
cd /home/groups/harrisonlab/project_files/root_architecture
REF=/home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
BAMS=bam_files
DEST=test_pileup
OUTNAME=piledup.bcf
REGION=regions
ProgDir=/home/magdac/git_repos/emr_repos/scripts/root_architecture/Fine_mapping
qsub $ProgDir/submit_pileup.sh2 $REF $BAMS $DEST $OUTNAME $REGION
```
###Test pileup with 2 genomes only

This is a test to see if the script is working with 2 genomes only

```bash
samtools mpileup -o test.out -r Chr11:32800005-40097135 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
```

This is a very quick test which will print out to screen the first 1000 lines of variants in m13 - but not working

```bash
samtools mpileup -r Chr11:32800005-40097135 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam|bcftools view|head -n 1000
```