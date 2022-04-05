#!/bin/bash
Infile=$1
Pangenome=$2
output1=$3
output2=$4
Outlocation=$(mktemp -d)
mkdir $Outlocation/map_results
TD="/galaxy-central/tools/panphlan/panphlan"
myFileSizeCheck=$(stat -c %s $Infile)
Thresh=4194304
if (( $myFileSizeCheck > $Thresh )); then
    exit 9
fi



python ${TD}/panphlan_map.py -i ${Infile} \
                         --indexes ${TD}/${Pangenome}/${Pangenome} \
                         -p ${TD}/${Pangenome}/${Pangenome}_pangenome.tsv \
                         -o ${Outlocation}/map_results/Results.tsv
cp ${Outlocation}/map_results/Results.tsv $output1
 
rm -r $Outlocation
