package com.albedo.java.common.core.vo;

import com.albedo.java.common.core.annotation.BeanField;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 通常的数据基类 copyright 2014 albedo all right reserved author somewhere created on 2014年12月31日 下午1:57:09
 */
@Data
public class TreeEntityVo extends DataEntityVo<String> {
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
	/*** 上级模块 */
	@BeanField
	protected String parentIds;
	/*** 序号 */
	protected Integer sort;
	/*** 父模块名称 */
	@BeanField
	private String parentName;
	@BeanField
	private boolean leaf;

}
