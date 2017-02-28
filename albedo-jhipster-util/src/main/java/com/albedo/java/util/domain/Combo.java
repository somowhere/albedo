package com.albedo.java.util.domain;

import java.io.Serializable;

public class Combo implements Serializable {

	private static final long serialVersionUID = 1L;
	private String id; // 下拉列表隐藏值
	private String name; // 下拉列表显示值
	private String parentId; // 树形结构父节点
	private String url; // 数据源地址
	private String target; // 目标
	private String where; // 数据源地址Hql 拼接条件
	private String module; // 实体名称
	private String ckecked; // 是否显示复选框
	private String extId; // 排除掉的编号（不能选择的编号）
	private String selectIds; // 默认选择值

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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getWhere() {
		return where;
	}

	public void setWhere(String where) {
		this.where = where;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getCkecked() {
		return ckecked;
	}

	public void setCkecked(String ckecked) {
		this.ckecked = ckecked;
	}

	public String getExtId() {
		return extId;
	}

	public void setExtId(String extId) {
		this.extId = extId;
	}

	public String getSelectIds() {
		return selectIds;
	}

	public void setSelectIds(String selectIds) {
		this.selectIds = selectIds;
	}

}
