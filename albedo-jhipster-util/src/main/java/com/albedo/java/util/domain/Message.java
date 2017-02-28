package com.albedo.java.util.domain;

import java.io.Serializable;

/**
 * 基础控制器支持类 copyright 2014 albedo all right reserved author MrLi created on
 * 2014年10月15日 下午4:04:00
 */
public class Message implements Serializable {

	private static final long serialVersionUID = 1L;

	private String status;

	private String message;

	private Object data;

	public static Message create(String status, String message, Object data) {
		Message msgModel = new Message(status, message, data);
		return msgModel;
	}

	public static Message createSuccessData(Object data) {
		return create(Globals.MSG_TYPE_SUCCESS, null, data);
	}

	public static Message createSuccess(String message, Object data) {
		return create(Globals.MSG_TYPE_SUCCESS, message, data);
	}

	public static Message createSuccess(String message) {
		return create(Globals.MSG_TYPE_SUCCESS, message, null);
	}

	public static Message createWarn(String message, Object data) {
		return create(Globals.MSG_TYPE_WARNING, message, data);
	}

	public static Message createWarn(String message) {
		return create(Globals.MSG_TYPE_WARNING, message, null);
	}

	public static Message createError(String message, Object data) {
		return create(Globals.MSG_TYPE_ERROR, message, data);
	}

	public static Message createError(String message) {
		return create(Globals.MSG_TYPE_ERROR, message, null);
	}

	public Message() {
	}

	public Message(String status, String message, Object data) {
		this.status = status;
		this.message = message;
		this.data = data;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

}
