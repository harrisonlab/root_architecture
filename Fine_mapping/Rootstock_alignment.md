

# Rootstocks alignment

### Fastaqc and trim  were done by Greg.

$ROOTSTOCK was set to the directory contain the rootstock project (~/projects/apple_rootstock/rootstock_genetics)
Folders for each rootstock was created in the rootstock_genetics folder
Data was unzipped and concatenated into R1 and R2 files in the subdirectory conc within each rootstock folder
eg:
```bash
gunzip *
cat 863_LIB6292_LDI5172_GTGAAA_L00*_R1.fastq.gz >m27_r1.fa
```
### Fastaqc was run on each pair of reads in order to assess the quality

```shell
nohup fastqc m116_r1.fq m116_r2.fq &
nohup fastqc m27_r1.fq m27_r2.fq &
nohup fastqc m9_r1.fq m9_r2.fq &
nohup fastqc m13_r1.fq m13_r2.fq &
nohup fastqc mm106_r1.fq mm106_r2.fq &
nohup fastqc gala_r1.fq gala_r2.fq &
nohup fastqc o3_r1.fq o3_r2.fq &
 ```

### Trimming was performed with fastq-mcf (o3 is SE) to remove adaptors and low quality Reads

```shell
cd $ROOTSTOCK/rootstock_genetics

for d in [mg]*;
 do
  $ROOTSTOCK/scripts/fastq-mcf.sh $ROOTSTOCK/rootstock_genetics/$d/conc/${d}_r1.fq $ROOTSTOCK/rootstock_genetics/$d/conc/${d}_r2.fq $ROOTSTOCK/rootstock_genetics/$d/conc/  
 done

$ROOTSTOCK/scripts//fastq-mcf.sh $ROOTSTOCK/rootstock_genetics/o3/conc/o3_r1.fq  $ROOTSTOCK/rootstock_genetics/o3/conc/
 ```

### PhiX removal in M27, M9 and M116
PhiX removal in these rootstocks was done with bowtie
M116 does not have PhiX - same size after running this

```shell
cd $ROOTSTOCK/rootstock_genetics

for d in [mg]*;
do
 $ROOTSTOCK/scripts/bowtie.sh $ROOTSTOCK/rootstock_genetics/$d/conc/${d}_r1.fq.trim $ROOTSTOCK/rootstock_genetics/$d/conc/${d}_r2.fq.trim /home/groups/harrisonlab/ref_genomes/phix/phix $ROOTSTOCK/rootstock_genetics/$d/conc/ phix_filtered 250 500
done

./bowtie_se.sh $ROOTSTOCK/rootstock_genetics/o3/conc/o3_r1.fq.trim /home/groups/harrisonlab/ref_genomes/phix/phix $ROOTSTOCK/rootstock_genetics/o3/conc/ phix_filtered
```

### PhiX removal in M13, Gala and MM106 was done with a different program
Why do we used a different program?
The program used for phix filtering is called bbduk (version 37.77) (https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/bbduk-guide/) which is part of the very useful bbtools package.
The command line used to run bbduk was:

```bash
bbduk.sh \
          in1=forward_read  \
          in2=reverse_read \
          out1=forward_out.gz \
    out2=reverse_out.gz \
    ref=phix_174.fa \
    stats=stats.out \
    k=31 \
    hdist=1
 ```

The k=31 and hdist=1 are the only two settings which were not the defaults – this and the version number should probably go in the methods.
The files will be named e.g. /home/groups/harrisonlab/project_files/rootstock_genetics/gala/conc/gala_r2.fq.trim.filtered.fq.gz
The files are compressed so may need to gunzip them first before doing anything else with them.
In each conc directory there are also a new stats directory which tells how much phix was found and removed


## Run BWA-mem to do the alignment of each rootstock genome with the new version of the Golden Delicious genome, version 3

```bash
Reference=$(ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m9/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/m9_r1.fq.trim.f.filtered.fq)
ReadsR=$(ls $CultivarPath/m9_r2.fq.trim.r.filtered.fq)
OutDir=genome_alignment/m9/
mkdir -p $OutDir
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```

