#!/bin/bash
red=`tput setaf 1 `
yellow=`tput setaf 3`
 
if [ "$1" == "" ]
then
    echo "Please insert domain"
    echo "Usemode: $0 domain"
else
    wget -q  $1  -O temp.html
    grep href temp.html | cut -d "/" -f3 | grep "\." | cut -d '"' -f1  | grep -v ":" |  grep -v "<" > list.txt


    rm temp.html 
    
    echo "$yellow========================================================"
    echo " Resolving subdomains, please wait..."
    echo "$yellow========================================================"
    echo -n "$red"    
    for url in $(cat list.txt | uniq  ); 

    do host $url | grep "has address" | sed 's/has address/->/g'; done       
    echo "          resolution ended       "    
    rm list.txt
     
fi 
