# Select genes under Root Bark QTLs

#QTL1genes contains ID name of genes under QTL1 in chromosome 5

Note:Not using echo I will obtain only one line per gene ID

for query in $(cat QTL1genes.txt); do
#echo $query
query_mod=${query::-1}
#echo $query_mod
grep "$query_mod" interpro_1v1.txt
done > matched.txt

#QTL2genes contains ID name of genes under QTL2 in chromosome 11

for query in $(cat QTL2genes.txt); do
echo $query
query_mod=${query::-1}
echo $query_mod
grep "$query_mod" interpro_1v1.txt
done > matched2.txt

#QTL3genes contains ID name of genes under QTL3 in chromosome 13

for query in $(cat QTL3genes.txt); do
echo $query
query_mod=${query::-1}
echo $query_mod
grep "$query_mod" interpro_1v1.txt
done > matched3.txt
