package com.chainsys.tradingapp.dao;

import java.util.List;

import com.chainsys.tradingapp.model.Transaction;

public interface TransactionDAO {
    List<Transaction> getTransactionsByUserId(int userId);
    List<Transaction> getLastFiveTransactionsByUserId(int userId);
}