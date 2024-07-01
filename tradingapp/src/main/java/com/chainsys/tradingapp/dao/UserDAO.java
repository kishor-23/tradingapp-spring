package com.chainsys.tradingapp.dao;

import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.model.User;

@Repository
public interface UserDAO {
	void addUser(User user) ;
	User  getUserByEmail(String email) throws ClassNotFoundException, SQLException ;
	boolean checkUserAlreadyExists(String mailId);
}
