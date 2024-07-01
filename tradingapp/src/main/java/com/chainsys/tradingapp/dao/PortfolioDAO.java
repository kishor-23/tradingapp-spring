package com.chainsys.tradingapp.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.model.Portfolio;
@Repository
public interface PortfolioDAO {
	 
    Portfolio getPortfolioById(int portfolioId);
    List<Portfolio> getPortfoliosByUserId(int userId);
}