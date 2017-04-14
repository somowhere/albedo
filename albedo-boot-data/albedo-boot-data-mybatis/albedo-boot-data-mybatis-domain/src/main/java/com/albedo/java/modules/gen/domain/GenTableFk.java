package com.albedo.java.modules.gen.domain;

/**
 * 业务表Entity
 * 
 * @version 2013-10-15
 */
public class GenTableFk {

	private String name; // 名称
	private String tableName; // 描述
	private String tableFk; // 外键列名
	private GenTable genTable; // 归属表

	public GenTableFk() {
		super();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getTableFk() {
		return tableFk;
	}

	public void setTableFk(String tableFk) {
		this.tableFk = tableFk;
	}

	public GenTable getGenTable() {
		return genTable;
	}

	public void setGenTable(GenTable genTable) {
		this.genTable = genTable;
	}

}
