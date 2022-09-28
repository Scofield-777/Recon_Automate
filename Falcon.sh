#!/bin/bash

echo "  █████▒▄▄▄       ██▓     ▄████▄   ▒█████   ███▄    █ 
▓██   ▒▒████▄    ▓██▒    ▒██▀ ▀█  ▒██▒  ██▒ ██ ▀█   █ 
▒████ ░▒██  ▀█▄  ▒██░    ▒▓█    ▄ ▒██░  ██▒▓██  ▀█ ██▒
░▓█▒  ░░██▄▄▄▄██ ▒██░    ▒▓▓▄ ▄██▒▒██   ██░▓██▒  ▐▌██▒
░▒█░    ▓█   ▓██▒░██████▒▒ ▓███▀ ░░ ████▓▒░▒██░   ▓██░
 ▒ ░    ▒▒   ▓▒█░░ ▒░▓  ░░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒ 
 ░       ▒   ▒▒ ░░ ░ ▒  ░  ░  ▒     ░ ▒ ▒░ ░ ░░   ░ ▒░
 ░ ░     ░   ▒     ░ ░   ░        ░ ░ ░ ▒     ░   ░ ░ 
             ░  ░    ░  ░░ ░          ░ ░           ░ 
                         ░                            "

if [ $# -gt 2]; then
    echo "Syntax: ./Recon_Automation.sh domain"
    echo "Common Example: ./Recon_Automation.sh tesla.com"
    exit 1
fi
echo "[+] Running Recon Automation [+]"
pwd=$(pwd)
mkdir $1
echo "[+]Sub-Domain Enumeration with AMASS"
amass enum -passive -d $1 > $1/Gathered_Subdomains_List.txt
echo "[+]Sub-Domain Enumeration Complete with AMASS"
echo "[+]Sub-Domain Enumeration with Assetfinder"
assetfinder $1 > $1/Gathered_Subdomains_List_Assetfinder.txt
echo "[+]Sub-Domain Enumeration Complete with Assetfinder"
echo "[+]Sub-Domain Enumeration with Subfinder"
subfinder -d $1 --silent > $1/Gathered_Subdomains_List_Subfinder.txt
echo "[+]Sub-Domain Enumeration Complete with Subfinder"
cat $1/Gathered_Subdomains_List.txt > Ready_for_Compilation_list.txt
cat $1/Gathered_Subdomains_List_Assetfinder.txt >> Ready_for_Compilation_list.txt
cat $1/Gathered_Subdomains_List_Subfinder.txt >> Ready_for_Compilation_list.txt
cat $1/Ready_for_Compilation_list.txt | sort -u >> Final_Compilation_list.txt
echo "[+] Final List of Sub Domains is complete."
cat Final_Compilation_list.txt | grep -Po '(\w+\.\w+\.\w+)$' | sort -u >> Extracted_Third_level_Domains.txt

echo "[+]Checking Alive Third-Level Domains....."
cat Extracted_Third_level_Domains.txt | sort -u |httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ":443" > Alive_Domains.txt
echo "[+] HTTP Probing Complete."

cat Alive_Domains.txt | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ":443" > httprobe_done.txt
echo "[+] Initiating NMAP scan for Open Ports....."
#nmap -iL Alive_Domains.txt -T5 -oA scans -vv