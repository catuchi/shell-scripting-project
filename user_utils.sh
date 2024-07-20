# This script contains functions for user and group management

create_user_account() {
        # Function to create a new user account. Takes in username, user's home directory and default login shell
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
: << 'END_COMMENT'
        # Create the user
        sudo useradd -m -d "$home_dir" -s "$login_shell" "$username"
        if [ $? -ne 0 ]; then
                echo "Error: Failed to create user." >&2
                exit 1
        fi

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
