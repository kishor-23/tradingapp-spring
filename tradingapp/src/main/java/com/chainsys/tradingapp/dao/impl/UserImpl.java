package com.chainsys.tradingapp.dao.impl;


import java.sql.Blob;
import java.sql.SQLException;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;


import com.chainsys.tradingapp.dao.UserDAO;
import com.chainsys.tradingapp.mapper.UserRowMapper;
import com.chainsys.tradingapp.model.User;





@Repository
public class UserImpl implements UserDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public UserImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public boolean checkUserAlreadyExists(String mailId) {
        String selectQuery = "SELECT email FROM users WHERE email = ?";
        List<String> existingUsers = jdbcTemplate.query(selectQuery, (rs, rowNum) -> rs.getString("email"), mailId);
        return !existingUsers.isEmpty();
    }

    @Override
    public User getUserByEmail(String email) throws SQLException {
        String selectQuery = "SELECT id, name, email, pancardno, phone, dob, profilePicture, password, balance FROM users WHERE email = ?";
        try {
            return jdbcTemplate.queryForObject(selectQuery, new UserRowMapper(), email);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }


    @Override
    public void addUser(User user) {
        String insertQuery = "INSERT INTO users (name, email, pancardno, phone, dob, password, profilePicture, balance) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        Blob profilePictureBlob = user.getProfilePicture();
        jdbcTemplate.update(insertQuery, user.getName(), user.getEmail(), user.getPancardno(), user.getPhone(), user.getDob(), user.getPassword(), profilePictureBlob, user.getBalance());
    }

    public void addMoneyToUser(int userId, double amount) {
        String sql = "UPDATE users SET balance = balance + ? WHERE id = ?";
        jdbcTemplate.update(sql, amount, userId);
    }

    public void updateUserProfilePicture(int userId, Blob profilePicture) {
        String sql = "UPDATE users SET profilePicture = ? WHERE id = ?";
        jdbcTemplate.update(sql, profilePicture, userId);
    }

    public Blob getUserProfilePicture(int userId) {
        String sql = "SELECT profilePicture FROM users WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> rs.getBlob("profilePicture"), userId);
    }
}


