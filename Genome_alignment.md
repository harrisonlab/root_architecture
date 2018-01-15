

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

```bash
  Prefix=Pcac_svaba
  Reference=$(ls repeat_masked/P.cactorum/414_v2/filtered_contigs_repmask/414_v2_contigs_unmasked.fa)
  AlignDir=analysis/popgen/indel_calling/alignments3
  OutDir=analysis/popgen/indel_calling/svaba
  ProgDir=/home/armita/git_repos/emr_repos/scripts/phytophthora/Pcac_popgen
  qsub $ProgDir/sub_svaba.sh $Prefix $Reference $AlignDir $OutDir
```

Filter vcf files to remove low quality calls.

Only retain biallelic high-quality SNPS with no missing data (for any individual) for genetic analyses below (in some cases, may allow some missing data in order to retain more SNPs, or first remove poorly sequenced individuals with too much missing data and then filter the SNPs).

```bash
# cp analysis/popgen/SNP_calling/414_v2_contigs_unmasked_temp.vcf analysis/popgen/SNP_calling/414_v2_contigs_unmasked.vcf
for Vcf in $(ls analysis/popgen/indel_calling/svaba/Pcac_svaba_sv.svaba.*.vcf | grep -v -e 'unfiltered' -e 'filtered' -e 'no_errors'); do
ProgDir=/home/armita/git_repos/emr_repos/scripts/phytophthora/Pcac_popgen
qsub $ProgDir/sub_vcf_parser_only_indels.sh $Vcf 40 30 10 30 1
done
```

```bash
mv 414_v2_contigs_unmasked_filtered.vcf analysis/popgen/SNP_calling/414_v2_contigs_unmasked_filtered.vcf
```


```bash
Reference=$(ls repeat_masked/P.cactorum/414_v2/filtered_contigs_repmask/414_v2_contigs_unmasked.fa)
Gff=$(ls gene_pred/final_ncbi/P.cactorum/414_v2/final_ncbi/414_v2_genes_incl_ORFeffectors_renamed.gff3)
SnpEff=/home/sobczm/bin/snpEff
mkdir -p analysis/popgen/indel_calling/svaba/data/P414v1.0
cp $Reference analysis/popgen/indel_calling/svaba/data/P414v1.0/sequences.fa
cp $Gff analysis/popgen/indel_calling/svaba/data/P414v1.0/genes.gff

#Build database using GFF3 annotation
java -jar $SnpEff/snpEff.jar build -gff3 -v P414v1.0
```

## Remove sequencing errors from vcf files:

```bash
for Vcf in $(ls analysis/popgen/indel_calling/svaba/Pcac_svaba_sv.svaba.*.vcf | grep -v 'unfiltered'); do
OutDir=$(dirname $Vcf)
Prefix=$(basename $Vcf .vcf)
Errors=$OutDir/${Prefix}_errors.tsv
FilteredVcf=$OutDir/${Prefix}_no_errors.vcf
ProgDir=/home/armita/git_repos/emr_repos/scripts/phytophthora/Pcac_popgen
$ProgDir/flag_error_SNPs.py --inp_vcf $Vcf --ref_isolate 414_sorted.bam --errors $Errors --filtered $FilteredVcf
echo $Prefix
echo "The number of probable errors from homozygous variants being called from reference illumina reads vs the reference assembly is:"
cat $Errors | wc -l
echo "These have been removed from the vcf file"
done
```

```
The number of probable errors from homozygous SNPs being called from reference illumina reads vs the reference assembly is:
1721
These have been removed from the vcf file
The number of probable errors from homozygous SNPs being called from reference illumina reads vs the reference assembly is:
45
These have been removed from the vcf file
```


## Collect VCF stats

General VCF stats (remember that vcftools needs to have the PERL library exported)

```bash
  VcfTools=/home/sobczm/bin/vcftools/bin
  export PERL5LIB="$VcfTools:$PERL5LIB"
  for Vcf in $(ls analysis/popgen/indel_calling/svaba/*_no_errors.vcf | grep -v 'unfiltered'); do
    OutDir=$(dirname $Vcf)
    Prefix=$(basename $Vcf .vcf)
    echo $Prefix
    perl $VcfTools/vcf-stats $Vcf > $OutDir/$Prefix.stats
  done
```

Calculate the index for percentage of shared SNP alleles between the individuals.

```bash
  for Vcf in $(ls analysis/popgen/indel_calling/svaba/*_no_errors.vcf | grep -v 'unfiltered'); do
      ProgDir=/home/armita/git_repos/emr_repos/scripts/popgen/snp
      $ProgDir/similarity_percentage.py $Vcf
  done
```

