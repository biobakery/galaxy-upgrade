#!/bin/bash
X=$1
Y=$2
m=$3
output1=$4
output2=$5

Outlocation=$(mktemp -d)
halla -x $X -y $Y -m $m -o halla_output
cp halla_output/hallagram.pdf $output1

zip -r  $Outlocation/Halla_Results.zip halla_output
cp  $Outlocation/halla_output/Halla_Results.zip  $output2
