#!/bin/bash

# This script contains a method that will receive the total grade score in number and return the Letter Grade (e.g. A+, A, B- etc.)

grade() {
	# Function to convert Number Grade to Letter Grade
	if [ $1 -ge "90" ] && [ $1 -le "100" ]; then
		echo "A+"
	elif [ $1 -ge "85" ] && [ $1 -le "89" ]; then
		echo "A"
	elif [ $1 -ge "80" ] && [ $1 -le "84" ]; then
                echo "A-"
	elif [ $1 -ge "77" ] && [ $1 -le "79" ]; then
                echo "B+"
	elif [ $1 -ge "73" ] && [ $1 -le "76" ]; then
                echo "B"
	elif [ $1 -ge "70" ] && [ $1 -le "72" ]; then
                echo "B-"
	elif [ $1 -ge "67" ] && [ $1 -le "69" ]; then
                echo "C+"
	elif [ $1 -ge "63" ] && [ $1 -le "66" ]; then
                echo "C"
	elif [ $1 -ge "60" ] && [ $1 -le "62" ]; then
                echo "C-"
	elif [ $1 -ge "57" ] && [ $1 -le "59" ]; then
                echo "D+"
	elif [ $1 -ge "53" ] && [ $1 -le "56" ]; then
                echo "D"
	elif [ $1 -ge "50" ] && [ $1 -le "52" ]; then
                echo "D-"
	elif [ $1 -ge "0" ] && [ $1 -le "49" ]; then
                echo "F"
	else
		echo "Error: Please Input a valid Number Grade"
	fi
}