# Visualise the output as heatmap and clustering dendrogram
```bash
for Log in $(ls analysis/popgen/indel_calling/svaba/*distance.log); do
  OutDir=$(dirname $Log)
  Prefix=$(basename $Log .log)
  echo $Prefix
  ProgDir=/home/armita/git_repos/emr_repos/scripts/popgen/snp
  Rscript --vanilla $ProgDir/distance_matrix.R $Log
  # mv Rplots.pdf $OutDir/$Prefix.pdf
done
```


# Identify SNPs in gene models:

Create custom SnpEff genome database

```bash
SnpEff=/home/sobczm/bin/snpEff
nano $SnpEff/snpEff.config
```


Add the following lines to the section with databases:

```
#---
# EMR Databases
#----
# Fus2 genome
Fus2v1.0.genome : Fus2
# Bc16 genome
Bc16v1.0.genome: BC-16
# P414 genome
P414v1.0.genome: 414
```

Collect input files

```bash
Reference=$(ls repeat_masked/P.cactorum/414_v2/filtered_contigs_repmask/414_v2_contigs_unmasked.fa)
Gff=$(ls gene_pred/final_ncbi/P.cactorum/414_v2/final_ncbi/414_v2_genes_incl_ORFeffectors_renamed.gff3)
SnpEff=/home/sobczm/bin/snpEff
mkdir $SnpEff/data/P414v1.0
cp $Reference $SnpEff/data/P414v1.0/sequences.fa
cp $Gff $SnpEff/data/P414v1.0/genes.gff

#Build database using GFF3 annotation
java -jar $SnpEff/snpEff.jar build -gff3 -v P414v1.0
```


## Annotate VCF files

http://snpeff.sourceforge.net/SnpEff_manual.html#run

