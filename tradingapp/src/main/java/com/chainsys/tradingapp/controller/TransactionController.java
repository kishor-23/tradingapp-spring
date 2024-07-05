package com.chainsys.tradingapp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.chainsys.tradingapp.dao.TransactionDAO;
import com.chainsys.tradingapp.dao.impl.StockImpl;
import com.chainsys.tradingapp.model.Transaction;

@Controller
public class TransactionController {

    @Autowired
    private StockImpl stockDAO;

    private final TransactionDAO transactionDAO;

    @Autowired
    public TransactionController(TransactionDAO transactionDAO) {
        this.transactionDAO = transactionDAO;
    }


    private static final String ERROR_MESSAGE = "error";
    private static final String ERROR_FILE = "fail.jsp";
   @GetMapping("/ordersuccess")
   public String orderSuccess() {
	   return "ordersuccess.jsp";
   }
    @PostMapping("/StockTransaction")
    public String handleTransaction(@RequestParam("transactionType") String transactionType,
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
            model.addAttribute(ERROR_MESSAGE, "Invalid transaction type");
            return ERROR_FILE;
        }
    }

    private String handleBuy(int userId, int stockId, int quantity, double price, Model model) {
        int result = stockDAO.buyStock(userId, stockId, quantity, price);

        if (result == 1) {
            return "redirect:/ordersuccess?userid=" + userId + "&stockId=" + stockId + "&quantity=" + quantity + "&price=" + price + "&transactionType=buy";
        } else {
            model.addAttribute(ERROR_MESSAGE, "insufficientBalance");
            return ERROR_FILE;
        }
    }

    private String handleSell(int userId, int stockId, int quantity, double price, Model model) {
        int result = stockDAO.sellStock(userId, stockId, quantity, price);

        if (result == 1) {
            return "redirect:/ordersuccess?userid=" + userId + "&stockId=" + stockId + "&quantity=" + quantity + "&price=" + price + "&transactionType=sell";
        } else {
            model.addAttribute(ERROR_MESSAGE, "you don't have that stock to sell");
            return ERROR_FILE;
        }
    }
    @PostMapping("/transactions")
    public String getTransactions(@RequestParam("userId") Integer userId, Model model) {
        List<Transaction> transactions = null;

        if (userId != null) {
            transactions = transactionDAO.getTransactionsByUserId(userId);
        }

        model.addAttribute("transactions", transactions);
        return "transactions.jsp";
    }
}