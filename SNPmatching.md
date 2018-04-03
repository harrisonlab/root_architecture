Commands to extract SNPs 

```bash
#to merge the files
cat hk2.txt lm2.txt np2.txt > mergedsnp2.txt
#to select the SNPs which are present in mergesnp.txt
grep -w -f SNPv1fitered.txt mergedsnp2.txt > matchedsnp2.txt
#to cut the column 1 which has the RBsnp name
cut -f1 matchedsnp2.txt > matchedsnpfiltered2.txt
# to select the snp matching on the gff file
grep -f matchedsnpfiltered2.txt GD3gff.txt > gffmatched2.gff
```
