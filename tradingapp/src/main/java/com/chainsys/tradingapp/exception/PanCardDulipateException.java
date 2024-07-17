package com.chainsys.tradingapp.exception;

import org.springframework.dao.DuplicateKeyException;

public class PanCardDulipateException extends DuplicateKeyException {

	public PanCardDulipateException(String msg) {
		super(msg);
	}

}
