
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 4
#$ -l h_vmem=3G
#$ -l h=blacklace01.blacklace|blacklace03.blacklace|blacklace05.blacklace|blacklace06.blacklace|blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace|blacklace12.blacklace

#Script will phase diploid genotypes in a given VCF file.
#Output: VCF file with phased genotypes with the suffix "_haplo"

input=$1
pedigree=$2
output=${input%.vcf}_haplo
#java=/home/sobczm/bin/jre1.8.0_101/bin/java
beagle=/home/gomeza/prog/beagle/beagle.r1399.jar

java -jar $beagle gt=$input ped=$pedigree out=$output ibd=true