```bash
Reference=$(ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m116/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/phix_filtered.1)
ReadsR=$(ls $CultivarPath/phix_filtered.2)
OutDir=genome_alignment/m116/
mkdir -p $OutDir
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```

```bash
Reference=$(ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/mm106/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/mm106_r1.fq.trim.filtered.fq)
ReadsR=$(ls $CultivarPath/mm106_r2.fq.trim.filtered.fq)
OutDir=genome_alignment/mm106/
mkdir -p $OutDir
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```
Repeated in Oct 2018

```bash
Reference=$(ls /ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m13/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/m13_r1.fq.trim.filtered.fq)
ReadsR=$(ls $CultivarPath/m13_r2.fq.trim.filtered.fq)
OutDir=genome_alignment/m13/
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```
Repeated in Oct 2018

```bash
Reference=$(ls /ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/gala/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/gala_r1.fq.trim.filtered.fq)
ReadsR=$(ls $CultivarPath/gala_r2.fq.trim.filtered.fq)
OutDir=genome_alignment/m13/
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```

```bash
Reference=$(ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m27/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/m27_r1.fq.trim.f.filtered.fq)
ReadsR=$(ls $CultivarPath/m27_r2.fq.trim.r.filtered.fq)
OutDir=genome_alignment/m27/
mkdir -p $OutDir
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```

### m27 is not working
Could be something related to running fastqc

Run a test with just a few reads and see if the problem is still happening

```bash
Reference=$(ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m27/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/m27_25k_sample.f.fq)
ReadsR=$(ls $CultivarPath/m27_25k_sample.r.fq)
OutDir=genome_alignment/testm27/
mkdir -p $OutDir
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```
It worked so  I am going to repeat the same with more reads until see where the error occurs

```bash
Reference=$(ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m27/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/m27_100K_sample.f.fq)
ReadsR=$(ls $CultivarPath/m27_100K_sample.r.fq)
OutDir=genome_alignment/test2m27/
mkdir -p $OutDir
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```
The subset of reads works fine but when I did the full alignment didn't work and looks like a memory problem. I have increased the memory on the script and I am going to repeat it. Now using the script in my folder called sub_bwa2.sh with increased free memory (to 4G) and -R y to book the blacklaces 11

```bash
Reference=$(ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m27/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/m27_r1.fq.trim.f.filtered.fq)
ReadsR=$(ls $CultivarPath/m27_r2.fq.trim.r.filtered.fq)
OutDir=genome_alignment/m27/
mkdir -p $OutDir
ProgDir=/home/magdac/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub -R y $ProgDir/sub_bwa2.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```

Looks like the alignment is working but not the sorting so I am going to split the job in two parts: first genome alignment (I have alterted the script just to do the alignment)

```bash
Reference=$(ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m27/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/m27_r1.fq.trim.f.filtered.fq)
ReadsR=$(ls $CultivarPath/m27_r2.fq.trim.r.filtered.fq)
OutDir=genome_alignment/m27alignment/
mkdir -p $OutDir
ProgDir=/home/magdac/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub -R y $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```
Try with less memory and more blacklaces - altered the script just to do the alingmentq
```bash
Reference=$(ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m27/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/m27_r1.fq.trim.f.filtered.fq)
ReadsR=$(ls $CultivarPath/m27_r2.fq.trim.r.filtered.fq)
OutDir=genome_alignment/m27justalignment/
mkdir -p $OutDir
ProgDir=/home/magdac/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub -R y $ProgDir/sub_bwa2.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```
This is to split the reads file into smaller files in order to do severals jobs and then merge then
This is splitting the file in 40millions reads files and then there is a loop to rename the files

```bash
OutDir=/home/groups/harrisonlab/project_files/root_architecture
mkdir -p $OutDir/split_reads/F
split -l 40000000 m27_r1.fq.trim.f.filtered.fq $OutDir/split_reads/F/m27_F_trim_split

OutDir=/home/groups/harrisonlab/project_files/root_architecture
mkdir -p $OutDir/split_reads/R
split -l 40000000 m27_r2.fq.trim.r.filtered.fq $OutDir/split_reads/R/m27_R_trim_split

cd $OutDir
for File in $(ls -d split_reads/F/*); do
  NewName="${File}".fq
  mv $File $NewName
done

cd $OutDir
for File in $(ls -d split_reads/R/*); do
  NewName="${File}".fq
  mv $File $NewName
done
```

