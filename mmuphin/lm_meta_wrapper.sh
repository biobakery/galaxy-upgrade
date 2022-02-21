#!/bin/bash
CWD="$(pwd)"
PGD="/galaxy-central/tools/mmuphin"
feature_abd=$1
batch=$2
covariates=$3
data=$4
exposure=$5
output1=$6

Rscript ${PGD}/lm_meta_wrapper.R \
    -f $feature_abd \
    -b $batch \
    -c $covariates \
    -d $data \
    -e $exposure 
    
cp "meta_fits.csv" $output1
