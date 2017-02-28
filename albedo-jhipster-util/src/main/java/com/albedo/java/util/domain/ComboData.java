package com.albedo.java.util.domain;

import java.io.Serializable;

public class ComboData implements Serializable {

	private static final long serialVersionUID = 1L;
	public static final String F_NAME = "name";
	public static final String F_ID = "id";
	public static final String F_PID = "pId";
	
	
	private String id; // 下拉列表隐藏值
	private String name; // 下拉列表显示值
	private String pId; // 树形结构父节点

	public ComboData() {
	}
	public ComboData(String id, String name) {
		this.id = id;
		this.name = name;
	}

	public ComboData(String id, String name, String pId) {
		this.id = id;
		this.name = name;
		this.pId = pId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}


}
