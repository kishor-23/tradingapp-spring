package com.chainsys.tradingapp.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
	 private static final String SYMBOL = "symbol";


    @Autowired
    public StockController(StockImpl stockImpl) {
        this.stockOperations = stockImpl;
    }

    @GetMapping("/stockDetail")
    public String getStockDetail(@RequestParam("stockid")  Integer stockid, Model model) {
        model.addAttribute("stockid" , stockid);
        return "viewstocks.jsp";
    }

    @GetMapping("/stocks")
    public String viewStocks(@RequestParam(defaultValue = "1") int page,
                             @RequestParam(defaultValue = "10") int itemsPerPage,
                             @RequestParam(required = false) String searchQuery,
                             @RequestParam(defaultValue = "All") String filterCategory,
                             @RequestParam(required = false) String sortField,
                             @RequestParam(defaultValue = "true") boolean sortOrder,
                             Model model) {
        try {
            List<Stock> allStocks = stockOperations.selectAllStocks();
            List<Stock> filteredStocks = filterStocks(allStocks, filterCategory);
            List<Stock> searchedStocks = searchStocks(filteredStocks, searchQuery);
            sortStocks(searchedStocks, sortField, sortOrder);

            int totalItems = searchedStocks.size();
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            int startItemIndex = (page - 1) * itemsPerPage;
            int endItemIndex = Math.min(startItemIndex + itemsPerPage, totalItems);

            List<Stock> paginatedStocks = searchedStocks.subList(startItemIndex, endItemIndex);

            setRequestAttributes(model, paginatedStocks, totalPages, page, itemsPerPage, filterCategory, searchQuery, sortField, sortOrder);

            return "stock.jsp";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "An unexpected error occurred");
            return "error";
        }
    }

    private List<Stock> filterStocks(List<Stock> stocks, String filterCategory) {
        if ("All".equals(filterCategory)) {
            return stocks;
        }
        List<Stock> filteredStocks = new ArrayList<>();
        for (Stock stock : stocks) {
            if (stock.getCapCategory().equalsIgnoreCase(filterCategory)) {
                filteredStocks.add(stock);
            }
        }
        return filteredStocks;
    }

    private List<Stock> searchStocks(List<Stock> stocks, String searchQuery) {
        if (searchQuery == null || searchQuery.isEmpty()) {
            return stocks;
        }
        String upperCaseSearchQuery = searchQuery.toUpperCase();
        List<Stock> searchedStocks = new ArrayList<>();
        for (Stock stock : stocks) {
            if (stock.getSymbol().toUpperCase().contains(upperCaseSearchQuery)
                    || stock.getCompanyName().toUpperCase().contains(upperCaseSearchQuery)) {
                searchedStocks.add(stock);
            }
        }
        return searchedStocks;
    }

    private void sortStocks(List<Stock> stocks, String sortField, boolean sortOrder) {
        if (sortField == null) {
            return;
        }
        Comparator<Stock> comparator =  Comparator.comparing(Stock::getCurrentStockPrice);
        
        if (comparator != null) {
            if (!sortOrder) {
                comparator = comparator.reversed();
            }
            Collections.sort(stocks, comparator);
        }
    }

    private void setRequestAttributes(Model model, List<Stock> paginatedStocks, int totalPages,
                                      int currentPage, int itemsPerPage, String filterCategory,
                                      String searchQuery, String sortField, boolean sortOrder) {
        model.addAttribute("listStocks", paginatedStocks);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("itemsPerPage", itemsPerPage);
        model.addAttribute("filterCategory", filterCategory);
        model.addAttribute("searchQuery", searchQuery != null ? searchQuery : "");
        model.addAttribute("sortField", sortField != null ? sortField : SYMBOL );
        model.addAttribute("sortOrder", sortOrder);
    }
    
}
