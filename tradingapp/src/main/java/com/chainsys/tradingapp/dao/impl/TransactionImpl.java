package com.chainsys.tradingapp.dao.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.dao.TransactionDAO;
import com.chainsys.tradingapp.model.Transaction;
import com.chainsys.tradingapp.mapper.*;


@Repository
public class TransactionImpl implements TransactionDAO {

    private static final String GET_TRANSACTIONS_BY_USER_ID_QUERY =
            "SELECT t.transaction_id, t.user_id, t.stock_id, t.profit_loss, t.shares, t.price, t.transaction_type, t.timestamp, s.symbol, s.company_name " +
            "FROM transactions t JOIN stocks s ON t.stock_id = s.stock_id " +
            "WHERE t.user_id = ?";

    private static final String GET_LAST_FIVE_TRANSACTIONS_BY_USER_ID_QUERY =
            "SELECT t.transaction_id, t.user_id, t.stock_id, t.shares, t.price, t.profit_loss, t.transaction_type, t.timestamp, s.symbol, s.company_name " +
            "FROM transactions t JOIN stocks s ON t.stock_id = s.stock_id " +
            "WHERE t.user_id = ? " +
            "ORDER BY t.timestamp DESC LIMIT 5";

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public TransactionImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Transaction> getTransactionsByUserId(int userId) {
        return jdbcTemplate.query(GET_TRANSACTIONS_BY_USER_ID_QUERY,  new TransactionRowMapper(),userId);
    }

    @Override
    public List<Transaction> getLastFiveTransactionsByUserId(int userId) {
        return jdbcTemplate.query(GET_LAST_FIVE_TRANSACTIONS_BY_USER_ID_QUERY,  new TransactionRowMapper(),userId);
    }

    
}