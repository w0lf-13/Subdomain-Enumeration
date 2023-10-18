#!/bin/bash
# Author: w0lf-13
# Twitter: https://twitter.com/__mohammed_a_

eco -e """

░██╗░░░░░░░██╗░█████╗░██╗░░░░░███████╗░░░░░░░░███╗░░██████╗░
░██║░░██╗░░██║██╔══██╗██║░░░░░██╔════╝░░░░░░░████║░░╚════██╗
░╚██╗████╗██╔╝██║░░██║██║░░░░░█████╗░░█████╗██╔██║░░░█████╔╝
░░████╔═████║░██║░░██║██║░░░░░██╔══╝░░╚════╝╚═╝██║░░░╚═══██╗
░░╚██╔╝░╚██╔╝░╚█████╔╝███████╗██║░░░░░░░░░░░███████╗██████╔╝
░░░╚═╝░░░╚═╝░░░╚════╝░╚══════╝╚═╝░░░░░░░░░░░╚══════╝╚═════╝░
           Subdomains Enumeration Tool
              By: w0lf-13 @__mohammed_a_
"""

echo "[+]------ Starting Subdomain Enumeration ------[+]"

echo "[+] Subfinder Running [+]"
subfinder -d $1 | tee -a subdomain.txt

echo "[+] Assetfinder Running [+]"
assetfinder -subs-only $1 | tee -a subdomain.txt

echo "[+] Sublist3r Running [+]"
sublist3r -d $1 | tee -a subdomain.txt

echo "[+] crt.sh Running [+]"
curl 'https://crt.sh/?q=%.'$1'&output=json' | jq -r '.[].name_value' | grep -v '*' | sort | uniq | tee -a subdomain.txt

echo "[+] Knockpy Running [+]"
knockpy $1 --silent | tee -a subdomain.txt

echo "[+] Wayback Running [+]"
curl -sk "http://web.archive.org/cdx/search/cdx?url=*.$domain&output=txt&fl=original&collapse=urlkey&page=" | awk -F/ '{gsub(/:.*/, "", $3); print $3}' | sort -u | tee -a subdomain.txt

echo "[+] Amass Passive Mode Running [+]"

amass enum --passive -d $1 | tee -a subdomain.txt

echo "[+] Removing Duplicates [+]"
sort -u subdomain.txt | uniq | tee -a all-sub.txt
rm subdomain.txt

echo "[+] Checking for alive domains.. [+]"
cat all-sub.txt | httpx -fr -silent | tee live-domain.txt


echo "[-] Done [-]"