#!/bin/bash
CWD="$(pwd)"
PGD="/galaxy-central/tools/mmuphin"
feature_abd=$1
batch=$2
covariates=$3
data=$4
output1=$5
output2=$6

Rscript ${PGD}/mmuphin_wrapper.R \
    -f $feature_abd \
    -b $batch \
    -c $covariates \
    -d $data \
    -o $output1  
    
cp "CRC_abd_adj.csv"  $output1
cp "adjust_batch_diagnostic.pdf" $output2
