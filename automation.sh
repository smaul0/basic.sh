#!/bin/bash

echo "   ______                                      _  ";
echo "  / _____)                                    | | ";
echo " ( (____    _____ _ ____ _   _______   _   _  | | ";
echo "  \____ \  |  ___   ____  | | |___| | | | | | | | ";
echo "  _____) | | |   | |    | | |  ___  | | |_| | | | ";
echo " (______/  |_|   |_|    |_| |_|   |_|  \___/  |_| ";



if [[ $# -eq 0 ]] ; then
    printf '\nNo URL  Given!'
    printf '\n\nUsage: ./automation.sh domain.com\n\n'
    exit 0
fi

#create folder
mkdir -p $1
cd $1

#subdomain-enum
subfinder -d $1 -o subfinder.txt
sublist3r -d $1 -o sublist3r.txt
amass enum -d $1 -o amass.txt
assetfinder --subs-only $1 >>assetfinder.txt
findomain -t $1 -u findomain.txt 
crobat -s $1 >> crobat.txt
cat subfinder.txt sublist3r.txt amass.txt assetfinder.txt findomain.txt crobat.tx>
cat sub.txt | sort -u | tee unique_sub.txt
rm sub.txt

#archive url and reflected param
cat unique_sub.txt | gau -o gau.txt
cat gau.txt | gf xss |uro | Gxss -p xss -o reflected_param.txt

#httpx
cat unique_sub.txt | httpx -silent -title -status-code -tech-detect -o httpx.txt

#nuclei
cat unique_sub.txt | nuclei -rl 15 -o nuclei.txt

