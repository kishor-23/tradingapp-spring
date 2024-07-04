package com.chainsys.tradingapp.controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chainsys.tradingapp.dao.StockDAO;
import com.chainsys.tradingapp.dao.impl.StockImpl;
import com.chainsys.tradingapp.model.Stock;

@Controller
public class StockController {

    private final StockDAO stockOperations;
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public StockController(StockImpl stockImpl, JdbcTemplate jdbcTemplate) {
        this.stockOperations = stockImpl;
        this.jdbcTemplate = jdbcTemplate;
    }

    @GetMapping("/stockDetail")
    public String getStockDetail(@RequestParam("symbol") String symbol, Model model) {
        model.addAttribute("symbol", symbol);
        return "viewstocks.jsp";
    }

    @GetMapping("/stocks")
    public String viewStocks(@RequestParam(value = "page", defaultValue = "1") int page,
                             @RequestParam(value = "itemsPerPage", defaultValue = "10") int itemsPerPage,
                             @RequestParam(value = "searchQuery", required = false) String searchQuery,
                             @RequestParam(value = "filterCategory", required = false) String filterCategory,
                             @RequestParam(value = "sortField", required = false) String sortField,
                             @RequestParam(value = "sortOrder", required = false) Boolean sortOrder,
                             Model model) {
        try {
            // Fetch all stocks from database with optional sorting
            List<Stock> allStocks = selectAllStocks(sortField, sortOrder);

            // Apply filtering based on filterCategory
            List<Stock> filteredStocks = filterStocks(allStocks, filterCategory);

            // Apply searching based on searchQuery
            List<Stock> searchedStocks = searchStocks(filteredStocks, searchQuery);

            // Pagination logic
            int totalItems = searchedStocks.size();
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            int startItemIndex = (page - 1) * itemsPerPage;
            int endItemIndex = Math.min(startItemIndex + itemsPerPage, totalItems);

            // Extract paginated subset of stocks
            List<Stock> paginatedStocks = searchedStocks.subList(startItemIndex, endItemIndex);

            // Set model attributes for view rendering
            setModelAttributes(model, paginatedStocks, totalPages, page, itemsPerPage, filterCategory,
                    searchQuery, sortField, sortOrder);

            return "stock.jsp";
        } catch (Exception e) {
            model.addAttribute("error", "An unexpected error occurred");
            return "error";
        }
    }

    private List<Stock> selectAllStocks(String sortField, Boolean sortOrder) {
        // Construct SQL query to fetch all stocks with optional sorting
        String sql = "SELECT * FROM stocks";

        // Append ORDER BY clause based on sortField and sortOrder
        if (sortField != null && isValidSortField(sortField)) {
            sql += " ORDER BY " + sortField;
            if (sortOrder != null && !sortOrder) {
                sql += " DESC";
            }
        }

        // Execute query and map result to Stock objects using RowMapper
        return jdbcTemplate.query(sql, new StockRowMapper());
    }

    private boolean isValidSortField(String sortField) {
        // Validate if sortField is a valid field for sorting
        switch (sortField) {
            case "symbol":
            case "companyName":
            case "currentStockPrice":
            case "capCategory":
                return true;
            default:
                return false;
        }
    }

    private List<Stock> filterStocks(List<Stock> stocks, String filterCategory) {
        // Filter stocks based on filterCategory
        if (filterCategory == null || "All".equals(filterCategory)) {
            return stocks;  // Return all stocks if no filter or "All" category
        }

        // Create list to hold filtered stocks
        List<Stock> filteredStocks = new ArrayList<>();
        for (Stock stock : stocks) {
            if (filterCategory.equalsIgnoreCase(stock.getCapCategory())) {
                filteredStocks.add(stock);  // Add stock to filtered list if matches filterCategory
            }
        }
        return filteredStocks;  // Return filtered stocks
    }

    private List<Stock> searchStocks(List<Stock> stocks, String searchQuery) {
        // Search stocks based on searchQuery
        if (searchQuery == null || searchQuery.isEmpty()) {
            return stocks;  // Return all stocks if no search query
        }

        // Convert searchQuery to uppercase for case-insensitive search
        String upperCaseSearchQuery = searchQuery.toUpperCase();

        // Create list to hold searched stocks
        List<Stock> searchedStocks = new ArrayList<>();
        for (Stock stock : stocks) {
            // Check if symbol or company name contains searchQuery (case-insensitive)
            if (stock.getSymbol().toUpperCase().contains(upperCaseSearchQuery)
                    || stock.getCompanyName().toUpperCase().contains(upperCaseSearchQuery)) {
                searchedStocks.add(stock);  // Add stock to searched list if matches searchQuery
            }
        }
        return searchedStocks;  // Return searched stocks
    }

    private void setModelAttributes(Model model, List<Stock> paginatedStocks, int totalPages,
                                    int currentPage, int itemsPerPage, String filterCategory,
                                    String searchQuery, String sortField, Boolean sortOrder) {
        // Set model attributes for rendering in view
        model.addAttribute("listStocks", paginatedStocks);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("itemsPerPage", itemsPerPage);
        model.addAttribute("filterCategory", filterCategory != null ? filterCategory : "All");
        model.addAttribute("searchQuery", searchQuery != null ? searchQuery : "");
        model.addAttribute("sortField", sortField != null ? sortField : "symbol");
        model.addAttribute("sortOrder", sortOrder != null ? sortOrder : true);  // Default to ascending order if sortOrder is null
    }

    // RowMapper for mapping result set rows to Stock objects
    private static class StockRowMapper implements RowMapper<Stock> {
        @Override
        public Stock mapRow(ResultSet rs, int rowNum) throws SQLException {
            // Map ResultSet row to Stock object
            Stock stock = new Stock();
            stock.setSymbol(rs.getString("symbol"));
            stock.setCompanyName(rs.getString("company_name"));
            stock.setCurrentStockPrice(rs.getDouble("current_stock_price"));
            stock.setCapCategory(rs.getString("cap_category"));
            return stock;  // Return mapped Stock object
        }
    }
    
}
