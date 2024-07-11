<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="style/loginform.css">
    <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/svg+xml">
</head>
<body>
    <div class="container">
        <div class="regform">
<form id="registrationForm" action="register" method="post" enctype="multipart/form-data">
                <div style="display: flex; justify-content: center;">
                    <div class="logo">
                        <img src="assets/favicon.svg" width="32" height="32" alt="Cryptex logo">
                        <p>ChainTrade</p>
                    </div>
                </div>
                <p id="heading">Create your account</p>
                  <% 
                  String msg = (String) request.getAttribute("Error");
       if(msg!=null){
    	   
       
        %>
         <p class="error" style="text-align:center"><%= msg %></p>
         <%}
       %>
                <div class="input">
                    <label class="textlabel" for="name">User name</label><br>
                    <input type="text"  name="name" required pattern="[ A-Za-z]+" title="Please enter a valid name (letters only)"/>
                </div>
                <div class="input">
                    <label class="textlabel" for="email">Email</label>
                    <input type="email" id="email" name="email" required/>
                </div>
                <div class="input">
                    <label class="textlabel" for="pancardno">Pan</label><br>
                    <input type="text" id="pancardno" name="pancardno" required pattern="[A-Z]{5}[0-9]{4}[A-Z]{1}" title="Please enter a valid PAN card number (5 uppercase letters, 4 digits, 1 uppercase letter)"/>
                </div>
                <div class="input">
                    <label class="textlabel" for="phone">Phone no</label><br>
                    <input type="text" id="phone" name="phone" required pattern="[1-9][0-9]{9}" title="Please enter a valid 10-digit phone number without leading zeros"/>
                </div>
              <div class="input">
                    <label class="textlabel" for="dob">Date of birth</label><br>
                    <input type="date" id="dob" name="dob" required/>
                </div>
                <div id="dobError" style="color: red; display: none;">You must be at least 18 years old.</div>
                <label class="textlabel" for="password">Password</label>
                <div class="password">
                <input type="password" id="password" name="password" 
               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[#@$!%*?&])[A-Za-z\d@$!#%*?&]{6,}" 
               title="Must contain at least one number, one uppercase letter, one lowercase letter, one special character, and be at least 6 characters long."
               required>
               
                    <i class="uil uil-eye-slash showHidePw" id="showpassword"></i>
                </div>
                <label class="textlabel" for="file-upload">Upload profile picture</label>
                <label for="file-upload" class="custom-file-upload">
                    Choose File
                    
                </label>
                <div id="file-name">No file chosen</div>
                <input id="file-upload" type="file" name="profile" accept="image/*" />
    
       
     
                <div class="btn">
                    <button type="submit" name="sign" >Continue</button>
                </div>
                <div class="signin-up">
                    <p style="font-size: 20px; text-align: center;">Already have an account? <a href="login.jsp">Sign in</a></p>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const passwordInput = document.getElementById('password');
            const showPasswordButton = document.getElementById('showpassword');
            const dobInput = document.getElementById('dob');
            const dobError = document.getElementById('dobError');
            const form = document.getElementById('registrationForm');

            showPasswordButton.addEventListener('click', function() {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);
                this.classList.toggle('uil-eye');
                this.classList.toggle('uil-eye-slash');
            });

            dobInput.addEventListener('change', function() {
                validateDOB();
            });

            form.addEventListener('submit', function(event) {
                if (!validateDOB()) {
                    event.preventDefault();
                }
            });

            function validateDOB() {
                const dobValue = dobInput.value;
                const dobDate = new Date(dobValue);
                const today = new Date();
                
                // Calculate the user's age
                const age = today.getFullYear() - dobDate.getFullYear();
                const monthDifference = today.getMonth() - dobDate.getMonth();
                const dayDifference = today.getDate() - dobDate.getDate();

                let adjustedAge = age;

                // Adjust age if today's date is before the user's birthday this year
                if (monthDifference < 0 || (monthDifference === 0 && dayDifference < 0)) {
                    adjustedAge--;
                }

                // Check if age is less than 18
                if (adjustedAge < 18) {
                    dobError.style.display = 'block';
                    dobError.textContent = 'You must be at least 18 years old.';
                    return false;
                } else {
                    dobError.style.display = 'none';
                    return true;
                }
            }
        });
        
        const fileUpload = document.getElementById('file-upload');
        const fileName = document.getElementById('file-name');

        fileUpload.addEventListener('change', function() {
            if (fileUpload.files.length > 0) {
                fileName.textContent = fileUpload.files[0].name;
            } else {
                fileName.textContent = 'No file chosen';
            }
        });
    </script>
</body>
</html>
