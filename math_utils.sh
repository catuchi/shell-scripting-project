# Functions for my calculator program

add() {
	# Function to add to numbers together
	echo $(($1 + $2))
}

subtract() {
	# Function to subtract one number from the other
	echo $(($1 - $2))
}

multiply() {
        # Function to multiply two numbers
        echo $(($1 * $2))
}

divide() {
        # Function to divide two numbers
	if [ "$2" -eq 0 ]; then
        	echo "Error: Division by zero"
        	return 1
    	fi
        echo $(($1 / $2))
}
