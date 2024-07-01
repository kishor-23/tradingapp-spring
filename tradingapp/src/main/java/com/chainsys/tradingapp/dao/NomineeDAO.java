package com.chainsys.tradingapp.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chainsys.tradingapp.model.Nominee;
@Repository
public interface NomineeDAO {
	void addNominee(Nominee nominee) ;
    Nominee getNomineeById(int nomineeId) ;
    List<Nominee> getAllNomineesByUserId(int userId) ;
    void updateNominee(Nominee nominee) ;
    void deleteNominee(int nomineeId) ;
}
