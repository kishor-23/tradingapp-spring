package com.chainsys.tradingapp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.tradingapp.model.User;

public class UserRowMapper implements RowMapper<User> {
    @Override
    public User mapRow(ResultSet rs, int rowNum) throws SQLException {
    	  User user = new User();
          user.setId(rs.getInt("id"));
          user.setName(rs.getString("name"));
          user.setEmail(rs.getString("email"));
          user.setPancardno(rs.getString("pancardno"));
          user.setPhone(rs.getString("phone"));
          user.setDob(rs.getDate("dob"));
          user.setProfilePicture(rs.getBlob("profilePicture"));
          user.setBalance(rs.getDouble("balance"));
          user.setPassword(rs.getString("password"));
          return user;
    }
}