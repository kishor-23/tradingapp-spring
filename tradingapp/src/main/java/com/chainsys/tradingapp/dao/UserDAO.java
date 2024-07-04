package com.chainsys.tradingapp.dao;

import java.sql.Blob;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.model.User;

@Repository
public interface UserDAO {
	public void addUser(User user) ;
	public User  getUserByEmail(String email) throws ClassNotFoundException, SQLException ;
	public boolean checkUserAlreadyExists(String mailId);
	public Blob getUserProfilePicture(int userId);
	public void updateUserProfilePicture(int userId, Blob profilePicture);
	 public void addMoneyToUser(int userId, double amount) ;
}
