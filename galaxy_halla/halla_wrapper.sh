#!/bin/bash
X=$1
Y=$2
m=$3
output1=$4
output2=$5

Outlocation=$(mktemp -d)
Outlocation2=$(mktemp -d)

halla -x $X -y $Y -m $m -o $Outlocation
cp ${Outlocation}/hallagram.pdf $output1

zip -r  $Outlocation2/Halla_Results.zip  $Outlocation
cp  $Outlocation2/Halla_Results.zip  $output2

###rm -r $Outlocation