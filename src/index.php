<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP demo</title>
</head>
<style>
    body {display: block; color: #222; font-family: sans-serif;}
    body > h1 { text-align: center; font-size: 150%;}
    body > form {display: flex; justify-content: center;}
    body > form > input {margin: 2vw; padding: 15px;}
</style>
<body>
    <h1>PHP Test menu</h1>
    <form method="post">
        <input type="submit" name="phpinfo" value="phpinfo">
        <input type="submit" name="mysql" value="mysql">
    </form>
    <?php
        if (isset($_POST["phpinfo"])) {
            phpinfo();
        }
        if (isset($_POST["mysql"])) {
            $con = new mysqli("db","piwigodb_user","piwigodb_user_password","piwigodb");
            echo $con->client_info
            ."\n".$con->host_info
            ."\n".$con->server_info;
        }
    ?>
</body>
</html>


