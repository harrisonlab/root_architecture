
### Split bam files by chromosomes and index them

samtools view m9_sorted.bam Chr05 -b > m9chr5sorted.bam

samtools view mm106_sorted.bam Chr05 -b > mm106chr5sorted.bam

samtools view m116_sorted.bam Chr05 -b > m116chr5sorted.bam

samtools view m27merged_sorted.bam Chr05 -b > m27chr5sorted.bam

samtools index m27chr5sorted.bam

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
