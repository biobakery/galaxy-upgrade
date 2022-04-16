#!/bin/bash
Infile=$1
output1=$2
output2=$3
Outlocation=$(mktemp -d)
mkdir $Outlocation/map_results
TD="/galaxy-central/tools/panphlan/panphlan"
myFileSizeCheck=$(stat -c %s $Infile)
Thresh=4194304
if (( $myFileSizeCheck > $Thresh )); then
    exit 9
fi
Pangenome="Eubacterium_rectale"


python ${TD}/panphlan_map.py -i ${Infile} \
                         --indexes ${TD}/${Pangenome}/${Pangenome} \
                         -p ${TD}/${Pangenome}/${Pangenome}_pangenome.tsv \
                         -o ${Outlocation}/map_results/Results.tsv
cp ${Outlocation}/map_results/Results.tsv $output1
 
rm -r $Outlocation
