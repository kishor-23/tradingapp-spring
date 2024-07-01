package com.chainsys.tradingapp.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.model.Transaction;
@Repository
public interface TransactionDAO {
    List<Transaction> getTransactionsByUserId(int userId);
    List<Transaction> getLastFiveTransactionsByUserId(int userId);
}