# This script contains functions for user and group management

create_user_account() {
        # Function to create a new user account.
        local username
        local input_dir
        local login_shell
        local home_dir

        while true; do
                read -p "Enter the new username: " username
                if [[ -z "${username// }" ]]; then
                        echo "Please enter a username."
                elif grep -q "^$username:" /etc/passwd; then
                        echo "Username already exists."
                else
                        break
                fi
        done

        while true; do
                read -p "Enter the home directory (Press enter for default: /home/$username): " input_dir

                if [[ "$input_dir" =~ ^/home/[a-zA-Z0-9_]+$ ]]; then
                        if [[ -d "$input_dir" ]]; then
                                echo "Directory $input_dir already exists."
                                echo "Please enter a valid path or press Enter to use the default: /home/$username"
                        elif [[ -d "$(dirname "$input_dir")" ]]; then
                                home_dir=$input_dir
                                break
                        elif [[ -z "${input_dir// }" ]]; then
                                home_dir="/home/$username"
                                break
                        else
                                echo "Invalid directory path. Please enter a valid path or press Enter to use the default: /home/$username"
                        fi
                elif [[ -z "${input_dir// }" ]]; then
                        home_dir="/home/$username"
                        break
                else
                         echo "Invalid directory format. Please enter correct format '/home/username' or press Enter to use the default: /home/$username"
                fi
        done

        # prompt for login shell with default value and validation
        while true; do
                read -p "Enter the login shell (default: /bin/bash): " login_shell
                login_shell=${login_shell:-/bin/bash}  # Default if no input is given

                if is_valid_shell "$login_shell"; then
                        break
                else
                        echo "Invalid shell. Please enter a valid shell or press Enter to use the default: /bin/bash"
                fi
        done

        # Create the user
        sudo useradd -m -d "$home_dir" -s "$login_shell" "$username"
        if [ $? -ne 0 ]; then
                echo "Error: Failed to create user." >&2
                exit 1
        fi
: << 'END_COMMENT'
        echo "Enter password for $username:"
        sudo passwd "$username"
        if [ $? -ne 0 ]; then
                echo "Error: Failed to create password." >&2
                exit 1
        fi
END_COMMENT
        echo $username
        echo $home_dir
        echo $login_shell
        echo "User $username has been created and configured."
}

delete_user_account() {
	# Function to delete user account (and user's home directory).
	local username

	while true; do
		read -p "Enter the username to delete: " username
		if [[ -z "${username// }" ]]; then
            		echo "Please enter a username."
        	elif ! id -u "$username" > /dev/null 2>&1; then
            		echo "Username does not exist."
        	else
            		break
        	fi
    	done

	read -p "Are you sure you want to delete the user $username and their home directory? (y/n): " confirm
	case "$confirm" in
        	[yY] | [yY][eE][sS] | [yY][aA] | [yY][uU][pP] | [yY][eE][aA] | [yY][eE][aA][hH])
            		sudo userdel -rf "$username"
            		if [ $? -eq 0 ]; then
                		echo "User $username has been deleted."
            		else
                		echo "Failed to delete user $username." >&2
                		exit 1
            		fi
            		;;
        	*)
            		echo "User deletion cancelled."
            		;;
    	esac
}

change_supplementary_group() {
	# Function to change the supplementary group for a user account
	local username
	local groupname

	while true; do
		read -p "Enter the username you would like to change the supplementary group for: " username
		if [[ -z "${username// }" ]]; then
			echo "Please enter a username."
		elif ! id -u "$username" > /dev/null 2>&1; then
			echo "Username does not exist."
		else
			break
		fi
	done

	while true; do
		read -p "Enter the new supplementary group for $username: " groupname
		if getent group "$groupname" > /dev/null; then
        		echo "Group $groupname exists."
			break
    		else
        		echo "Group $groupname does not exist."
    		fi
	done

	sudo usermod -aG "$groupname" "$username"
	if [ $? -eq 0 ]; then
        	echo "Supplementary group for User $username has been changed to Group $groupname successfully."
        else
        	echo "Failed to change supplementary group for User $username" >&2
                exit 1
        fi
}

change_initial_group() {
	# Function to change the initial group for a user account
	local username
	local groupname

	while true; do
                read -p "Enter the username you would like to change the supplementary group for: " username
                if [[ -z "${username// }" ]]; then
                        echo "Please enter a username."
                elif ! id -u "$username" > /dev/null 2>&1; then
                        echo "Username does not exist."
                else
                        break
                fi
        done

        while true; do
                read -p "Enter the new initial group for $username: " groupname
                if getent group "$groupname" > /dev/null; then
                        echo "Group $groupname exists."
                        break
                else
                        echo "Group $groupname does not exist."
                fi
        done

	sudo usermod -g "$groupname" "$username"
	if [ $? -eq 0 ]; then
                echo "Primary group for User $username has been changed to Group $groupname successfully."
        else
                echo "Failed to change initial group for User $username" >&2
                exit 1
        fi
}

change_default_shell() {
	# Function to change the default login shell for a user account
	local username
	local new_shell

	while true; do
                read -p "Enter the username you would like to change the supplementary group for: " username
                if [[ -z "${username// }" ]]; then
                        echo "Please enter a username."
                elif ! id -u "$username" > /dev/null 2>&1; then
                        echo "Username does not exist."
                else
                        break
                fi
        done

	while true; do
                read -p "Enter the new login shell (default: /bin/bash): " new_shell
                new_shell=${new_shell:-/bin/bash}  # Default if no input is given

                if is_valid_shell "$new_shell"; then
                        break
                else
                        echo "Invalid shell. Please enter a valid shell or press Enter to use the default: /bin/bash"
                fi
        done

	sudo usermod -s "$new_shell" "$username"
	if [ $? -eq 0 ]; then
                echo "User $username's login shell has been changed to $new_shell"
        else
                echo "Failed to change login shell for User $username" >&2
                exit 1
        fi
}

change_account_expiration_date() {
	# Function to change account expiration date for a user account
	local username
	local exp_date

	while true; do
                read -p "Enter the username you would like to change the supplementary group for: " username
                if [[ -z "${username// }" ]]; then
                        echo "Please enter a username."
                elif ! id -u "$username" > /dev/null 2>&1; then
                        echo "Username does not exist."
                else
                        break
                fi
        done

	while true; do
    		read -p "Enter the expiration date (YYYY-MM-DD): " exp_date
    		if validate_date_format "$exp_date"; then
        		echo "The date $exp_date is valid."
        		break
    		else
        		echo "Please enter a valid date."
    		fi
	done

	sudo chage -E "$exp_date" "$username"
	if [ $? -eq 0 ]; then
                echo "User $username's account expiration date has been changed to $exp_date"
        else
                echo "Failed to change account expiration date for User $username" >&2
                exit 1
        fi
}