Then do the alignment of each batch of data

```bash
Reference=$(ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/root_architecture/split_reads); do
#Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
Cultivar=m27a
echo $Cultivar
ReadsF=$(ls $CultivarPath/F/m27_F_trim_splitaa.fq)
ReadsR=$(ls $CultivarPath/R/m27_R_trim_splitaa.fq)
OutDir=genome_alignment/m27split/
mkdir -p $OutDir
ProgDir=/home/magdac/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```

```bash
Reference=$(ls /home/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/root_architecture/split_reads); do
#Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
Cultivar=m27v
echo $Cultivar
ReadsF=$(ls $CultivarPath/F/m27_F_trim_splitav.fq)
ReadsR=$(ls $CultivarPath/R/m27_R_trim_splitav.fq)
OutDir=genome_alignment/m27split/
mkdir -p $OutDir
ProgDir=/home/magdac/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```
22 alignment have been done in total, then all the files will be merged using samtools merge


samtools merge m27merged_sorted.bam m27a_sorted.bam m27b_sorted.bam m27c_sorted.bam m27d_sorted.bam m27e_sorted.bam m27f_sorted.bam m27g_sorted.bam m27h_sorted.bam m27i_sorted.bam m27j_sorted.bam m27k_sorted.bam m27l_sorted.bam m27m_sorted.bam m27n_sorted.bam m27o_sorted.bam m27p_sorted.bam m27q_sorted.bam m27r_sorted.bam m27s_sorted.bam m27t_sorted.bam m27u_sorted.bam m27v_sorted.bam

Then the sorted file has to be indexed using

samtools index -b m27merged_sorted.bam m27merged_sorted.bai

It didn't work properly

### Change the header in order to have only one file and index again

samtools view -H m27merged_sorted.bam > header.sam
sed "s/SM\:m27[a-v]/m27/" header.sam > new_header.sam
samtools reheader new_header.sam m27merged_sorted.bam

samtools index -b m27merged_sorted.bam m27merged_sorted.bai

# All alignments were done again without qsub (AGomez) M27 works

This work was performed in the directory: /home/groups/harrisonlab/project_files/root_architecture

Raw reads were trimmed and phiX filtered (done by Greg)

## Data organisation

Data was compressed and copied from the rootstock_genetics folder to a local directory genome aligment using bwa.

