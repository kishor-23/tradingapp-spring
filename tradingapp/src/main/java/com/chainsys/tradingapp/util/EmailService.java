package com.chainsys.tradingapp.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@Service
public class EmailService {

 
  
    private JavaMailSender mailSender;
    @Autowired
    public EmailService(JavaMailSender mailSender) {
    	this.mailSender=mailSender;
    }
  
    public void sendWelcomeEmail(String toEmail, String subject) throws MessagingException, IOException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setTo(toEmail);
        helper.setSubject(subject);
        helper.setFrom("kishorkishor2003@gmail.com");

        // Read HTML content from file
        String htmlContent = new String(Files.readAllBytes(Paths.get("src/main/resources/templates/welcome.html")));

        helper.setText(htmlContent, true);

      

        mailSender.send(message);
    }
    public void sendOrderConfirmation(String to, String username, String productName,String type, int quantity) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        String htmlContent = "<html><body>" +
                "<h1>Hello, " + username + "!</h1>" +
                "<p>Your "+type +" order for " + quantity + " units of " + productName + " has been successfully processed.</p>" +
                "<p>Thank you for trading with us.</p>" +
                "</body></html>";

        helper.setTo(to);
        helper.setSubject("Order Confirmation");
        helper.setText(htmlContent, true);

        mailSender.send(message);
    }
}
