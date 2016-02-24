#!/bin/bash
FILE=$1
exec 3<&0
exec 0<$FILE
while read line
	do
		if grep -w "HEAD" && grep -v "GET"
			then
	        echo $line
	    fi   
done
exec 0<&3