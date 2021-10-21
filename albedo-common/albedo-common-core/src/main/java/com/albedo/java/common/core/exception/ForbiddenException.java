package com.albedo.java.common.core.exception;

import com.albedo.java.common.core.exception.code.BaseExceptionCode;
import com.albedo.java.common.core.exception.code.ResponseCode;

/**
 * 403  禁止访问
 *
 * @author somewhere
 * @version 1.0
 */
public class ForbiddenException extends BaseUncheckedException {

	private static final long serialVersionUID = 1L;

	public ForbiddenException(int code, String message) {
		super(code, message);
	}

	public static ForbiddenException wrap(BaseExceptionCode ex) {
		return new ForbiddenException(ex.getCode(), ex.getMessage());
	}

	public static ForbiddenException wrap(String msg) {
		return new ForbiddenException(ResponseCode.FORBIDDEN.getCode(), msg);
	}

	@Override
	public String toString() {
		return "ForbiddenException [message=" + getMessage() + ", errorCode=" + getErrorCode() + "]";
	}
}
