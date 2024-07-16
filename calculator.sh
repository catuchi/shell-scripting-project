#!/bin/bash

log_file="./calculator_log.log"
today=$(date +"%Y-%m-%d %H:%M:%S")

echo $today >> $log_file
echo "Starting the script" >> $log_file

echo "Sourcing libraries" >> $log_file
source validate.sh
source math_utils.sh

echo "Reading user input" >> $log_file
echo "Welcome to Calculator!"
echo " "
echo "Enter First Number:"
read first

echo "Enter Second Number:"
read second

echo "validating user input" >> $log_file
if ! validate_number "$first"; then
    echo "Please input a valid number for the first input."
    exit 1
fi

if ! validate_number "$second"; then
    echo "Please input a valid number for the second input."
    exit 1
fi

echo "choosing math operation" >> $log_file
echo "Choose a number that matches your desired operation"
echo "1. Addition"
echo "2. Subtraction"
echo "3. Multiplication"
echo "4. Division"

read operation

echo "performing operation" >> $log_file
# Perform the selected operation
case "$operation" in
    "1")
        result=$(add "$first" "$second")
        echo "$first + $second = $result"
        ;;
    "2")
        result=$(subtract "$first" "$second")
        echo "$first - $second = $result"
        ;;
    "3")
        result=$(multiply "$first" "$second")
        echo "$first * $second = $result"
        ;;
    "4")
        result=$(divide "$first" "$second")
        if [ $? -ne 0 ]; then
            echo "Error: Division by zero."
        else
            echo "$first / $second = $result"
        fi
        ;;
    *)
        echo "Invalid operation selected."
        ;;
esac

echo "Script executed successfully" >> $log_file
echo " " >> $log_file
echo "------------------------------" >> $log_file
