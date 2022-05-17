#!/bin/bash
input=$1
myFileSizeCheck=$(stat -c %s $input) &&
Thresh=4194304 
if (( $myFileSizeCheck > $Thresh )); then
            exit 9
fi 
