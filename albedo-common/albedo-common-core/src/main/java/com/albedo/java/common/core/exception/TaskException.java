package com.albedo.java.common.core.exception;

/**
 * 计划策略异常
 *
 * @author somewhere
 */
public class TaskException extends Exception {

	private static final long serialVersionUID = 1L;

	private Code code;

	public TaskException(String msg, Code code) {
		this(msg, code, null);
	}

	public TaskException(String msg, Code code, Exception nestedEx) {
		super(msg, nestedEx);
		this.code = code;
	}

	public Code getCode() {
		return code;
	}

	public enum Code {

		/**
		 * TASK_EXISTS
		 */
		TASK_EXISTS,
		/**
		 * NO_TASK_EXISTS
		 */
		NO_TASK_EXISTS,
		/**
		 * TASK_ALREADY_STARTED
		 */
		TASK_ALREADY_STARTED,
		/**
		 * UNKNOWN
		 */
		UNKNOWN,
		/**
		 * CONFIG_ERROR
		 */
		CONFIG_ERROR,
		/**
		 * TASK_NODE_NOT_AVAILABLE
		 */
		TASK_NODE_NOT_AVAILABLE

	}

}
