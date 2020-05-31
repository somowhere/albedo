package com.albedo.java.common.core.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class ComboData implements Serializable {

	public static final String F_LABEL = "label";
	public static final String F_VALUE = "value";
	public static final String F_PID = "pId";
	private static final long serialVersionUID = 1L;
	private String value;
	private String label;
	private String pId;

	public ComboData() {
	}

	public ComboData(String value, String label) {
		this.value = value;
		this.label = label;
	}

	public ComboData(String value, String label, String pId) {
		this.value = value;
		this.label = label;
		this.pId = pId;
	}


}
