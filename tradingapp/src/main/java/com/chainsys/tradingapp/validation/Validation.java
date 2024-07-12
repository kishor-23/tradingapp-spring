package com.chainsys.tradingapp.validation;

import java.util.regex.Pattern;

public class Validation {
	private Validation() {
		
	}
    private static final Pattern NAME_PATTERN = Pattern.compile("^[a-zA-Z\\s]+$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[1-9]\\d{9}$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[#@$!%*?&])[A-Za-z\\d@$!#%*?&]{6,}");
    private static final Pattern PAN_PATTERN = Pattern.compile("^[A-Z]{5}\\d{4}[A-Z]$");
    public static boolean isValidName(String name) {
        return NAME_PATTERN.matcher(name).matches();
    }
    public static boolean isValidPhoneNo(String phoneNo) {
        return PHONE_PATTERN.matcher(phoneNo).matches();
    }

    public static boolean isValidEmail(String email) {
        return EMAIL_PATTERN.matcher(email).matches();
    }

    public static boolean isValidPassword(String password) {
        return PASSWORD_PATTERN.matcher(password).matches();
    }

    public static boolean isValidPanCard(String pancardno) {
        return PAN_PATTERN.matcher(pancardno).matches();
    }
}
