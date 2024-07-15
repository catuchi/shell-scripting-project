# This Library contains functions to validate user inputs

validate_number() {
	# Function to check if user input in a number (allows -ve and decimal numbers too)
	if [[ $1 =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
        	return 0  # Return 0 for true (valid number)
    	else
        	return 1  # Return 1 for false (invalid number)
    	fi
}

validate_number_two() {
	# Function to check if user input in a number (does not allow -ve or decimal numbers)
	if [[ $1 =~ ^[0-9]+$ ]]; then
                return 0  # Return 0 for true (valid number)
        else
                return 1  # Return 1 for false (invalid number)
        fi
}
