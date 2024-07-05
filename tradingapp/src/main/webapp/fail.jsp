<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Transaction Failed</title>
    <link rel="stylesheet" href="style/fail.css">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="message-box _success _failed">
                <i class="fa fa-times-circle" aria-hidden="true"></i>
                <h2>Your payment failed</h2>
                <p><%= request.getAttribute("error") %></p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
