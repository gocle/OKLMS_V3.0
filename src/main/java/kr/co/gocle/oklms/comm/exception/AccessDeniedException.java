package kr.co.gocle.oklms.comm.exception;

import org.egovframe.rte.fdl.cmmn.exception.BaseException;

public class AccessDeniedException extends BaseException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6920429379147670956L;

	public AccessDeniedException(String messageKey, Throwable causeThrowable) {
		super(messageKey, causeThrowable);
	}

	public AccessDeniedException(String messageKey) {
		super(messageKey);
	}

	public AccessDeniedException(String messageKey, Object[] args, Throwable causeThrowable) {
		super(messageKey, args, causeThrowable);
	}

}