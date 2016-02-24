#!/bin/bash
FILE=$1
exec 3<&0
exec 0<$FILE
while read line
do
	echo $line
done
exec 0<&3
