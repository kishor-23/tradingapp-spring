package com.chainsys.tradingapp.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordHashing {
    private static final String HASH_ALGORITHM = "SHA-256";
    private PasswordHashing() {
    }
    public static String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance(HASH_ALGORITHM);
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean checkPassword(String password, String hashedPassword) {
        String hashedInputPassword = hashPassword(password);
        // Check if hashedInputPassword is null
        if (hashedInputPassword != null) {
            return hashedInputPassword.equals(hashedPassword);
        } else {
            // Handle null case, such as logging an error or returning false
            // For example:
            return false;
        }
    }

}
