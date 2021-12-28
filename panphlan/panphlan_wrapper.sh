#!/bin/bash
Infile=$1
Pangenome=$2
output1=$3
Outlocation=$(mktemp -d)
mkdir $Outlocation/map_results
TD="/galaxy-central/tools/panphlan/panphlan"
python ${TD}/panphlan_map.py -i ${Infile} \
                         --indexes ${TD}/${Pangenome}/${Pangenome} \
                         -p ${TD}/${Pangenome}/${Pangenome}_pangenome.tsv \
                         -o ${Outlocation}/map_results/Results.tsv
cp ${Outlocation}/map_results/Results.tsv $output1
rm -r $Outlocation