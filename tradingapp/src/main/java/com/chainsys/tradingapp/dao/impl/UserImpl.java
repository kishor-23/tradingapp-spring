package com.chainsys.tradingapp.dao.impl;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;

import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
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

    
    public void addUser(User user) {
        String selectQuery = "SELECT email FROM users WHERE email = ?";
        String insertQuery = "INSERT INTO users (name, email, pancardno, phone, dob, password, profilePicture, balance) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        List<String> existingUsers = jdbcTemplate.query(selectQuery, (rs, rowNum) -> rs.getString("email"), user.getEmail());
        
        if (existingUsers.isEmpty()) {
            Blob profilePictureBlob = null;
            try {
                profilePictureBlob = new SerialBlob(user.getProfilePicture().getBytes());
            } catch (SerialException e) {
                e.printStackTrace();
            } catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

            jdbcTemplate.update(insertQuery, user.getName(), user.getEmail(), user.getPancardno(), user.getPhone(), user.getDob(), user.getPassword(), profilePictureBlob, user.getBalance());
        }
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
        
        return jdbcTemplate.queryForObject(selectQuery, new UserRowMapper(), email);
    }

    public void addMoneyToUser(int userId, double amount) {
        String sql = "UPDATE users SET balance = balance + ? WHERE id = ?";
        jdbcTemplate.update(sql, amount, userId);
    }
}