```bash
gzip -c ../rootstock_genetics/m27/conc/m27_r1.fq.trim.f.filtered.fq > m27_r1.fq.trim.f.filtered.fq.gz
gzip -c ../rootstock_genetics/m27/conc/m27_r2.fq.trim.r.filtered.fq > m27_r2.fq.trim.r.filtered.fq.gz
gzip -c ../rootstock_genetics/gala/conc/gala_r1.fq.trim.filtered.fq > gala_r1.fq.trim.filtered.fq.gz
gzip -c ../rootstock_genetics/gala/conc/gala_r2.fq.trim.filtered.fq > gala_r2.fq.trim.filtered.fq.gz
gzip -c ../rootstock_genetics/m13/conc/m13_r1.fq.trim.filtered.fq > m13_r1.fq.trim.filtered.fq.gz
gzip -c ../rootstock_genetics/m13/conc/m13_r2.fq.trim.filtered.fq > m13_r2.fq.trim.filtered.fq.gz
gzip -c ../rootstock_genetics/mm106/conc/mm106_r1.fq.trim.filtered.fq > mm106_r1.fq.trim.filtered.fq.gz
gzip -c ../rootstock_genetics/mm106/conc/mm106_r2.fq.trim.filtered.fq > mm106_r2.fq.trim.filtered.fq.gz
gzip -c ../rootstock_genetics/m9/conc/m9_r1.fq.trim.f.filtered.fq > m9_r1.fq.trim.f.filtered.fq.gz
gzip -c ../rootstock_genetics/m9/conc/m9_r2.fq.trim.r.filtered.fq > m9_r2.fq.trim.r.filtered.fq.gz
gzip -c ../rootstock_genetics/m116/conc/phix_filtered.1 > m116_r1.fq.trim.f.filtered.fq.gz
gzip -c ../rootstock_genetics/m116/conc/phix_filtered.2 > m116_r2.fq.trim.r.filtered.fq.gz

mv m27_r1.fq.trim.f.filtered.fq.gz MC/genome_alignment/bwa/m27
mv m27_r2.fq.trim.r.filtered.fq.gz MC/genome_alignment/bwa/m27
mv gala_r1.fq.trim.filtered.fq.gz MC/genome_alignment/bwa/gala
mv gala_r2.fq.trim.filtered.fq.gz MC/genome_alignment/bwa/gala
mv m13_r1.fq.trim.filtered.fq.gz MC/genome_alignment/bwa/m13
mv m13_r2.fq.trim.filtered.fq.gz MC/genome_alignment/bwa/m13
mv mm106_r1.fq.trim.filtered.fq.gz MC/genome_alignment/bwa/mm106
mv mm106_r2.fq.trim.filtered.fq.gz MC/genome_alignment/bwa/mm106
mv m9_r1.fq.trim.f.filtered.fq.gz MC/genome_alignment/bwa/m9
mv m9_r2.fq.trim.r.filtered.fq.gz MC/genome_alignment/bwa/m9
mv m116_r1.fq.trim.f.filtered.fq.gz MC/genome_alignment/bwa/m116
mv m116_r2.fq.trim.r.filtered.fq.gz MC/genome_alignment/bwa/m116
```

## Genome alignment

For some reason qsub bwa failed sorting the aligments, possibly due a lack of memory caused by the big file sizes.  

```bash
#Reference=apple_genome/GDDH13_1-1_formatted.fasta
#ReadsF=m27_r1.fq.trim.f.filtered.fq.gz
#ReadsR=m27_r2.fq.trim.r.filtered.fq.gz
#OutDir=Magda/genome_alignment/m27
#mkdir -p $OutDir
#ProgDir=/home/gomeza/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
#qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
```

These aligments requires a lot of memory. Ideally they should run in blacklace11.
This is not always possible, so I would recommend qlogin in a worker node (1,6-9) using the maximum number of threads allowed.

```bash
screen -a
qlogin -pe smp 24 -l virtual_free=1G

### M27 (Run each step command separated)
#1st
Prefix=m27
Assembly=apple_genome/GDDH13_1-1_formatted.fasta
F_reads=m27_r1.fq.trim.f.filtered.fq.gz
R_reads=m27_r2.fq.trim.r.filtered.fq.gz
OutDir=genome_alignment/bwa/m27
bwa index $Assembly
#2nd
bwa mem -M -t 12 $Assembly $F_reads $R_reads | samtools view -S -b - > "$Prefix".bam
### Add group and sample name (Prefix)
#3rd
bamaddrg -b "$Prefix".bam -s $Prefix -r $Prefix > "$Prefix"_unsorted.bam
### Sort the full BAM file.
#4th
samtools sort -@ 16  "$Prefix"_unsorted.bam -o "$Prefix"_sorted.bam
### index
#5th
samtools index "$Prefix"_sorted.bam
```

```bash
###  GALA (Run each step command separate)
#1st
Prefix=gala
Assembly=apple_genome/GDDH13_1-1_formatted.fasta
F_reads=MC/genome_alignment/bwa/gala/gala_r1.fq.trim.filtered.fq.gz
R_reads=MC/genome_alignment/bwa/gala/gala_r2.fq.trim.filtered.fq.gz
OutDir=genome_alignment/bwa/gala
#bwa index $Assembly
#2nd
bwa mem -M -t 12 $Assembly $F_reads $R_reads | samtools view -S -b - > "$Prefix".bam
### Add group and sample name (Prefix)
#3rd
bamaddrg -b "$Prefix".bam -s $Prefix -r $Prefix > "$Prefix"_unsorted.bam
### Sort the full BAM file.
#4th
samtools sort -@ 16  "$Prefix"_unsorted.bam -o "$Prefix"_sorted.bam
### index
#5th
samtools index "$Prefix"_sorted.bam
```

