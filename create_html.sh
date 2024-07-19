# This script contains function to create basic index.html web page for a server

create_web_page() {
	touch hello.html

	if [ $? -ne 0 ]; then
		echo "Server created"
		echo "Error: Failed to create hello.html" >&2
		exit 1
	fi

cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello, World!</title>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>This is a simple HTML page served by $(capitalize_first_letter "$server_name").</p>
</body>
</html>
EOF
	echo "hello.html file created"
}
