package com.albedo.java.common.core.exception;

/**
 * 运行期异常基类
 *
 * @author somewhere
 * @version 1.0
 */
public abstract class BaseCheckedException extends Exception implements BaseException {

	private static final long serialVersionUID = 2706069899924648586L;

	/**
	 * 异常信息
	 */
    private final String message;

	/**
	 * 具体异常码
	 */
    private final int errorCode;

	public BaseCheckedException(final int errorCode, final String message) {
		super(message);
		this.errorCode = errorCode;
		this.message = message;
	}

	public BaseCheckedException(final int errorCode, final String format, Object... args) {
		super(String.format(format, args));
		this.errorCode = errorCode;
		this.message = String.format(format, args);
	}

	/**
	 * 获取 异常消息
	 *
	 * @return 异常消息
	 */
	@Override
	public String getMessage() {
		return message;
	}


	/**
	 * 获取 错误码
	 *
	 * @return 错误码
	 */
	@Override
	public int getErrorCode() {
		return errorCode;
	}


}
