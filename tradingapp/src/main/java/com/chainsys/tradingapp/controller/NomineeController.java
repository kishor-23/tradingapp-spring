package com.chainsys.tradingapp.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.chainsys.tradingapp.dao.NomineeDAO;
import com.chainsys.tradingapp.dao.UserDAO;
import com.chainsys.tradingapp.dao.impl.NomineeImpl;
import com.chainsys.tradingapp.dao.impl.UserImpl;
import com.chainsys.tradingapp.model.Nominee;
import com.chainsys.tradingapp.model.User;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/nominee")
@Validated
public class NomineeController {

    @Autowired
    private NomineeDAO nomineeOperations;

    @Autowired
    private UserDAO userOperations;

    @GetMapping("/list")
    public String listNominees(HttpSession session, Model model) throws SQLException, ClassNotFoundException {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        User updatedUser = userOperations.getUserByEmail(user.getEmail());
        List<Nominee> listNominees = nomineeOperations.getAllNomineesByUserId(user.getId());
        session.setAttribute("user", updatedUser);
        model.addAttribute("listNominees", listNominees);
        return "profile";
    }

    @PostMapping("/add")
    public String addNominee(@Valid @ModelAttribute Nominee nominee, HttpSession session) throws SQLException, ClassNotFoundException {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        nominee.setUserId(user.getId());
        nomineeOperations.addNominee(nominee);
        return "redirect:/nominee/list";
    }

    @PostMapping("/update")
    public String updateNominee(@Valid @ModelAttribute Nominee nominee) throws SQLException, ClassNotFoundException {
        nomineeOperations.updateNominee(nominee);
        return "redirect:/nominee/list";
    }

    @PostMapping("/delete")
    public String deleteNominee(@RequestParam int nomineeId) throws SQLException, ClassNotFoundException {
        nomineeOperations.deleteNominee(nomineeId);
        return "redirect:/nominee/list";
    }
}
