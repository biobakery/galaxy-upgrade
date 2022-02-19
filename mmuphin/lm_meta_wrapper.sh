#!/bin/bash
CWD="$(pwd)"
PGD="/galaxy-central/tools/mmuphin"
feature_abd=$1
batch=$2
exposure=$3
covariates=$4
data=$5
output1=$6

Rscript ${PGD}/lm_meta_wrapper.R \
    -f $feature_abd \
    -b $batch \
    -c $covariates \
    -d $data \
    -e $exposure 
    
#cp "CRC_abd_adj.Rda"  $output1
#cp "adjust_batch_diagnostic.pdf" $output2
