package com.chainsys.tradingapp.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Portfolio {
    private int portfolioId;
    private int userId;
    private int stockId;
    private int quantity;
    private double total;
    private String symbol;
	private String company;
	private double buyedPrice;


}
