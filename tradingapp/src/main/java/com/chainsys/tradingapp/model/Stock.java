package com.chainsys.tradingapp.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Stock {
    private int stockId;
    private String symbol;
    private String companyName;
    private double currentStockPrice;
    private String capCategory;
}