package com.chainsys.tradingapp.dao;

import com.chainsys.tradingapp.model.User;

public interface UserDAO {
	void addUser(User user) ;
	User  getUserByEmail(String email) ;
}
