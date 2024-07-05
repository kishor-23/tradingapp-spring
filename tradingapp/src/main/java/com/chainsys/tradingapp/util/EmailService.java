package com.chainsys.tradingapp.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
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

    @Autowired
    private JavaMailSender mailSender;

    public void sendWelcomeEmail(String toEmail, String subject) throws MessagingException, IOException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setTo(toEmail);
        helper.setSubject(subject);
        helper.setFrom("kishorkishor2003@gmail.com");

        // Read HTML content from file
        String htmlContent = new String(Files.readAllBytes(Paths.get("src/main/resources/templates/welcome.html")));

        helper.setText(htmlContent, true);

        // Add logo image as an inline resource (if needed)
        // ClassPathResource resource = new ClassPathResource("static/images/logo.png");
        // helper.addInline("logoImage", resource);

        mailSender.send(message);
    }
}
