<?php

function mysql_test_connect() {
  $con = new mysqli("db","piwigodb_user","piwigodb_user_password","piwigodb");
}

function mysql_test_main() {
  mysql_test_connect();
}

?>