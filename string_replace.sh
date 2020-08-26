#!/bin/bash
# This script needs two arguments: the newString is used to replace oldString.
# example: ./string_replace.sh 0 ch8

echo "Total arguments : $#"
echo "oldString = $1"
echo "newString = $2"

sed -i "1,10000s/$1/$2/g" *.tex
