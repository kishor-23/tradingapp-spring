package com.chainsys.tradingapp.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.model.Stock;
@Repository
public interface StockDAO {
    List<Stock> selectAllStocks();
    Stock getStockDetailsById(int id);
    int buyStock(int userId, int stockId, int quantity, double price) ;
    int sellStock(int userId, int stockId, int quantity, double price) ;
}
