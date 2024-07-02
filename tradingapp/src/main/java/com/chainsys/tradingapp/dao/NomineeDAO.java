package com.chainsys.tradingapp.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.model.Nominee;
@Repository
public interface NomineeDAO {
	public void addNominee(Nominee nominee) ;
    public  Nominee getNomineeById(int nomineeId) ;
    public List<Nominee> getAllNomineesByUserId(int userId) ;
    public void updateNominee(Nominee nominee) ;
    public void deleteNominee(int nomineeId) ;
}
