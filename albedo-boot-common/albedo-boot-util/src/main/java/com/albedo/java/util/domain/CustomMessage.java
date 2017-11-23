package com.albedo.java.util.domain;

import lombok.ToString;
import org.springframework.util.ObjectUtils;

import java.io.Serializable;

/**
 * 基础控制器支持类 copyright 2014 albedo all right reserved author MrLi created on
 * 2014年10月15日 下午4:04:00
 */
@ToString
public class CustomMessage<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    private int status;
    private T data;
    private String code;
    private String[] messages = {};

    public CustomMessage() {
    }

    public CustomMessage(T data, Integer status, String... messages) {
        this.status = status;
        this.messages = messages;
        this.data = data;
    }

    public static CustomMessage create(Object data, int status, String... message) {
        CustomMessage msgModel = new CustomMessage(data, status, message);
        return msgModel;
    }

    public static CustomMessage createSuccess(Object data, String... message) {
        return create(data, Globals.MSG_TYPE_SUCCESS, message);
    }

    public static CustomMessage createSuccess(String... message) {
        return create(null, Globals.MSG_TYPE_SUCCESS, message);
    }

    public static CustomMessage createWarn(Object data, String... message) {
        return create(data, Globals.MSG_TYPE_WARNING, message);
    }

    public static CustomMessage createWarn(String... message) {
        return create(null, Globals.MSG_TYPE_WARNING, message);
    }

    public static CustomMessage createError(Object data, String... messages) {
        return create(data, Globals.MSG_TYPE_ERROR, messages);
    }

    public static CustomMessage createError(String... messages) {
        return create(null, Globals.MSG_TYPE_ERROR, messages);
    }

    public String getMessage() {
        return readMessages();
    }

    public void setMessage(String message) {
        addMessage(message);
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String readMessages() {
        StringBuilder sb = new StringBuilder();
        for (String message : messages) {
            sb.append(message);
        }
        return sb.toString();
    }

    public void addMessage(String message) {
        this.messages = ObjectUtils.addObjectToArray(messages, message);
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
