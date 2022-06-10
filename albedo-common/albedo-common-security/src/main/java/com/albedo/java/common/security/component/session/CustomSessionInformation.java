package com.albedo.java.common.security.component.session;

import org.springframework.security.core.session.SessionInformation;

import java.util.Date;

/**
 * 自定义的目的主要是redis序列化时需要默认构造，SessionInformation没有默认构造
 *
 * @author somewhere
 */
public class CustomSessionInformation extends SessionInformation {
	private static final Object PRINCIPAL = new Object();
	private static final Date LAST_REQUEST = new Date();

	public CustomSessionInformation() {
		super(PRINCIPAL, "-1", LAST_REQUEST);
	}

	public CustomSessionInformation(Object principal, String sessionId, Date lastRequest) {
		super(principal, sessionId, lastRequest);
	}


}
