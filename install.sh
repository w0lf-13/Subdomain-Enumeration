#!/bin/bash

sudo apt update -y && sudo apt upgrade -y
sudo apt install subfinder
sudo apt install knockpy
sudo apt install amass
sudo apt install assetfinder
sudo apt install sublist3r

wget https://github.com/projectdiscovery/httpx/releases/download/v1.3.5/httpx_1.3.5_linux_amd64.zip
unzip httpx_1.3.5_linux_amd64.zip
chmod +x httpx
sudo mv httpx /usr/bin

rm LICENSE.md README.md httpx_1.3.5_linux_amd64.zip
