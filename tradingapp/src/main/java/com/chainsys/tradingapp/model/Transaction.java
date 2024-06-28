package com.chainsys.tradingapp.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Transaction {
    private int transactionId;
    private int userId;
    private int stockId;
    private int shares;
    private double price;
    private String transactionType;
    private Timestamp timestamp;
    private String stockSymbol; 
    private String companyName;
    private double profitOrLoss;
}