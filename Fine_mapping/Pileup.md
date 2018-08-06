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
cat test2allpiledup.vcf|/home/deakig/usr/bin/vcfutils.pl varFilter -d100 > flt_test2allpiledup.vcf
