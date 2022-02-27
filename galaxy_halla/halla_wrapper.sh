#!/bin/bash
X=$1
Y=$2
m=$3
output1=$4
output2=$5
fnr_thresh=$6
fdr_alpha=$7


cmd="halla -x $X -y $Y -m $m -o halla_output"

if  !  [ -z "$fnr_thresh" ]
then
     cmd="$cmd  --fnr_thresh $fnr_thresh"
fi

if !  [  -z "$fdr_alpha" ]
then
     cmd="$cmd  --fdr_alpha $fdr_alpha"
fi

eval $cmd


cp halla_output/hallagram.pdf $output1

zip -r  Halla_Results.zip halla_output
cp  Halla_Results.zip  $output2
