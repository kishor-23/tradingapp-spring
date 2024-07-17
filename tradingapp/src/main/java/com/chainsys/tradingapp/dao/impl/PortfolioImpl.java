package com.chainsys.tradingapp.dao.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.dao.PortfolioDAO;
import com.chainsys.tradingapp.model.*;
import com.chainsys.tradingapp.mapper.CategoryRowMapper;
import com.chainsys.tradingapp.mapper.PortfolioRowMapper;



@Repository
public class PortfolioImpl implements PortfolioDAO {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public PortfolioImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Portfolio getPortfolioById(int portfolioId) {
        String query = "SELECT portfolio_id, user_id, stock_id, quantity, buyed_price FROM portfolio WHERE portfolio_id = ?";
        return jdbcTemplate.queryForObject(query,  new PortfolioRowMapper(),portfolioId);
    }

    @Override
    public List<Portfolio> getPortfoliosByUserId(int userId) {
        String query = "SELECT p.portfolio_id, p.user_id, p.stock_id, s.company_name as company, s.symbol as symbol, p.quantity, p.avg_cost, p.total_cost FROM portfolio p JOIN stocks s ON p.stock_id = s.stock_id WHERE p.user_id = ? order by total_cost desc;";
        return jdbcTemplate.query(query,  new PortfolioRowMapper(),userId);
    }
    @Override
    public List<Category> getCategoryQuantities(int userId) {
        String sql = "SELECT s.cap_category, " +
                     "SUM(p.quantity) AS total_quantity, " +
                     "(SELECT SUM(quantity) FROM portfolio WHERE user_id = ?) AS user_total_quantity " +
                     "FROM portfolio p " +
                     "JOIN stocks s ON p.stock_id = s.stock_id " +
                     "WHERE p.user_id = ? " +
                     "GROUP BY s.cap_category";

        return jdbcTemplate.query(sql,  new CategoryRowMapper(),userId, userId);
    }
    @Override
    public List<Category> getSectorCategoryQuantities(int userId) {
        String sql = "SELECT " +
                     "s.sector as cap_category, " +
                     "SUM(p.quantity) AS total_quantity, " +
                     "(SELECT SUM(quantity) FROM portfolio WHERE user_id = ?) AS user_total_quantity " +
                     "FROM portfolio p " +
                     "JOIN stocks s ON p.stock_id = s.stock_id " +
                     "WHERE p.user_id = ? " +
                     "GROUP BY s.sector";

        return jdbcTemplate.query(sql, new CategoryRowMapper(), userId, userId);
    }




   
   }