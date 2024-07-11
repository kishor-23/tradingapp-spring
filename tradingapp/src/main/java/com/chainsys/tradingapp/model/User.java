package com.chainsys.tradingapp.model;

import java.sql.Blob;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;






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
