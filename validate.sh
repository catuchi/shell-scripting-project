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

validate_hostname() {
	#Function to validate user input for hostname
	
	# Check for empty or whitespace-only input
	if [[ -z "${1// }" ]]; then
		echo "Invalid hostname: Input cannot be empty or just spaces."
                return 1
        fi

        # Validate hostname format
        if [[ $1 =~ ^[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?(\.[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?)*$ ]]; then
                echo "127.0.0.1   $1" | sudo tee -a /etc/hosts > /dev/null
                return 0
        else
                echo "Invalid hostname: Must follow hostname rules."
                return 1
        fi
}

validate_choice() {
	# Function to check user input for server choice
	
        if [ $1 == 1 ]; then
                server_name="apache2"
                return 0
        elif [ $1 == 2 ]; then
                server_name="nginx"
                return 0
        else
                return 1
        fi
}

capitalize_first_letter() {
	# Function to capitalize the first letter of a single word
	
	local word="$1"
	local first_letter="${word:0:1}"
	local rest="${word:1}"
	echo "${first_letter^}${rest}"
}
