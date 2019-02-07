# Select genes under Root Bark QTLs

### QTL1genes contains ID name of genes under QTL1 in chromosome 5

for query in $(cat /home/groups/harrisonlab/project_files/root_architecture/QTLs_genes/QTL1genes.txt); do
echo $query
query_mod=${query::-1}
echo $query_mod
grep “$query_mod” /home/groups/harrisonlab/project_files/root_architecture/QTLs_genes/interpro_1v1.txt
done > matched.txt

### Not using echo I will obtain only one line per gene ID

for query in $(cat QTL1genes.txt); do
#echo $query
query_mod=${query::-1}
#echo $query_mod
grep "$query_mod" interpro_1v1.txt
done > matched.txt
