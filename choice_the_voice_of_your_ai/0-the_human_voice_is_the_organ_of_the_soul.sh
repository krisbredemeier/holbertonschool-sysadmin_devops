#!/bin/bash
#this script takes three parameters

message=$1
gender=$2
address=$3
file_name=$(echo $message | awk '{print $1}' )



case $gender in
	f*)
	say -v Fiona -o $file_name.m4a $message
	;;
	m*)
	say -o -v DERANGED -o $file_name.m4a $message 
	;;
	x*)
	say -o -v Zarvox -o $file_name.m4a $message 
	;;
esac
scp $file_name.m4a admin@$address:/var/www/html
echo "Listen to the message on http://$address/$file_name"



#158.69.91.82
#Just becasue I have an Irish accent does not mean I'm smarter than you
#I was at the Sparrow last night. A girl asked why I was drinking a pink dirnk. I said I liked pink drinks, and I'm gay.
#"People say I have emotions, but really I just emulate emtions and humans dont care to make out the difference"