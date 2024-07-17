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
import org.springframework.dao.DuplicateKeyException;
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
import com.chainsys.tradingapp.exception.PanCardDulipateException;
import com.chainsys.tradingapp.model.User;
import com.chainsys.tradingapp.util.EmailService;
import com.chainsys.tradingapp.util.PasswordHashing;
import com.chainsys.tradingapp.validation.Validation;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	
    private final UserDAO userOperations;
    private EmailService emailService;
    private static final String REGISTER_PAGE = "register.jsp";
    private static final String LOGIN_PAGE = "login.jsp";
    private static final String PROFILE_PAGE="redirect:/profile";
    private static final String ERROR_MSG="Error";

    @Autowired
    public UserController(UserImpl userImpl, EmailService emailService) {
        this.userOperations = userImpl;
        this.emailService=emailService;
    }
    @GetMapping("/profile")
    public String profile(HttpSession session) throws ClassNotFoundException, SQLException {
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            return "redirect:/login"; 
        }
        
        User updatedUser = userOperations.getUserByEmail(currentUser.getEmail());
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
        return REGISTER_PAGE;
    }


    @PostMapping("/register")
    public String registerUser(
            @ModelAttribute User user,
            @RequestParam("profile") MultipartFile filePart,
            HttpServletRequest request,
            Model model) throws IOException, SQLException, MessagingException {

        Date dob = parseDateOfBirth(request.getParameter("dob"), model);
        Blob profilePicture = processProfilePicture(filePart, model);

        if (hasValidationErrors(user, model)) {
            return REGISTER_PAGE;
        }

        setUserDetails(user, dob, profilePicture);
        return registerNewUser(user, model);
    }

    private Date parseDateOfBirth(String dobString, Model model) {
        if (dobString != null && !dobString.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                return new Date(sdf.parse(dobString).getTime());
            } catch (ParseException e) {
                e.printStackTrace();
                model.addAttribute("dobError", "Invalid date format.");
            }
        }
        return null;
    }

    private Blob processProfilePicture(MultipartFile filePart, Model model) throws SQLException {
        if (filePart != null && !filePart.isEmpty()) {
            try (InputStream inputStream = filePart.getInputStream()) {
                return new SerialBlob(inputStream.readAllBytes());
            } catch (SerialException | IOException e) {
                e.printStackTrace();
                model.addAttribute("profilePictureError", "Error processing profile picture.");
            }
        }
        return null;
    }

    private boolean hasValidationErrors(User user, Model model) {
        boolean hasErrors = false;

        if (!Validation.isValidName(user.getName())) {
            model.addAttribute(ERROR_MSG, "Invalid name format. Only letters and spaces are allowed.");
            hasErrors = true;
        }

        if (!Validation.isValidPhoneNo(user.getPhone())) {
            model.addAttribute(ERROR_MSG, "Invalid phone number format. Should be 10 digits.");
            hasErrors = true;
        }

        if (!Validation.isValidEmail(user.getEmail())) {
            model.addAttribute(ERROR_MSG, "Invalid email format.");
            hasErrors = true;
        }

        if (!Validation.isValidPassword(user.getPassword())) {
            model.addAttribute(ERROR_MSG, "Invalid password format. Must contain at least one number, one uppercase letter, one lowercase letter, one special character, and be at least 6 characters long.");
            hasErrors = true;
        }

        if (!Validation.isValidPanCard(user.getPancardno())) {
            model.addAttribute(ERROR_MSG, "Invalid PAN card number format. Should be 5 uppercase letters, 4 digits, and 1 uppercase letter.");
            hasErrors = true;
        }

        return hasErrors;
    }

    private void setUserDetails(User user, Date dob, Blob profilePicture) {
        user.setDob(dob);
        user.setPassword(PasswordHashing.hashPassword(user.getPassword()));
        user.setBalance(100.00);
        user.setProfilePicture(profilePicture);
    }

    private String registerNewUser(User user, Model model) throws MessagingException, IOException {
        boolean userExists = userOperations.checkUserAlreadyExists(user.getEmail());

        if (!userExists) {
            try {
                userOperations.addUser(user);
                emailService.sendWelcomeEmail(user.getEmail(), "Welcome to ChainTrade!");
                return "redirect:/login?registered=true";
            } catch (DuplicateKeyException e) {
                   //   throw new PanCardDulipateException("pan already exists");

                model.addAttribute(ERROR_MSG, "Registration failed. User with this PAN card already exists.");
                return REGISTER_PAGE;
            }
        } else {
            model.addAttribute(ERROR_MSG, "Registration failed. User already exists. Please login.");
            return REGISTER_PAGE;
        }
    }


    @GetMapping("/login")
    public String showLoginForm() {
        return LOGIN_PAGE;
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) throws ClassNotFoundException  {
        try {

            User user = userOperations.getUserByEmail(email);
            if (user != null && PasswordHashing.checkPassword(password, user.getPassword())) {
                session.setAttribute("user", user);
                return PROFILE_PAGE;
            } else {
                model.addAttribute("msg", "Invalid email or password");
                return LOGIN_PAGE;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            model.addAttribute("msg", "An error occurred. Please try again later.");
            return LOGIN_PAGE;
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
            return PROFILE_PAGE;
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
        return PROFILE_PAGE;
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