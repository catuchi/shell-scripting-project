#!/bin/bash

source validate.sh
source math_utils.sh

echo "Welcome to Calculator!"
echo " "
echo "Enter First Number:"
read first

echo "Enter Second Number:"
read second

if ! validate_number "$first"; then
    echo "Please input a valid number for the first input."
    exit 1
fi

if ! validate_number "$second"; then
    echo "Please input a valid number for the second input."
    exit 1
fi

echo "Choose a number that matches your desired operation"
echo "1. Addition"
echo "2. Subtraction"
echo "3. Multiplication"
echo "4. Division"

read operation

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

