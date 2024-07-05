package com.chainsys.tradingapp.mapper;


import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.tradingapp.model.Transaction;

public class TransactionRowMapper implements RowMapper<Transaction> {
    @Override
    public Transaction mapRow(ResultSet resultSet, int i) throws SQLException {
        Transaction transaction = new Transaction();
        transaction.setTransactionId(resultSet.getInt("transaction_id"));
        transaction.setUserId(resultSet.getInt("user_id"));
        transaction.setStockId(resultSet.getInt("stock_id"));
        transaction.setShares(resultSet.getInt("shares"));
        transaction.setPrice(resultSet.getDouble("price"));
        transaction.setTransactionType(resultSet.getString("transaction_type"));
        transaction.setTimestamp(resultSet.getTimestamp("timestamp"));
        transaction.setStockSymbol(resultSet.getString("symbol"));
        transaction.setCompanyName(resultSet.getString("company_name"));
        transaction.setProfitOrLoss(resultSet.getDouble("profit_loss"));
        return transaction;
    }
}