package com.chainsys.tradingapp.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.model.Transaction;
@Repository
public interface TransactionDAO {
   public List<Transaction> getTransactionsByUserId(int userId);
   public List<Transaction> getLastFiveTransactionsByUserId(int userId);
}