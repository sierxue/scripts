#!/bin/bash
# This script needs two arguments: the newString is used to replace oldString.
# example: ./rename.sh 0 ch8

echo "Total arguments : $#"
echo "oldString = $1"
echo "newString = $2"

for i in *.tex; do mv $i $(echo $i | sed "s/$1/$2/g"); done # 2019/10/28
