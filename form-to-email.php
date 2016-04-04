<?php
if(!isset($_POST['submit']))
{
	//This page should not be accessed directly. Need to submit the form.
	echo "error; you need to submit the form!";
}

/*gathering data variables*/
$name = $_POST['name'];
$visitor_email = $_POST['email'];
$message = $_POST['message'];

//Validate first
if(empty($name)||empty($visitor_email)) 
{
    echo "Name and email are mandatory!";
    exit;
}

if(IsInjected($visitor_email))
{
    echo "Bad email value!";
    exit;
}

/*subject and email variables*/
$webMaster = 'qinyingl@gmail.com'
$email_subject = "New Form submission\n";
$body = "You have received a new message from the user $name.\n".
    "email address: $visitor_email\n".
    "Here is the message:\n $message\n".
    
$to = "qinyingl@umich.edu";//<== update the email address
$headers = "From: $visitor_email \r\n";
//Send the email!
mail($to,$email_subject,$body,$headers);
//done. redirect to thank-you page.
header('Location: thank-you.html');

$theResults = <<< EOD
<html>
<head>
<>
EOD;
echo"$theResults"


// Function to validate against any email injection attempts
function IsInjected($str)
{
  $injections = array('(\n+)',
              '(\r+)',
              '(\t+)',
              '(%0A+)',
              '(%0D+)',
              '(%08+)',
              '(%09+)'
              );
  $inject = join('|', $injections);
  $inject = "/$inject/i";
  if(preg_match($inject,$str))
    {
    return true;
  }
  else
    {
    return false;
  }
}
   
?> 