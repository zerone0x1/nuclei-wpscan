#!/bin/bash
target=$1
mkdir $1
cd $1
subfinder -d $1 -all -recursive > subdomains.txt
httpx -td -ms WordPress -l subdomains.txt | sed -e 's/\s.*$//' >wp-subdomains.txt
nuclei -l /home/learn/Desktop/BUG/$1/wp-subdomains.txt   -tags wordpress,cve,default-logins > nuclei-output.txt
cat wp-subdomains.txt  | while true ; do read url; if [ "" = "$url" ] ; then break; fi ; wpscan  --url $url --wp-content-dir wp-content --disable-tls-checks --api-token atlVtOgihVsFcdPZSixJLlJb1CIuh0po8OPdhsV7YVk  --force ; done >>wpscan-out.txt
