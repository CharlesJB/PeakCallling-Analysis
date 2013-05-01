#!/bin/bash

treatment=$1
control=$2
dir_output=$3
options=""
for i in $(seq 4 $#)
do
	toEval="options+=\" \"\$$i"
	eval $toEval
done

prefix=$(basename ${treatment%.*})

mkdir -p $dir_output

output=$dir_output/$prefix

macs2 callpeak $options -t $treatment -c $control -f BAM -g hs -n $output
