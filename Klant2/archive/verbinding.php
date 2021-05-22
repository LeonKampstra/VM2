<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
  <!--
    Modified from the Debian original for Ubuntu
    Last updated: 2014-03-19
    See: https://launchpad.net/bugs/1288690
  -->
  <head>
    <meta charset="UTF-8">
    <title>Apache2 Ubuntu Default Page: It works</title>
    

  </head>
  <body>
 <?php
	$hostname="Klant2-db";
	$username="root";
	$password="root";
	$dbname="example";
	$db = mysqli_connect($hostname, $username, $password, $dbname);
	echo "hello";
?>

  </body>

</html>
