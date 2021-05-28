package com.albedo.java.common.core.exception;

import lombok.NoArgsConstructor;

/**
 * @author somewhere
 * @date 😴2019年06月02日16:21:57
 */
@NoArgsConstructor
public class RuntimeMsgException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public RuntimeMsgException(String message) {
		super(message);
	}

	public RuntimeMsgException(Throwable cause) {
		super(cause);
	}

	public RuntimeMsgException(String message, Throwable cause) {
		super(message, cause);
	}

	public RuntimeMsgException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

}
