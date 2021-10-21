package com.albedo.java.common.core.exception;

import cn.hutool.core.text.StrPool;
import cn.hutool.core.util.StrUtil;

/**
 * 非运行期异常基类，所有自定义非运行时异常继承该类
 *
 * @author somewhere
 * @version 1.0
 * @see RuntimeException
 */
public class BaseUncheckedException extends RuntimeException implements BaseException {

	private static final long serialVersionUID = -778887391066124051L;

	/**
	 * 异常信息
	 */
	private String message;

	/**
	 * 具体异常码
	 */
	private int errorCode;

	public BaseUncheckedException(Throwable cause) {
		super(cause);
	}

	public BaseUncheckedException(final int errorCode, Throwable cause) {
		super(cause);
		this.errorCode = errorCode;
	}


	public BaseUncheckedException(final int errorCode, final String message) {
		super(message);
		this.errorCode = errorCode;
		this.message = message;
	}

	public BaseUncheckedException(final int errorCode, final String message, Throwable cause) {
		super(cause);
		this.errorCode = errorCode;
		this.message = message;
	}

	public BaseUncheckedException(final int errorCode, final String format, Object... args) {
		super(StrUtil.contains(format, StrPool.EMPTY_JSON) ? StrUtil.format(format, args) : String.format(format, args));
		this.errorCode = errorCode;
		this.message = StrUtil.contains(format, StrPool.EMPTY_JSON) ? StrUtil.format(format, args) : String.format(format, args);
	}


	@Override
	public String getMessage() {
		return message;
	}

	@Override
	public int getErrorCode() {
		return errorCode;
	}
}
