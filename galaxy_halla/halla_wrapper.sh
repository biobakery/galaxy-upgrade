#!/bin/bash
X=$1
Y=$2
m=$3
output1=$4
output2=$5
fnr_thresh=$6
fdr_alpha=$7

halla -x $X -y $Y -m $m -o halla_output --fnr_thresh $fnr_thresh --fdr_alpha $fdr_alpha
cp halla_output/hallagram.pdf $output1

zip -r  Halla_Results.zip halla_output
cp  Halla_Results.zip  $output2
