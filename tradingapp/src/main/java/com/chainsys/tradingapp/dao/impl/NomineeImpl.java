package com.chainsys.tradingapp.dao.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.dao.NomineeDAO;
import com.chainsys.tradingapp.mapper.NomineeRowMapper;
import com.chainsys.tradingapp.model.Nominee;

import java.util.List;

@Repository
public class NomineeImpl implements NomineeDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public NomineeImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void addNominee(Nominee nominee) {
        String sql = "INSERT INTO Nominee (nominee_name, relationship, user_id, phone_no) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, nominee.getNomineeName(), nominee.getRelationship(), nominee.getUserId(), nominee.getPhoneno());
    }

    @Override
    public Nominee getNomineeById(int nomineeId) {
        String sql = "SELECT nominee_id, nominee_name, relationship, user_id, phone_no FROM Nominee WHERE nominee_id = ? AND is_deleted = FALSE";
        return jdbcTemplate.queryForObject(sql, new NomineeRowMapper(), nomineeId);
    }

    @Override
    public List<Nominee> getAllNomineesByUserId(int userId) {
        String sql = "SELECT nominee_id, nominee_name, relationship, phone_no, user_id FROM Nominee WHERE user_id = ? AND is_deleted = FALSE";
        return jdbcTemplate.query(sql, new NomineeRowMapper(), userId);
    }

    @Override
    public void updateNominee(Nominee nominee) {
        String sql = "UPDATE Nominee SET nominee_name = ?, relationship = ?, phone_no = ? WHERE nominee_id = ? AND is_deleted = FALSE";
        jdbcTemplate.update(sql, nominee.getNomineeName(), nominee.getRelationship(), nominee.getPhoneno(), nominee.getNomineeId());
    }

    @Override
    public void deleteNominee(int nomineeId) {
        String sql = "UPDATE Nominee SET is_deleted = TRUE WHERE nominee_id = ?";
        jdbcTemplate.update(sql, nomineeId);
    }
}
