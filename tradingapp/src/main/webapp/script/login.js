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

    // Calculate age
    let age = today.getFullYear() - dobDate.getFullYear();
    const monthDifference = today.getMonth() - dobDate.getMonth();
    const dayDifference = today.getDate() - dobDate.getDate();

    // Adjust age if current date is before the birthday in the current year
    if (monthDifference < 0 || (monthDifference === 0 && dayDifference < 0)) {
        age--;
    }

    // Check if age is less than 18
    if (age < 18) {
        dobError.style.display = 'block';
        dobError.textContent = 'You must be at least 18 years old.';
        return false;
    } else {
        dobError.style.display = 'none';
        return true;
    }
}


});
