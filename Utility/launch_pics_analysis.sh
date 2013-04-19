#!/bin/bash

treatment=$1
control=$2
dir_output=$3
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
dir_scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
prefix=$(basename ${treatment%.*})

mkdir -p $dir_output

output=$dir_output/$prefix

if [ -e "$control" ]
then
	Rscript $dir_scripts/PICS_ctrl.R $treatment $control $prefix
else
	Rscript $dir_scripts/PICS.R $treatment $prefix
fi
