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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.chainsys.tradingapp.dao.UserDAO;
import com.chainsys.tradingapp.dao.impl.UserImpl;
import com.chainsys.tradingapp.model.User;
import com.chainsys.tradingapp.util.EmailService;
import com.chainsys.tradingapp.util.PasswordHashing;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
    private final UserDAO userOperations;
    @Autowired
    private EmailService emailService;
    @Autowired
    public UserController(UserImpl userImpl) {
        this.userOperations = userImpl;
    }
    @GetMapping("/profile")
    public String profile(HttpSession session) throws ClassNotFoundException, SQLException {
        User updatedUser = userOperations.getUserByEmail(((User) session.getAttribute("user")).getEmail());
        session.setAttribute("user", updatedUser);

    	return "profile.jsp";
    }
    @RequestMapping("/")
    public String home() {
    	return "home.jsp";
    }

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register.jsp";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, @RequestParam("profile") MultipartFile filePart, HttpServletRequest request, Model model) throws IOException, SQLException, MessagingException {
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
            emailService.sendWelcomeEmail(user.getEmail(), "Welcome to ChainTrade!");

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
    public String loginUser(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) throws ClassNotFoundException, MessagingException, IOException {
        try {

            User user = userOperations.getUserByEmail(email);
    // emailService.sendWelcomeEmail(user.getEmail(), "Welcome to ChainTrade!");
            if (user != null && PasswordHashing.checkPassword(password, user.getPassword())) {
                session.setAttribute("user", user);
                return "redirect:/profile";
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

    @PostMapping("/addMoney")
    public String addMoney(HttpServletRequest request, HttpSession session, Model model) throws ClassNotFoundException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        double amount = Double.parseDouble(request.getParameter("amount"));

        try {
            userOperations.addMoneyToUser(userId, amount);
            User updatedUser = userOperations.getUserByEmail(((User) session.getAttribute("user")).getEmail());
            session.setAttribute("user", updatedUser);
            return "redirect:/profile";
        } catch (SQLException e) {
            e.printStackTrace();
            model.addAttribute("msg", "An error occurred. Please try again later.");
            return "error.jsp"; 
        }
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login";
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
        return "redirect:/profile";
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