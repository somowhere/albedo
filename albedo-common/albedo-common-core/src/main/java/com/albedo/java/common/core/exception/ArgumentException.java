package com.albedo.java.common.core.exception;


import com.albedo.java.common.core.exception.code.ResponseCode;

/**
 * 业务参数异常
 * 用于在业务中，检测到非法参数时，进行抛出的异常。
 *
 * @author somewhere
 * @version 3.5.0
 */
public class ArgumentException extends BaseUncheckedException {

	private static final long serialVersionUID = -3843907364558373817L;

	public ArgumentException(Throwable cause) {
		super(cause);
	}

	public ArgumentException(String message) {
		super(ResponseCode.BASE_VALID_PARAM.getCode(), message);
	}

	public ArgumentException(String message, Throwable cause) {
		super(ResponseCode.BASE_VALID_PARAM.getCode(), message, cause);
	}

	public ArgumentException(final String format, Object... args) {
		super(ResponseCode.BASE_VALID_PARAM.getCode(), format, args);
	}

	@Override
	public String toString() {
		return "ArgumentException [message=" + getMessage() + ", errorCode=" + getErrorCode() + "]";
	}

}
