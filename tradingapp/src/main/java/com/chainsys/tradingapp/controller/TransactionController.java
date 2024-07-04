package com.chainsys.tradingapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.chainsys.tradingapp.dao.impl.StockImpl;

@Controller
public class TransactionController {
	 @Autowired
	    private StockImpl stockDAO;

	    private static final String ERROR_MESSAGE = "error";
	    private static final String ERROR_FILE = "fail";

	    @PostMapping("/StockTransaction")
	    public ModelAndView handleTransaction(@RequestParam("transactionType") String transactionType,
	                                          @RequestParam("userid") int userId,
	                                          @RequestParam("stockId") int stockId,
	                                          @RequestParam("quantity") int quantity,
	                                          @RequestParam("price") double price,
	                                          Model model) {
	        if ("buy".equalsIgnoreCase(transactionType)) {
	            return handleBuy(userId, stockId, quantity, price, model);
	        } else if ("sell".equalsIgnoreCase(transactionType)) {
	            return handleSell(userId, stockId, quantity, price, model);
	        } else {
	            // Invalid transaction type
	            model.addAttribute(ERROR_MESSAGE, "Invalid transaction type");
	            return new ModelAndView(ERROR_FILE);
	        }
	    }

	    private ModelAndView handleBuy(int userId, int stockId, int quantity, double price, Model model) {
	        int result = stockDAO.buyStock(userId, stockId, quantity, price);

	        if (result == 1) {
	            // Redirect to ordersuccess.jsp with URL parameters
	            return new ModelAndView("redirect:/ordersuccess", "userid", userId)
	                    .addObject("stockId", stockId)
	                    .addObject("quantity", quantity)
	                    .addObject("price", price)
	                    
	                    .addObject("transactionType", "buy");
	        } else {
	            model.addAttribute(ERROR_MESSAGE, "insufficientBalance");
	            return new ModelAndView(ERROR_FILE);
	        }
	    }

	    private ModelAndView handleSell(int userId, int stockId, int quantity, double price, Model model) {
	        int result = stockDAO.sellStock(userId, stockId, quantity, price);

	        if (result == 1) {
	            // Redirect to ordersuccess.jsp with URL parameters
	            return new ModelAndView("redirect:/ordersuccess", "userid", userId)
	                    .addObject("stockId", stockId)
	                    .addObject("quantity", quantity)
	                    .addObject("price", price)
	                    .addObject("transactionType", "sell");
	        } else {
	            model.addAttribute(ERROR_MESSAGE, "you don't have that stock to sell");
	            return new ModelAndView(ERROR_FILE);
	        }
	    }

}
