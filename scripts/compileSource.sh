#!/bin/bash
v=$1
if [ ${v: -3} = ".py" ]
then
	python3 $v
elif [ ${v: -2} = ".c" ] 
then
	g++ -std=c++11 $v -Wall -g -o $v.out && ./$v.out
elif [ ${v: -4} = ".cpp" ] 
then
	g++ -std=c++11 $v -Wall -g -o $v.out && ./$v.out
elif [ ${v: -3} = ".sh" ]
then
	bash $v
elif [  ${v: -4} = ".lua" ]
then 
	love .
fi

