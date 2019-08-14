package com.albedo.java.common.persistence.domain;

import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.persistence.annotation.ManyToOne;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * 数据TreeEntity类
 *
 * @author somewhere version 2013-12-27 下午12:27:10
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class TreeEntity<T extends TreeEntity<T>> extends IdEntity<T> {

	public static final String ROOT = "-1";
	public static final String F_NAME = "name";
	public static final String F_PARENTID = "parentId";
	public static final String F_PARENTIDS = "parentIds";
	public static final String F_LEAF = "leaf";
	public static final String F_SORT = "sort";
	public static final String F_PARENT = "parent";
	public static final String F_SQL_NAME = "name";
	public static final String F_SQL_PARENTID = "parent_id";
	public static final String F_SQL_PARENTIDS = "parent_ids";
	public static final String F_SQL_LEAF = "leaf";
	public static final String F_SQL_SORT = "sort";
	private static final long serialVersionUID = 1L;
	/*** 组织名称 */
	@TableField(TreeEntity.F_SQL_NAME)
	@NotBlank(message = "名称不能为空")
	protected String name;
	/*** 上级组织 */
	@TableField(TreeEntity.F_SQL_PARENTID)
	@NotNull(message = "父ID不能为空")
	protected String parentId;
	/*** 所有父编号 */
	@TableField(TreeEntity.F_SQL_PARENTIDS)
	protected String parentIds;
	/*** 上级组织 */
	@TableField(exist = false)
	@ManyToOne(name = TreeEntity.F_SQL_PARENTID)
	@JsonIgnore
	protected T parent;
	/*** 序号 */
	@TableField(TreeEntity.F_SQL_SORT)
	protected Integer sort;
	/*** 父模块名称 */
	@TableField(exist = false)
	protected String parentName;
	/*** 1 叶子节点 0非叶子节点 */
	@TableField(TreeEntity.F_SQL_LEAF)
	private boolean leaf = false;

	public TreeEntity() {
		super();
		this.sort = 30;
	}

	public TreeEntity(String id) {
		super();
		this.id = id;
		this.sort = 30;
	}

	public String getParentName() {
		if (StringUtil.isEmpty(parentName) && parent != null) {
			parentName = parent.getName();
		}
		return parentName;
	}

}
