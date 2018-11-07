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


## All rootstocks piledup - small regions of each chromosome are piled up and variant calling has been done in each region and then regions can be merged in order to have the whole chromosome

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
```bash
samtools mpileup -o piledup_11a.bcf -r Chr11:1-8000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_11b.bcf -r Chr11:8000001-16000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_11c.bcf -r Chr11:16000001-24000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_11d.bcf -r Chr11:24000001-32000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_11e.bcf -r Chr11:32000001-40000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_11f.bcf -r Chr11:40000001-43059885 -uf
/home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```

```bash
samtools mpileup -o piledup_13a.bcf -r Chr13:1-8000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_13b.bcf -r Chr13:8000001-16000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_13c.bcf -r Chr13:16000001-24000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_13d.bcf -r Chr13:24000001-32000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_13e.bcf -r Chr13:32000001-40000000 -uf /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```
```bash
samtools mpileup -o piledup_13f.bcf -r Chr13:40000001-44339518 -uf
/home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m27/m27_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m116/m116_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m9/m9_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/m13/m13_sorted.bam
/home/groups/harrisonlab/project_files/root_architecture/genome_alignment/mm106/mm106_sorted.bam
```

Step 2-now concatenate the files per chromosome

note: bcftools new version installed in my folder, to use this updated version add the full path: /home/magdac/prog/bcftools-1.8/bcftools

```bash
/home/magdac/prog/bcftools-1.8/bcftools concat piledup_5a.bcf piledup_5b.bcf piledup_5c.bcf piledup_5d.bcf piledup_5e.bcf piledup_5f.bcf > chromosome5new.bcf

/home/magdac/prog/bcftools-1.8/bcftools concat piledup_11a.bcf piledup_11b.bcf piledup_11c.bcf piledup_11d.bcf piledup_11e.bcf piledup_11f.bcf > chromosome11.bcf

/home/magdac/prog/bcftools-1.8/bcftools concat piledup_13a.bcf piledup_13b.bcf piledup_13c.bcf piledup_13d.bcf piledup_13e.bcf piledup_13f.bcf > chromosome13.bcf
```

Step 3- variant calling

/home/magdac/prog/bcftools-1.8/bcftools call -Ov -v -m chromosome5new.bcf > chromosome5new.vcf

/home/magdac/prog/bcftools-1.8/bcftools call -Ov -v -m chromosome11.bcf > chromosome11.vcf

/home/magdac/prog/bcftools-1.8/bcftools call -Ov -v -m chromosome13.bcf > chromosome13.vcf

Step 4- filter variants

cat chromosome5new.vcf|/home/deakig/usr/bin/vcfutils.pl varFilter -d100 > flt_chromosome5.vcf

cat chromosome11.vcf|/home/deakig/usr/bin/vcfutils.pl varFilter -d100 > flt_chromosome11.vcf

cat chromosome13.vcf|/home/deakig/usr/bin/vcfutils.pl varFilter -d100 > flt_chromosome13.vcf
