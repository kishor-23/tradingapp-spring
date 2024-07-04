package com.chainsys.tradingapp.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Category {
	 private String capCategory;
	    private int totalQuantity;
	    private int userTotalQuantity;
}
