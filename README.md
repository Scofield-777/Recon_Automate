# Recon Automation Script

This Bash script automates the reconnaissance process for discovering subdomains and conducting port scanning for a given domain.

## Necessary Tools 
amass:
```bash
GO111MODULE=on go get -v github.com/OWASP/Amass/v3/...
```
#### assetfinder:
```bash
go get -u github.com/tomnomnom/assetfinder
```
#### subfinder:
```bash
GO111MODULE=on go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
```
#### httprobe (part of gobuster package):
```bash
GO111MODULE=on go get -u github.com/tomnomnom/httprobe
```
#### nmap:
```bash
sudo apt update
sudo apt install nmap
```

## Usage

1. Ensure you have the necessary tools installed: `amass`, `assetfinder`, `subfinder`, `httprobe`, and `nmap`.
2. Clone or download this repository to your local machine.
3. Open a terminal and navigate to the directory containing the script.
4. Run the script using the following command:

   ```bash
   ./Recon_Automation.sh <domain>
Replace <domain> with the target domain you want to perform reconnaissance on.

## Explanation
This script automates the following steps:

1. Subdomain enumeration using amass, assetfinder, and subfinder.
2. Consolidation of gathered subdomains into a single file.
3. Filtering out fourth-level domains and extracting third-level domains.
4. Checking the availability of third-level domains using httprobe.
5. Initiating an aggressive NMAP port scan (T5) on the alive domains.

## Example
Perform reconnaissance on the domain example.com:

```bash
Copy code
./Recon_Automation.sh example.com
```
## Disclaimer
This script is provided for educational purposes only. Reconnaissance activities should only be performed on systems and networks that you have explicit permission to target. Unauthorized scanning may violate laws and terms of service agreements. Use this script responsibly and at your own risk.
