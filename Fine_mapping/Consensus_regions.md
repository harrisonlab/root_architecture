
### Split bam files by chromosomes and index them

samtools view m9_sorted.bam Chr05 -b > m9chr5sorted.bam

samtools view mm106_sorted.bam Chr05 -b > mm106chr5sorted.bam

samtools view m116_sorted.bam Chr05 -b > m116chr5sorted.bam

samtools view m27_sorted.bam Chr05 -b > m27chr5sorted.bam

samtools index m116chr5sorted.bam


### Alignment divided in smaller sections and indexed

samtools view m9_sorted.bam Chr05:40000000-47952461 -b > m9chr5sectionsorted.bam

samtools view mm106_sorted.bam Chr05:40000000-47952461 -b > mm106chr5sectionsorted.bam

samtools view m116_sorted.bam Chr05:36000000-43000000 -b > m116chr5sectionsorted.bam

samtools view m27merged_sorted.bam Chr05:40000000-47952461 -b > m27chr5sectionsorted.bam

samtools index m116chr5sectionsorted.bam

samtools view m9_sorted.bam Chr05:40000000-47952461 -b > m9chr5section2.bam


### Extract sections from the genome alignment in Chr11


samtools view m9_sorted.bam Chr11:6000000-11000000 -b > m9chr11sectionsorted.bam

samtools view m116_sorted.bam Chr11:6000000-11000000 -b > m116chr11sectionsorted.bam

samtools view m27_sorted.bam Chr11:6000000-11000000 -b > m27chr11sectionsorted.bam

samtools index m116chr11sectionsorted.bam


### Extract sections from the genome alignment in Chr13


samtools view m9_sorted.bam Chr13:2000000-3000000 -b > m9chr13sectionsorted.bam

samtools view m116_sorted.bam Chr13:2000000-3000000 -b > m116chr13sectionsorted.bam

samtools view m27_sorted.bam Chr13:2000000-3000000 -b > m27chr13sectionsorted.bam

### Different section in Chr13 - Section b

samtools view m9_sorted.bam Chr13:0-3000000 -b > m9chr13sectionBsorted.bam

samtools view m116_sorted.bam Chr13:0-3000000 -b > m116chr13sectionBsorted.bam

samtools view m27_sorted.bam Chr13:0-3000000 -b > m27chr13sectionBsorted.bam

samtools index m116chr11sectionsorted.bam



### Extract consensus sequence form alignment bam file

samtools mpileup -uf reference.fa aligment.bam | bcftools view -cg - | vcfutils vcf2fq

Get consensus fastq file

samtools mpileup -uf REFERENCE.fasta SAMPLE.bam | bcftools call -c | vcfutils.pl vcf2fq > SAMPLE_cns.fastq

Convert .fastq to .fasta and set bases of quality lower than 20 to N

seqtk seq -aQ64 -q20 -n N SAMPLE_cns.fastq > SAMPLE_cns.fasta

bedtools bamtobed -i $INPUT_BAM > $OUTPUT_BED

bedtools getfasta -fi $INPUT_FASTA -bed $INPUT_BED -fo $OUTPUT_FASTA

Then I try this

samtools mpileup -uf /Apple_genome/GDDH13_1-1_formatted.fasta /genome_alignment/m116/m116_sorted.bam | bcftools view -cg - | /home/deakig/usr/bin/vcfutils.pl vcf2fq

samtools mpileup -uf /Apple_genome/GDDH13_1-1_formatted.fasta /genome_alignment/m116/m116_sorted.bam | bcftools call -c | vcfutils.pl vcf2fq > m116_cns.fastq

bedtools bamtobed -i m116_sorted.bam > m116.sorted.bed

bedtools getfasta -fi  -bed $INPUT_BED -fo $OUTPUT_FASTA
