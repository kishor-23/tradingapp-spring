package com.chainsys.tradingapp.dao.impl;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.dao.StockDAO;
import com.chainsys.tradingapp.mapper.StockRowMapper;
import com.chainsys.tradingapp.model.Stock;


@Repository
public class StockImpl implements StockDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;



    @Override
    public List<Stock> selectAllStocks() {
        String sql = "SELECT stock_id, symbol, company_name, current_stock_price, cap_category FROM stocks";
        return jdbcTemplate.query(sql, new StockRowMapper());
    }

    @Override
    public Stock getStockDetailsById(int id) {
        String sql = "SELECT stock_id, symbol, company_name, current_stock_price, cap_category FROM stocks WHERE stock_id = ?";
        return jdbcTemplate.queryForObject(sql, new StockRowMapper(), id);
    }

    @Override
    public int buyStock(int userId, int stockId, int quantity, double price) {
        String procedureCall = "{CALL buyStockProcedure(?, ?, ?, ?, ?)}";
        return jdbcTemplate.update(procedureCall, userId, stockId, quantity, price, null);
    }

    @Override
    public int sellStock(int userId, int stockId, int quantity, double price) {
        String procedureCall = "{CALL sellStockProcedure(?, ?, ?, ?, ?, ?)}";
        return jdbcTemplate.update(procedureCall, userId, stockId, quantity, price, null, null);
    }

    @Override
    public double stockPriceById(int stockId) {
        String sql = "SELECT current_stock_price FROM stocks WHERE stock_id = ?";
        return jdbcTemplate.queryForObject(sql, Double.class, stockId);
    }

   
}