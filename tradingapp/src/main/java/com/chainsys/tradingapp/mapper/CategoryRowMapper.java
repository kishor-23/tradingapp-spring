package com.chainsys.tradingapp.mapper;


import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.tradingapp.model.Category;

public class CategoryRowMapper implements RowMapper<Category> {
    @Override
    public Category mapRow(ResultSet resultSet, int i) throws SQLException {
        Category categoryQuantity = new Category();
        categoryQuantity.setCapCategory(resultSet.getString("cap_category"));
        categoryQuantity.setTotalQuantity(resultSet.getInt("total_quantity"));
        categoryQuantity.setUserTotalQuantity(resultSet.getInt("user_total_quantity"));
        return categoryQuantity;
    }
}


