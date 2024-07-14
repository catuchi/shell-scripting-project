#!/bin/bash

# This script installs git depending on your operating system

echo "script to install git"

if [ "$(uname)" == "Linux" ]; then
	echo "Installing git for Linux"
	yum install git -y
elif [ "$(uname)" == "Darwin" ]; then
	echo "Installing git for MacOS"
	brew install git
else
	echo "not installing"
fi
