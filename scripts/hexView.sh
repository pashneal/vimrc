#!/bin/bash
v=$1
# Delete garbage at front, then at end
v=$( echo $v | perl -pe 's/[^\dxb]*([\dxb])/$1/')
v=$( echo $v | perl -pe 's/(0x|0b)?([\da-fA-F]*).*$/$1$2/')

# find the numerical representation
num=$(echo $v | perl -pe 's/0x|0b//')
base=10
# Hexadecimal
if [[ $v =~ 0x ]]
then
  base=16
# Binary
elif [[ $v =~ 0b ]]
then
  base=2
fi
/home/neal/.vim/scripts/bitboardViewer.cpp.out $num $base
