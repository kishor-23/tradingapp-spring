package com.chainsys.tradingapp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.tradingapp.model.Nominee;

public class NomineeRowMapper implements RowMapper<Nominee> {
    @Override
    public Nominee mapRow(ResultSet rs, int rowNum) throws SQLException {
        Nominee nominee = new Nominee();
        nominee.setNomineeId(rs.getInt("nominee_id"));
        nominee.setNomineeName(rs.getString("nominee_name"));
        nominee.setRelationship(rs.getString("relationship"));
        nominee.setUserId(rs.getInt("user_id"));
        nominee.setPhoneno(rs.getString("phone_no"));
        return nominee;
    }
}