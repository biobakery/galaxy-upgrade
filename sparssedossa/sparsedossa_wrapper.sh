#!/bin/bash
template=$1
n_sample=$2
n_feature=$3
output1=$4
output2=$5
output3=$6
CWD="$(pwd)"
PGD="/galaxy-central/tools/sparsedossa"


Rscript ${PGD}/sparsedossa_wrapper.R \
        -t $1 \
        -s $2 \
        -f $3 \
        -d ${CWD}
cp $CWD/simulated_data.csv ${output1}
cp $CWD/simulated_matrices.csv ${output2}
cp $CWD/Simulation.RData ${output3}