package com.chainsys.tradingapp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;


import com.chainsys.tradingapp.model.Stock;

public class StockRowMapper implements RowMapper<Stock> {
	  @Override
      public Stock mapRow(ResultSet rs, int rowNum) throws SQLException {
          int stockId = rs.getInt("stock_id");
          String symbol = rs.getString("symbol");
          String companyName = rs.getString("company_name");
          double currentStockPrice = rs.getDouble("current_stock_price");
          String capCategory = rs.getString("cap_category");
          return new Stock(stockId, symbol, companyName, currentStockPrice, capCategory);
      }
}
