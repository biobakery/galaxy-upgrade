#!/bin/bash
CWD="$(pwd)"
PGD="/galaxy-central/tools/mmuphin"
feature_abd=$1
data=$2
batch=$3
exposure=$4
covariates=$5
output1=$6
echo "Feature_abd" $feature_abd
echo "Batch" $batch
echo "Covariates" $covariates
echo  "Data" $data
echo "Exposure"  $exposure
echo  "Output1" $output1

Rscript ${PGD}/lm_meta_wrapper.R \
    -f $feature_abd \
    -d $data\
    -b $batch\
    -e $exposure\
    -c $covariates
    
cp "meta_fits.csv" $output1