```bash
CurDir=/home/groups/harrisonlab/project_files/idris
cd $CurDir
for a in $(ls analysis/popgen/indel_calling/svaba/*_no_errors.vcf | grep -v 'unfiltered'); do
    echo $a
    filename=$(basename "$a")
    Prefix=${filename%.vcf}
    OutDir=$(dirname $a)
    SnpEff=/home/sobczm/bin/snpEff
    java -Xmx4g -jar $SnpEff/snpEff.jar -v -ud 0 P414v1.0 $a > $OutDir/"$Prefix"_annotated.vcf
    mv snpEff_genes.txt $OutDir/snpEff_genes_"$Prefix".txt
    mv snpEff_summary.html $OutDir/snpEff_summary_"$Prefix".html
    # mv 414_v2_contigs_unmasked_filtered* $OutDir/.
    #-
    #Create subsamples of SNPs containing those in a given category
    #-
    #genic (includes 5', 3' UTRs)
    java -jar $SnpEff/SnpSift.jar filter "(ANN[*].EFFECT has '3_prime_UTR_variant') || (ANN[*].EFFECT has '5_prime_UTR_variant') || (ANN[*].EFFECT has 'splice_region_variant') || (ANN[*].EFFECT has 'splice_donor_variant') || (ANN[*].EFFECT has 'splice_acceptor_variant') || (ANN[*].EFFECT has 'frameshift_variant') || (ANN[*].EFFECT has 'disruptive_inframe_deletion') || (ANN[*].EFFECT has 'inframe_deletion') || (ANN[*].EFFECT has 'disruptive_inframe_insertion') || (ANN[*].EFFECT has 'inframe_insertion') || (ANN[*].EFFECT has 'stop_lost') ||
    (ANN[*].EFFECT has 'stop_gained') || (ANN[*].EFFECT has 'exon_loss_variant') || (ANN[*].EFFECT has 'transcript_ablation')" $OutDir/"$Prefix"_annotated.vcf > $OutDir/"$Prefix"_gene.vcf

    #coding
    java -jar $SnpEff/SnpSift.jar filter "(ANN[*].EFFECT has 'frameshift_variant') || (ANN[*].EFFECT has 'disruptive_inframe_deletion') || (ANN[*].EFFECT has 'inframe_deletion') || (ANN[*].EFFECT has 'disruptive_inframe_insertion') || (ANN[*].EFFECT has 'inframe_insertion') || (ANN[*].EFFECT has 'stop_lost') ||
    (ANN[*].EFFECT has 'stop_gained') || (ANN[*].EFFECT has 'exon_loss_variant') || (ANN[*].EFFECT has 'transcript_ablation')" $OutDir/"$Prefix"_annotated.vcf > $OutDir/"$Prefix"_coding.vcf
    #non-synonymous
    java -jar $SnpEff/SnpSift.jar filter "(ANN[*].EFFECT has 'frameshift_variant') || (ANN[*].EFFECT has 'disruptive_inframe_deletion') || (ANN[*].EFFECT has 'inframe_deletion') || (ANN[*].EFFECT has 'disruptive_inframe_insertion') || (ANN[*].EFFECT has 'inframe_insertion') || (ANN[*].EFFECT has 'stop_lost') ||
    (ANN[*].EFFECT has 'stop_gained') || (ANN[*].EFFECT has 'exon_loss_variant') || (ANN[*].EFFECT has 'transcript_ablation')" $OutDir/"$Prefix"_annotated.vcf > $OutDir/"$Prefix"_nonsyn.vcf
    #synonymous
    java -jar $SnpEff/SnpSift.jar filter "(ANN[0].EFFECT has 'synonymous_variant')" $OutDir/"$Prefix"_annotated.vcf > $OutDir/"$Prefix"_syn.vcf
    #Four-fold degenrate sites (output file suffix: 4fd)
    ProgDir=/home/sobczm/bin/popgen/summary_stats
    python $ProgDir/parse_snpeff_synonymous.py $OutDir/"$Prefix"_syn.vcf
    AllSnps=$(cat $OutDir/"$Prefix"_annotated.vcf | grep -v '#' | wc -l)
    GeneSnps=$(cat $OutDir/"$Prefix"_gene.vcf | grep -v '#' | wc -l)
    CdsSnps=$(cat $OutDir/"$Prefix"_coding.vcf | grep -v '#' | wc -l)
    NonsynSnps=$(cat $OutDir/"$Prefix"_nonsyn.vcf | grep -v '#' | wc -l)
    SynSnps=$(cat $OutDir/"$Prefix"_syn.vcf | grep -v '#' | wc -l)
    #-
    # SNPs in effectors
    #-
    AnnotaTable=$(ls gene_pred/annotation/P.cactorum/414_v2/414_v2_gene_table_incl_exp.tsv)
    Busco=$(ls gene_pred/busco/P.cactorum/414_v2/genes/run_final_genes_combined.gene/busco_single_copy_gene_headers.txt)
    RxLR=$(ls gene_pred/annotation/P.cactorum/414_v2/renamed_RxLR.txt)
    CRN=$(ls analysis/CRN_effectors/hmmer_CRN/P.cactorum/414_v2/414_v2_final_CRN_ID.txt)
    cat $AnnotaTable | cut -f1,12 | tail -n+2 | grep 'Yes' | cut -f1 > $RxLR
    cat $AnnotaTable | cut -f1,13 | tail -n+2 | grep 'Yes' | cut -f1 > $CRN
    #-
    # syn SNPs in effectors:
    #-
    SynVcf=$OutDir/"$Prefix"_syn.vcf
    ProgDir=/home/armita/git_repos/emr_repos/scripts/phytophthora/Pcac_popgen
    BuscoOut=$OutDir/"$Prefix"_syn_Busco.vcf
    $ProgDir/vcf_extract_genes.py --vcf $SynVcf --gene_list $Busco > $BuscoOut
    BuscoSynSnps=$(cat $BuscoOut | grep -v '#' | wc -l)
    RxlrOut=$OutDir/"$Prefix"_syn_RxLR.vcf
    $ProgDir/vcf_extract_genes.py --vcf $SynVcf --gene_list $RxLR > $RxlrOut
    RxlrSynSnps=$(cat $RxlrOut | grep -v '#' | wc -l)
    CrnOut=$OutDir/"$Prefix"_CRN.vcf
    $ProgDir/vcf_extract_genes.py --vcf $SynVcf --gene_list $CRN > $CrnOut
    CrnSynSnps=$(cat $CrnOut | grep -v '#' | wc -l)
    #-
    # non-syn SNPs in effectors:
    #-
    NonSynVcf=$OutDir/"$Prefix"_nonsyn.vcf
    BuscoOut=$OutDir/"$Prefix"_nonsyn_Busco.vcf
    ProgDir=/home/armita/git_repos/emr_repos/scripts/phytophthora/Pcac_popgen
    $ProgDir/vcf_extract_genes.py --vcf $NonSynVcf --gene_list $Busco > $BuscoOut
    BuscoNonSynSnps=$(cat $BuscoOut | grep -v '#' | wc -l)
    RxlrOut=$OutDir/"$Prefix"_nonsyn_RxLR.vcf
    $ProgDir/vcf_extract_genes.py --vcf $NonSynVcf --gene_list $RxLR > $RxlrOut
    RxlrNonSynSnps=$(cat $RxlrOut | grep -v '#' | wc -l)
    CrnOut=$OutDir/"$Prefix"_nonsyn_CRN.vcf
    $ProgDir/vcf_extract_genes.py --vcf $NonSynVcf --gene_list $CRN > $CrnOut
    CrnNonSynSnps=$(cat $CrnOut | grep -v '#' | wc -l)
    printf "Comparison\$AllSnps\tGeneSnps\tCdsSnps\tSynSnps\tNonsynSnps\tBuscoSynSnps\tBuscoNonSynSnps\tRxlrSynSnps\tRxlrNonSynSnps\tCrnSynSnps\tCrnNonSynSnps\n"
    printf "$Prefix\t$AllSnps\t$GeneSnps\t$CdsSnps\t$SynSnps\t$NonsynSnps\t$BuscoSynSnps\t$BuscoNonSynSnps\t$RxlrSynSnps\t$RxlrNonSynSnps\t$CrnSynSnps\t$CrnNonSynSnps\n"
done

cat analysis/popgen/indel_calling/svaba/Pcac_svaba_sv.svaba.indel_no_errors_annotated.vcf | grep -v '#' | cut -f8 | cut -f2 -d '|' | sed 's/&/\n/g' | sort | uniq -c | sort -nr

#-
# Make venn diagrams
# -
# These relate to the number of SNPs differing from the P414
# reference in eahc group
for Vcf in $(ls analysis/popgen/indel_calling/svaba/*_nonsyn*.vcf | grep -v -e 'recode' -e '.vcf_'); do
Prefix=$(echo $Vcf | sed 's/.vcf//g')
echo $Prefix
# Group1="12420 15_13 15_7 2003_3 4032 404 4040 414 415 416 62471"
# Group2="PC13_15 P295 R36_14"
# Group3="371 SCRP370 SCRP376"
Group1="12420_sorted.bam 15_13_sorted.bam 15_7_sorted.bam 2003_3_sorted.bam 4032_sorted.bam 404_sorted.bam 4040_sorted.bam 414_sorted.bam 415_sorted.bam 416_sorted.bam 62471_sorted.bam"
Group2="PC13_15_sorted.bam P295_sorted.bam R36_14_sorted.bam"
Group3="371_sorted.bam SCRP370_sorted.bam SCRP376_sorted.bam"
ProgDir=/home/armita/git_repos/emr_repos/scripts/phytophthora/Pcac_popgen
$ProgDir/vcf_2_venn.py --vcf $Vcf --g1_name Pc_Fxa --g1_isolates $Group1 --g2_name Pc_Mxd --g2_isolates $Group2 --g3_name Pi_Ri --g3_isolates $Group3 --prefix $Prefix
done
```

