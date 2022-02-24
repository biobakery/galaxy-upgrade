#!/bin/bash
X=$1
Y=$2
m=$3
output1=$4
output2=$5

Outlocation=$(mktemp -d)
<<<<<<< HEAD
halla -x $X -y $Y -m $m -o halla_output
cp halla_output/hallagram.pdf $output1

zip -r  $Outlocation/Halla_Results.zip halla_output
cp  $Outlocation/halla_output/Halla_Results.zip  $output2
=======
Outlocation2=$(mktemp -d)
echo $Outlocation
echo $Outlocation2
halla -x $X -y $Y -m $m -o ${Outlocation}/halla_output
cp $Outlocaion/halla_output/hallagram.pdf $output1

zip -r  $Outlocation2/Halla_Results.zip $Outlocation/halla_output
cp  $Outlocation2/halla_output/Halla_Results.zip  $output2
>>>>>>> 80b527cc1ccc981fd3e7c70555c70a949fe78caa
