package com.albedo.java.common.persistence.injector.methods;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:12
 */
@Deprecated
public enum SqlCustomMethod {
	/**
	 * 查询包含关联对象集合
	 */
	FIND_RELATION_LIST("findRelationList", "查询包含关联对象集合", "<script>SELECT %s FROM %s %s</script>"),
	/**
	 * 查询包含关联对象集合（并翻页）
	 */
	FIND_RELATION_PAGE("findRelationPage", "查询包含关联对象集合（并翻页）", "<script>SELECT %s FROM %s %s</script>");

	private final String method;
	private final String desc;
	private final String sql;

	SqlCustomMethod(String method, String desc, String sql) {
		this.method = method;
		this.desc = desc;
		this.sql = sql;
	}

	public String getMethod() {
		return this.method;
	}

	public String getDesc() {
		return this.desc;
	}

	public String getSql() {
		return this.sql;
	}
}
