echo "Type project name: "
read projectname
mkdir $projectname
cd $projectname
mkdir css js images
touch index.html css/style.css js/main.js
echo  "console.log(\"This script is working\")" > js/main.js

cat << EOF > index.html 
<!DOCTYPE html>
<html lang="en">    
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>$projectname</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Hello, World!</h1>
</body>
    <script src="js/main.js"></script>
</html>
EOF