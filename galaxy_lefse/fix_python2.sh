#!/bin/bash
FILES=$1
for f in $FILES
do
	2to3 -w $f
	autopep8 --in-place --aggressive --aggressive  $f
done
