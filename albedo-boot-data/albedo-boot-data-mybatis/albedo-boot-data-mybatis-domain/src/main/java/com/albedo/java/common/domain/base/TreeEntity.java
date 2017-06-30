package com.albedo.java.common.domain.base;

import com.albedo.java.util.annotation.SearchField;
import com.albedo.java.util.domain.QueryCondition.Operator;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.JoinColumn;
import org.springframework.data.mybatis.annotations.ManyToOne;
import org.springframework.data.mybatis.annotations.MappedSuperclass;

/**
 * 数据TreeEntity类
 * 
 * @author lijie version 2013-12-27 下午12:27:10
 */
@MappedSuperclass
public abstract class TreeEntity<T extends DataEntity> extends IdEntity {

	public static final String ROOT = "1";
	private static final long serialVersionUID = 1L;
	public static final String F_NAME = "name";
	public static final String F_PARENTID = "parentId";
	public static final String F_PARENTIDS = "parentIds";
	public static final String F_ISLEAF = "isLeaf";
	public static final String F_SORT = "sort";
	public static final String F_PARENT = "parent";
	
	/*** 组织名称 */
	@SearchField(op = Operator.like)
	@Column(name = "name_")
	protected String name;
	/*** 上级组织 */
	@SearchField
	@Column(name = "parent_id")
	protected String parentId;
	/*** 所有父编号 */
	@SearchField(op = Operator.like)
	@Column(name = "parent_ids")
	protected String parentIds;
	/*** 上级组织 */
	@ManyToOne
	@JoinColumn(name = "parent_id", updatable = false, insertable = false)
	protected T parent;
	/*** 1 叶子节点 0非叶子节点 */
	@Column(name = "is_leaf")
	private boolean isLeaf=false;
	/*** 序号 */
	@Column(name = "sort_")
	protected Integer sort = 30;

	public TreeEntity() {
		super();
		this.sort = 30;
	}

	public T getParent() {
		return parent;
	}

	public void setParent(T parent) {
		this.parent = parent;
	}

	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getParentId() {
		return parentId;
	}

	public boolean isLeaf() {
		return isLeaf;
	}

	protected boolean getIsLeaf() {
		return isLeaf;
	}	
	public void setLeaf(boolean isLeaf) {
		this.isLeaf = isLeaf;
	}

}
