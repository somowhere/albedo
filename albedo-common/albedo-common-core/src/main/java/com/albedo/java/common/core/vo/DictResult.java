package com.albedo.java.common.core.vo;

import lombok.Data;

/**
 * Copyright 2013 albedo All right reserved Author somewhere Created on 2013-10-23
 * 下午1:55:43
 */
@Data
public class DictResult {

	public static final String F_CODE = "code";
	public static final String F_NAME = "name";
	public static final String F_VAL = "val";
	/*** 名称 */
	private String name;
	/*** 编码 */
	private String code;
	/*** 字典值 */
	private String val;

	public DictResult() {
		super();
	}

	public DictResult(String name, String code, String val) {
		super();
		this.name = name;
		this.code = code;
		this.val = val;
	}

}
