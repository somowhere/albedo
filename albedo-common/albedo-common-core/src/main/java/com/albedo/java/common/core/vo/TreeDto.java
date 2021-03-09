package com.albedo.java.common.core.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;

/**
 * 通常的数据基类 copyright 2014 albedo all right reserved author somewhere created on 2014年12月31日 下午1:57:09
 *
 * @author somewhere
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class TreeDto extends DataDto<String> {
	public static final String F_NAME = "name";
	public static final String F_PARENT_ID = "parentId";
	public static final String F_PARENT_IDS = "parentIds";
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

}
