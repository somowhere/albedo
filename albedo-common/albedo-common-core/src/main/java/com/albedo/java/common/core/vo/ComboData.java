package com.albedo.java.common.core.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class ComboData implements Serializable {

	public static final String F_LABEL = "label";
	public static final String F_VALUE = "value";
	public static final String F_PID = "pId";
	private static final long serialVersionUID = 1L;
	private String value; // 下拉列表隐藏值
	private String label; // 下拉列表显示值
	private String pId; // 树形结构父节点

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
