#!/bin/bash
taxonomy=$1
metadata=$2
output1=$3
output2=$4
outlocation=$(mktemp -d)
outlocation2=$(mktemp -d)
Rscript /galaxy-central/tools/maaslin/Maaslin2/R/Maaslin2.R $taxonomy $metadata $outlocation\
        --transform=AST \
        --fixed_effects="diagnosis,dysbiosisnonIBD;dysbiosisUC,dysbiosisCD;antibiotics,age" \
        --random_effects="site,subject"\
        --normalization=NONE \
        --standardize=FALSE\
        --reference="diagnosis,nonIBD"
cp Rplots.pdf $output1
zip -r  $outlocation2/Maaslin2_Results.zip  $outlocation
cp  $outlocation2/Maaslin2_Results.zip  $output2
rm -r $outlocation
rm -r $outlocation2
