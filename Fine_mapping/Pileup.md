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
### Test pile up with all genomes but M27
Step1- Pileup genome regions

samtools mpileup -o testalmostall5a.out -r Chr05:1-25000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam

samtools mpileup -o testalmostall5b.out -r Chr05:25000001-47952471 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam

Step2-now concatenate both files

bcftools concat -f testalmostall5a testalmostall5b > almostall_piledup.bcf

not working


### Test to get bcf files

samtools mpileup -o testalmostall5a.bcf -r Chr05:1-1000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam

bcftools call -Ov -v -m testalmostall5a.bcf > testalmostall5a.vcf

cat testalmostall5a.vcf|vcfutils.pl varFilter -d100 > flt_testalmostall5a.vcf

vcfutils command not found

samtools mpileup -o testalmostall5a.out -r Chr05:1000001-2000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam


### Test 2 with new vcfutils

Step 1-Pileup regions in chromosome 5

samtools mpileup -o test2_5a.bcf -r Chr05:1-15000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam

samtools mpileup -o test2_5b.bcf -r Chr05:15000001-30000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam

samtools mpileup -o test2_5c.bcf -r Chr05:30000001-47952461 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam

Step 2-now concatenate both files

bcftools concat test2_5a.bcf test2_5b.bcf test2_5b.bcf > test2allpiledup.bcf

Step 3- Filter ouput for variants
bcftools call -Ov -v -m test2allpiledup.bcf > test2allpiledup.vcf
cat test2allpiledup.vcf|vcfutils.pl varFilter -d100 > flt_test2allpiledup.vcf
 

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
