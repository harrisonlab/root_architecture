

Run BWA-mem

```bash
#CurDir=$PWD
Reference=$(ls GCA_002114115.1_ASM211411v1/GCA_002114115.1_ASM211411v1_genomic.fna)
for StrainPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m9/conc); do
Strain=$(echo $StrainPath | rev | cut -f2 -d '/' | rev)
#Organism=$(echo $StrainPath | rev | cut -f2 -d '/' | rev)
echo $Strain
#echo $Organism
ReadsF=$(ls $StrainPath/m9_r1.fq.trim.f.filtered.fq)
ReadsR=$(ls $StrainPath/m9_r2.fq.trim.r.filtered.fq)
#ConcatTmpDir=tmp_concat_dir
#mkdir -p $ConcatTmpDir
#ConcatF=$ConcatTmpDir/"$Strain"_F_reads.fq.gz
#ConcatR=$ConcatTmpDir/"$Strain"_R_reads.fq.gz
# cat $ReadsF > $ConcatF
# cat $ReadsR > $ConcatR
OutDir=genome_alignment/m9/
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Strain $Reference $ReadsF $ReadsR $OutDir
done
```


```bash
Reference=$(ls GCA_002114115.1_ASM211411v1/GCA_002114115.1_ASM211411v1_genomic.fna)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m27/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
#Organism=$(echo $StrainPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/m27_r1.fq.trim.f.filtered.fq)
ReadsR=$(ls $CultivarPath/m27_r2.fq.trim.r.filtered.fq)
OutDir=genome_alignment/m27/
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```

```bash
Reference=$(ls GCA_002114115.1_ASM211411v1/GCA_002114115.1_ASM211411v1_genomic.fna)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m116/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
#Organism=$(echo $StrainPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/phix_filtered.1)
ReadsR=$(ls $CultivarPath/phix_filtered.2)
OutDir=genome_alignment/m116/
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```
