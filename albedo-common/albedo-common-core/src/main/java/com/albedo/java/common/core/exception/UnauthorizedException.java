package com.albedo.java.common.core.exception;


import com.albedo.java.common.core.exception.code.ResponseCode;

/**
 * 401 未认证 未登录
 *
 * @author somewhere
 * @version 1.0
 */
public class UnauthorizedException extends BaseUncheckedException {

	private static final long serialVersionUID = 1L;

	public UnauthorizedException(int code, String message) {
		super(code, message);
	}

	public UnauthorizedException(int code, String message, Throwable cause) {
		super(code, message, cause);
	}

	public static UnauthorizedException wrap(String msg) {
		return new UnauthorizedException(ResponseCode.UNAUTHORIZED.getCode(), msg);
	}

	@Override
	public String toString() {
		return "UnauthorizedException [message=" + getMessage() + ", errorCode=" + getErrorCode() + "]";
	}

}
