#!/bin/bash
foo=$1
if [ $((foo%2)) -eq 0 ];
then
		echo "Sleep time"
	else 
		echo "Heh?"
fi
