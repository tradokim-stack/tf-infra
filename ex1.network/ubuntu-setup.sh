

sudo apt update

sudo apt install nginx -y

sudo tee /var/www/html/index.html > /dev/null <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Hello</title>
</head>
<body>
    <h1>Hello EC2</h1>
    <p>Deploy thành công!</p>
</body>
</html>
EOF