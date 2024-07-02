package com.chainsys.tradingapp.controller;


import java.io.IOException;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import java.io.InputStream;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.chainsys.tradingapp.dao.UserDAO;
import com.chainsys.tradingapp.dao.impl.UserImpl;
import com.chainsys.tradingapp.model.User;
import com.chainsys.tradingapp.util.PasswordHashing;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
    private final UserDAO userOperations;

    @Autowired
    public UserController(UserImpl userImpl) {
        this.userOperations = userImpl;
    }

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register.jsp";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, @RequestParam("profile") MultipartFile filePart, HttpServletRequest request, Model model) throws IOException, SQLException {
        // Extract user details from the form
        String dobString = request.getParameter("dob");
        Date dob = null;

        if (dobString != null && !dobString.isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                dob = new Date(sdf.parse(dobString).getTime());
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        Blob profilePicture = null;
        if (filePart != null && !filePart.isEmpty()) {
            try (InputStream inputStream = filePart.getInputStream()) {
                profilePicture = new SerialBlob(inputStream.readAllBytes());
            } catch (SerialException | IOException e) {
                e.printStackTrace();
            }
        }

        double balance = 100.00;

        // Hash the password before storing
        String hashedPassword = PasswordHashing.hashPassword(user.getPassword());

        user.setDob(dob);
        user.setPassword(hashedPassword);
        user.setBalance(balance);
        user.setProfilePicture(profilePicture); // set the profile picture blob

        boolean userExists = userOperations.checkUserAlreadyExists(user.getEmail());
        if (!userExists) {
            userOperations.addUser(user);
            return "redirect:/login?registered=true";
        } else {
            model.addAttribute("errorMessage", "Registration failed. User already exists. Please login.");
            return "register.jsp";
        }
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "login.jsp";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) throws ClassNotFoundException {
        try {
            User user = userOperations.getUserByEmail(email);
            if (user != null && PasswordHashing.checkPassword(password, user.getPassword())) {
                session.setAttribute("user", user);
                return "home.jsp";
            } else {
                model.addAttribute("msg", "Invalid email or password");
                return "login.jsp";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            model.addAttribute("msg", "An error occurred. Please try again later.");
            return "login.jsp";
        }
    }

    @PostMapping("/profilePicture")
    public String updateProfilePicture(@RequestParam("userId") int userId, @RequestParam("profilePicture") MultipartFile filePart, HttpServletResponse response) throws SQLException {
        Blob profilePicture = null;
        if (filePart != null && !filePart.isEmpty()) {
            try (InputStream inputStream = filePart.getInputStream()) {
                profilePicture = new SerialBlob(inputStream.readAllBytes());
            } catch (SerialException | IOException e) {
                e.printStackTrace();
            }
        }

        userOperations.updateUserProfilePicture(userId, profilePicture);
        return "redirect:/profile"; // Adjust the redirect URL as needed
    }

    @GetMapping("/profilePicture")
    public void getProfilePicture(@RequestParam("userId") int userId, HttpServletResponse response) {
        try {
            Blob profilePicture = userOperations.getUserProfilePicture(userId);
            if (profilePicture != null) {
                try (InputStream inputStream = profilePicture.getBinaryStream()) {
                    response.setContentType("image/jpeg");
                    byte[] buffer = new byte[8192];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        response.getOutputStream().write(buffer, 0, bytesRead);
                    }
                }
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }
}