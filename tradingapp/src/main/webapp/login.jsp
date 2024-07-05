<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="style/loginform.css">
    <link rel="icon" href="assets/favicon.svg" type="image/x-icon">
    <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/svg+xml">
</head>
<body>
    <div class="container">
        <div class="regform">
            <form action="/login" method="post">
                <div style="display: flex; justify-content: center;">
                    <div class="logo"><img src="assets/favicon.svg" width="32" height="32" alt="Cryptex logo"><p> ChainTrade </p></div>
                </div>
                <p id="heading">welcome back trader!</p>
                <div class="input">
                    <label class="textlabel" for="email">Email</label>
                    <input type="email" id="email" name="email" required/>
                </div>
                <label class="textlabel" for="password">Password</label>
                <div class="password">
                    <input type="password" name="password" id="password" required/>
                    <i class="uil uil-eye-slash showHidePw" id="showpassword"></i>                
                </div>
                <% 
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                    <p class="error"><%= msg %></p>
                <% 
                    }
                %>
                <div class="btn">
                    <button type="submit" name="login">Login</button>
                </div>
                <div class="signin-up">
                    <p style="font-size: 20px; text-align: center;">Don't have an account? <a href="register.jsp"> Sign up</a></p>
                </div>
            </form>
        </div>
    </div>
    <script src="login.js"></script>
</body>
</html>
