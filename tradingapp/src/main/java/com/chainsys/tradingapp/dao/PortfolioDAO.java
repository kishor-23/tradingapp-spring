package com.chainsys.tradingapp.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.model.Category;
import com.chainsys.tradingapp.model.Portfolio;
@Repository
public interface PortfolioDAO {
	 
  public  Portfolio getPortfolioById(int portfolioId);
  public  List<Portfolio> getPortfoliosByUserId(int userId);
  public List<Category> getCategoryQuantities(int userId);
  public List<Category> getSectorCategoryQuantities(int userId);
}