#!/bin/bash
ip=$1
awk '{print $1}' $ip | sort | uniq -c | sort
