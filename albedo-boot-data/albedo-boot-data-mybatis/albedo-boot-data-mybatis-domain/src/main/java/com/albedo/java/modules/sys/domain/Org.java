package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.util.annotation.DictType;
import com.alibaba.fastjson.annotation.JSONField;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Set;

/** Copyright 2013 albedo All right reserved Author lijie Created on 2013-10-23 下午4:30:34 */
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Org extends TreeEntity<Org> {

	private static final long serialVersionUID = 1L;

	public static final String F_TYPE = "type";

	/*** 组织编码 */
	private String code;

	/*** 拼音简码 */
	private String en;
	/*** 机构类型（1：公司；2：部门；3：小组） */
	@DictType(name="sys_org_type")
	private String type;
	/*** 机构等级（1：一级；2：二级；3：三级；4：四级） */
	@DictType(name="sys_org_grade")
	private String grade;

	@JSONField(serialize=false)@ApiModelProperty(hidden=true)
	private Set<User> users;


	public Org(String id, String parentIds) {
		this.setId(id);
		this.parentIds = parentIds;
	}

	public Org(String id) {
		this.setId(id);
	}

}
