#!/bin/bash
FILE=$1
while read line
do
if [[ 'grep 'HEAD' $1' ]]; then
	echo $line |  grep -q "HEAD"  
	grep -o -c HEAD
fi
done <$1

FILE=$1
while read line
do
if [[ 'grep 'GET' $1' ]]; then
	echo $line |  grep -q "GET"  
		grep -o -c GET 
fi
done <$1