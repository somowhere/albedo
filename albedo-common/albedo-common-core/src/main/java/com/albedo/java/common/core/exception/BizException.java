package com.albedo.java.common.core.exception;


import com.albedo.java.common.core.exception.code.BaseExceptionCode;
import com.albedo.java.common.core.exception.code.ResponseCode;

/**
 * 业务异常
 * 用于在处理业务逻辑时，进行抛出的异常。
 *
 * @author somewhere
 * @version 1.0
 */
public class BizException extends BaseUncheckedException {

	private static final long serialVersionUID = -3843907364558373817L;

	public BizException(Throwable cause) {
		super(cause);
	}

	public BizException(int code, Throwable cause) {
		super(code, cause);
	}

	public BizException(String message) {
		super(ResponseCode.FAIL.getCode(), message);
	}

	public BizException(String message, Throwable cause) {
		super(ResponseCode.FAIL.getCode(), message, cause);
	}

	public BizException(int code, String message) {
		super(code, message);
	}

	public BizException(int code, String message, Throwable cause) {
		super(code, message, cause);
	}

	public BizException(int code, String message, Object... args) {
		super(code, message, args);
	}

	/**
	 * 实例化异常
	 *
	 * @param code    自定义异常编码
	 * @param message 自定义异常消息
	 * @param args    已定义异常参数
	 * @return 异常实例
	 */
	public static BizException wrap(int code, String message, Object... args) {
		return new BizException(code, message, args);
	}

	public static BizException wrap(String message, Object... args) {
		return new BizException(ResponseCode.FAIL.getCode(), message, args);
	}

	public static BizException validFail(String message, Object... args) {
		return new BizException(ResponseCode.BASE_VALID_PARAM.getCode(), message, args);
	}

	public static BizException wrap(BaseExceptionCode ex) {
		return new BizException(ex.getCode(), ex.getMessage());
	}

	public static BizException wrap(BaseExceptionCode ex, Throwable cause) {
		return new BizException(ex.getCode(), ex.getMessage(), cause);
	}

	@Override
	public String toString() {
		return "BizException [message=" + getMessage() + ", errorCode=" + getErrorCode() + "]";
	}

}