```bash
### M13 (Run each step command separate)
#1st
Prefix=m13
Assembly=apple_genome/GDDH13_1-1_formatted.fasta
F_reads=MC/genome_alignment/bwa/m13/m13_r1.fq.trim.filtered.fq.gz
R_reads=MC/genome_alignment/bwa/m13/m13_r2.fq.trim.filtered.fq.gz
OutDir=genome_alignment/bwa/gala
#bwa index $Assembly
#2nd
bwa mem -M -t 12 $Assembly $F_reads $R_reads | samtools view -S -b - > "$Prefix".bam
### Add group and sample name (Prefix)
#3rd
bamaddrg -b "$Prefix".bam -s $Prefix -r $Prefix > "$Prefix"_unsorted.bam
### Sort the full BAM file.
#4th
samtools sort -@ 16  "$Prefix"_unsorted.bam -o "$Prefix"_sorted.bam
### index
#5th
samtools index "$Prefix"_sorted.bam
```

```bash
### MM106 (Run each step command separate)
#1st
Prefix=mm106
Assembly=apple_genome/GDDH13_1-1_formatted.fasta
F_reads=MC/genome_alignment/bwa/mm106/mm106_r1.fq.trim.filtered.fq.gz
R_reads=MC/genome_alignment/bwa/mm106/mm106_r2.fq.trim.filtered.fq.gz
#bwa index $Assembly
#2nd
bwa mem -M -t 12 $Assembly $F_reads $R_reads | samtools view -S -b - > "$Prefix".bam
### Add group and sample name (Prefix)
#3rd
bamaddrg -b "$Prefix".bam -s $Prefix -r $Prefix > "$Prefix"_unsorted.bam
### Sort the full BAM file.
#4th
samtools sort -@ 16  "$Prefix"_unsorted.bam -o "$Prefix"_sorted.bam
### index
#5th
samtools index "$Prefix"_sorted.bam
```

```bash
### M9 (Run each step command separate)
#1st
Prefix=m9
Assembly=apple_genome/GDDH13_1-1_formatted.fasta
F_reads=MC/genome_alignment/bwa/m9/m9_r1.fq.trim.f.filtered.fq.gz
R_reads=MC/genome_alignment/bwa/m9/m9_r2.fq.trim.r.filtered.fq.gz
#bwa index $Assembly
#2nd
bwa mem -M -t 12 $Assembly $F_reads $R_reads | samtools view -S -b - > "$Prefix".bam
### Add group and sample name (Prefix)
#3rd
bamaddrg -b "$Prefix".bam -s $Prefix -r $Prefix > "$Prefix"_unsorted.bam
### Sort the full BAM file.
#4th
samtools sort -@ 16  "$Prefix"_unsorted.bam -o "$Prefix"_sorted.bam
### index
#5th
samtools index "$Prefix"_sorted.bam
```

```bash
### M116 (Run each step command separate)
#1st
Prefix=m116
Assembly=apple_genome/GDDH13_1-1_formatted.fasta
F_reads=MC/genome_alignment/bwa/m116/m116_r1.fq.trim.f.filtered.fq.gz
R_reads=MC/genome_alignment/bwa/m116/m116_r2.fq.trim.r.filtered.fq.gz
#bwa index $Assembly
#2nd
bwa mem -M -t 12 $Assembly $F_reads $R_reads | samtools view -S -b - > "$Prefix".bam
### Add group and sample name (Prefix)
#3rd
bamaddrg -b "$Prefix".bam -s $Prefix -r $Prefix > "$Prefix"_unsorted.bam
### Sort the full BAM file.
#4th
samtools sort -@ 16  "$Prefix"_unsorted.bam -o "$Prefix"_sorted.bam
### index
#5th
samtools index "$Prefix"_sorted.bam
```
