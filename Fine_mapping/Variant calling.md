# Variant Calling


### Test 2 with new vcfutils

Step 1-Pileup regions in chromosome 5

samtools mpileup -o test2_5a.bcf -r Chr05:1-15000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam

samtools mpileup -o test2_5b.bcf -r Chr05:15000001-30000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam

samtools mpileup -o test2_5c.bcf -r Chr05:30000001-47952461 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam /home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam

Step 2-now concatenate both files

bcftools concat test2_5a.bcf test2_5b.bcf test2_5b.bcf > test2allpiledup.bcf

Step 3- Filter ouput for variants
bcftools call -Ov -v -m test2allpiledup.bcf > test2allpiledup.vcf
cat test2allpiledup.vcf|/home/deakig/usr/bin/vcfutils.pl varFilter -d100 > flt_test2allpiledup.vcf

### Test 3

samtools mpileup -o test3_5a.bcf -r Chr05:1-1000000 -uf
/home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam

bcftools call -Ov -v -m test3_5a.bcf > test3_5a.vcf

cat test3_5a.vcf|/home/deakig/usr/bin/vcfutils.pl varFilter -d100 > flt_test3_5a.vcf


### All rootstocks piledup - small regions of each chromosome are piled up and variant calling has been done in each region and then regions can be merged in order to have the whole chromosome

Step 1- Pileup regions in chromosomes

```bash
samtools mpileup -o piledup_5a.bcf -r Chr05:1-8000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_5b.bcf -r Chr05:8000001-16000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_5c.bcf -r Chr05:16000001-24000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_5d.bcf -r Chr05:24000001-32000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_5e.bcf -r Chr05:32000001-40000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_5f.bcf -r Chr05:40000001-47952461 -uf
/home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
Step 2-now concatenate the files per chromosome

bcftools call -Ov -v -m piledup_5a.bcf > allpiledup_5a.vcf

bcftools call -Ov -v -m allpiledup_5e.bcf > allpiledup_5e.vcf

bcftools call -Ov -v -m allpiledup_5f.bcf > allpiledup_5f.vcf

Step 3-

note: bcftools has to be installed in the working directory to make it works

cat allpiledup_5a.vcf|/home/deakig/usr/bin/vcfutils.pl varFilter -d100 > flt_alpiledup_5a.vcf

cat allpiledup_5e.vcf|/home/deakig/usr/bin/vcfutils.pl varFilter -d100 > flt_alpiledup_5e.vcf

cat allpiledup_5f.vcf|/home/deakig/usr/bin/vcfutils.pl varFilter -d100 > flt_alpiledup_5f.vcf
