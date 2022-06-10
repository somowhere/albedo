package com.albedo.java.common.core.exception;

/**
 * @author somewhere
 * @date 2018-11-23
 */
public class FeignBizException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public FeignBizException(String message) {
		super(message);
	}

	public FeignBizException(Throwable cause) {
		super(cause);
	}

	public FeignBizException(String message, Throwable cause) {
		super(message, cause);
	}

	public FeignBizException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}
}
