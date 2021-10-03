#!/bin/bash
v=$1
if [ ${v: -3} = ".py" ]
then
	python3 $v
elif [ ${v: -2} = ".c" ] 
then
	g++ -std=c++11 $v -Wall -g -o $v.out && ./$v.out
elif [ ${v: -3} = ".rs" ]
then
  echo ""
  echo ""
  echo "Trying cargo build..."
  a=$(cargo build | grep "could not find") 
  if [[ $a == "" ]]
  then
    cargo run
  else
    echo ""
    echo ""
    echo "Trying RustC compiler"
    rustc $v && ./${v%.rs}
  fi
elif [ ${v: -4} = ".cpp" ] 
then
	g++ -std=c++11 $v -Wall -g -o $v.out && ./$v.out
elif [ ${v: -3} = ".sh" ]
then
	bash $v
elif [  ${v: -4} = ".lua" ]
then 
	love .
elif [ ${v: -3} = ".pl" ]
then
	perl $v
elif [ ${v: -3} = ".ly" ]
then
	lilypond --pdf -o $v $v && xdg-open $v.pdf
fi

