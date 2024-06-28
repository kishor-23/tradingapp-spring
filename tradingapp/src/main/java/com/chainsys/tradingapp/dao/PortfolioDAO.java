package com.chainsys.tradingapp.dao;

import java.util.List;

import com.chainsys.tradingapp.model.Portfolio;

public interface PortfolioDAO {
	 
    Portfolio getPortfolioById(int portfolioId);
    List<Portfolio> getPortfoliosByUserId(int userId);
}