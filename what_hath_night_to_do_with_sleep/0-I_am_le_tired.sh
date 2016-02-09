#!/bin/bash
mytime="$(time ( sleep $1 ) 2>&1 1>/dev/null )"
echo "$mytime"
