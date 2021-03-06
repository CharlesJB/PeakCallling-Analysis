#!/bin/bash

treatment=$1
control=$2
dir_output=$3
prefix=$(basename ${treatment%.*})
options=""
for i in $(seq 3 $#)
do
	toEval="options+=\" \"\$$i"
	eval $toEval
done

mkdir -p $dir_output

output=$dir_output/$prefix

macs14 $options -t $treatment -c $control -f BAM -g hs -n $output
