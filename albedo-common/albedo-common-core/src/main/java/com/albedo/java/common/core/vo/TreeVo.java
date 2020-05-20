package com.albedo.java.common.core.vo;

import com.albedo.java.common.core.util.tree.TreeNodeAware;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * 通常的数据基类 copyright 2014 albedo all right reserved author somewhere created on 2014年12月31日 下午1:57:09
 * @author somewhere
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class TreeVo<T> extends DataVo<String> implements TreeNodeAware<T> {
	public static final String F_NAME = "name";
	public static final String F_PARENTID = "parentId";
	public static final String F_PARENTIDS = "parentIds";
	public static final String F_ISLEAF = "leaf";
	public static final String F_SORT = "sort";
	public static final String F_PARENT = "parent";

	/*** 模块名称 */
	@NotBlank
	protected String name;
	/*** 上级模块 */
	protected String parentId;
	/*** 序号 */
	protected Integer sort;
	/*** 上级模块 */
	@JsonIgnore
	protected String parentIds;
	/*** 1 叶子节点 0非叶子节点 */
	@JsonIgnore
	private boolean leaf;

	private List<T> children;

}