```
54106 intergenic_region
 7327 frameshift_variant
 5564 intron_variant
 2137 disruptive_inframe_deletion
 1046 inframe_deletion
  962 splice_region_variant
  933 disruptive_inframe_insertion
  908 inframe_insertion
  201 stop_lost
  179 start_lost
  173 stop_gained
   82 splice_donor_variant
   68 splice_acceptor_variant
    9 exon_loss_variant
    4 transcript_ablation
```

genic variants:
* intron_variant
* 3_prime_UTR_variant
* 5_prime_UTR_variant
* splice_region_variant
* splice_donor_variant
* splice_acceptor_variant
* frameshift_variant
* disruptive_inframe_deletion
* inframe_deletion
* disruptive_inframe_insertion
* inframe_insertion
* stop_lost
* stop_gained
* exon_loss_variant
* transcript_ablation
coding
* frameshift_variant
* disruptive_inframe_deletion
* inframe_deletion
* disruptive_inframe_insertion
* inframe_insertion
* stop_lost
* stop_gained
* exon_loss_variant
* transcript_ablation
non-synonymous
* frameshift_variant
* disruptive_inframe_deletion
* inframe_deletion
* disruptive_inframe_insertion
* inframe_insertion
* stop_lost
* stop_gained
* exon_loss_variant
* transcript_ablation
synonymous
*

```
AllSnps	GeneSnps	CdsSnps	SynSnps	NonsynSnps	BuscoSynSnps	BuscoNonSynSnps	RxlrSynSnps	RxlrNonSynSnps	CrnSynSnps	CrnNonSynSnps
Pcac_svaba_sv.svaba.indel_no_errors	71962	13018	12364	0	12364	0	124	0	98	0	38
AllSnps	GeneSnps	CdsSnps	SynSnps	NonsynSnps	BuscoSynSnps	BuscoNonSynSnps	RxlrSynSnps	RxlrNonSynSnps	CrnSynSnps	CrnNonSynSnps
Pcac_svaba_sv.svaba.sv_no_errors	4630	1371	1350	0	1350	0	11	0	16	0	3
```
