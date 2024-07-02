package com.chainsys.tradingapp.model;

import java.sql.Blob;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;



import org.springframework.web.multipart.MultipartFile;



@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private int id;
    private String name;
    private String email;
    private String pancardno;
    private String phone;
    private Date dob;
    private String password;
    private Blob profilePicture; 
    private double balance;
}
