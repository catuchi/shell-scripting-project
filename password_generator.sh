#!/bin/bash

source validate.sh

# This script takes user input for the number of characters they want in their password
# validates that the input is a valid number
# and generates a password using OpenSSL library

echo "Welcome to Password Generator v1"
echo "Please enter the length of your password:"

read LEN

if ! validate_number "$LEN"; then
	echo "Please insert a valid number"
	exit 1
fi

PASSWORD=$(openssl rand -base64 48 | cut -c1-"$LEN")

echo $PASSWORD
