#!/bin/bash
X=$1
Y=$2
m=$3
output1=$4
output2=$5

halla -x $X -y $Y -m $m -o halla_output
cp halla_output/hallagram.pdf $output1

zip -r  Halla_Results.zip halla_output
cp halla_output/Halla_Results.zip  $output2
