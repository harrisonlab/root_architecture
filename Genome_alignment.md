

Run BWA-mem

```bash
Reference=$(ls /data/scratch/gomeza/apple_genome/GDDH13_1-1_formatted.fasta)
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

```bash
Reference=$(ls /data/scratch/gomeza/apple_genome/GDDH13_1-1_formatted.fasta)
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

```bash
Reference=$(ls /data/scratch/gomeza/apple_genome/GDDH13_1-1_formatted.fasta)
for CultivarPath in $(ls -d /home/groups/harrisonlab/project_files/rootstock_genetics/m13/conc); do
Cultivar=$(echo $CultivarPath | rev | cut -f2 -d '/' | rev)
echo $Cultivar
ReadsF=$(ls $CultivarPath/m13_r1.fq.trim.filtered.fq)
ReadsR=$(ls $CultivarPath/m13_r1.fq.trim.filtered.fq)
OutDir=genome_alignment/m13/
ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/genome_alignment/bwa
qsub $ProgDir/sub_bwa.sh $Cultivar $Reference $ReadsF $ReadsR $OutDir
done
```
