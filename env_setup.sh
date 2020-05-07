#!/bin/bash

work_dir=$pwd

if [ -d "impacket-0.9.21" ]; then
	rm -rf impacket-0.9.21
fi

# start
if [ -f "impacket.tar.gz" ]; then
	tar -xvf impacket.tar.gz
	cd impacket-0.9.21
	pip3 install .
fi

path=\"\$PATH:$work_dir/impacket/examples/\"

if ! grep -q "$path" ~/.bashrc; then
	echo "Adding impacket to PATH"
	echo "export PATH=$path" | tee -a ~/.bashrc
	source ~/.bashrc
fi
