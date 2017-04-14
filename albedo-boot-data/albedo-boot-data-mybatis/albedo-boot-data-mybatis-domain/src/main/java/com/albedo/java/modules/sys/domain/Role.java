package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.SearchField;
import com.albedo.java.util.base.Collections3;
import com.alibaba.fastjson.annotation.JSONField;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;
import java.util.Set;

/**
 * Copyright 2013 albedo All right reserved Author lijie Created on 2013-10-23 下午4:32:52
 */
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Role extends IdEntity {

	private static final long serialVersionUID = 1L;
	// 数据范围（1：所有数据；2：所在机构及以下数据；3：所在机构数据；4：仅本人数据；5：按明细设置）
	/*** 数据范围(所有数据) */
	public static final Integer DATA_SCOPE_ALL = 1;
	/*** 数据范围(所在机构及以下数据) */
	public static final Integer DATA_SCOPE_ORG_AND_CHILD = 2;
	/*** 数据范围(所在机构数据) */
	public static final Integer DATA_SCOPE_ORG = 3;
	/*** 数据范围(仅本人数据) */
	public static final Integer DATA_SCOPE_SELF = 4;
	/*** 数据范围(按明细设置) */
	public static final Integer DATA_SCOPE_CUSTOM = 5;
	
	public static final String F_SORT = "sort";
	public static final String F_NAME = "name";
	public static final String F_SYSDATA = "sysData";

	/*** 角色名称 */
	@SearchField
	private String name;
	/*** 名称全拼 */
	@SearchField
	private String en;
	/*** 工作流组用户组类型（security-role：管理员、assignment：可进行任务分配、user：普通用户） */
	private String type;
	/*** 组织ID */
	private String orgId;
	
    private Org org;
	
	/*** 是否系统数据  0 是 1否*/
	@DictType(name="sys_yes_no")
	private Integer sysData;
	/*** 可查看的数据范围 */
	private Integer dataScope;
	private Integer sort;
	/*** 组织机构 */
	private Set<Org> orgs = Sets.newHashSet();
	/*** 操作权限 */
	private Set<Module> modules = Sets.newHashSet();

	/*** 拥有用户列表 */
	private Set<User> users = Sets.newHashSet();

	@JSONField(serialize=false)
	private List<String> moduleIdList;
	@JSONField(serialize=false)
	private List<String> orgIdList;

	public Role(String id) {
		this.setId(id);
	}

	public Role(String id, Set<Module> modules) {
		this.setId(id);
		this.modules = modules;
	}

	public Role(String id, String name) {
		this.setId(id);
		this.name = name;
	}

	public List<String> getOrgIdList() {
		if (PublicUtil.isEmpty(orgIdList) && PublicUtil.isNotEmpty(orgs)) {
			orgIdList = Lists.newArrayList();
			orgs.forEach(o -> {if(PublicUtil.isNotEmpty(o))orgIdList.add(o.getId());});
		}
		return orgIdList;
	}

	public void setOrgIdList(List<String> orgIdList) {
		this.orgIdList = orgIdList;
		if (PublicUtil.isNotEmpty(orgIdList)) {
			orgs = Sets.newHashSet();
			orgIdList.forEach(o -> {if(PublicUtil.isNotEmpty(o))orgs.add(new Org(o));});
		}
	}
	public String getOrgIds() {
		return Collections3.convertToString(getOrgIdList(), ",");
	}
	
	public List<String> getModuleIdList() {
		if (PublicUtil.isEmpty(moduleIdList) && PublicUtil.isNotEmpty(modules)) {
			moduleIdList = Lists.newArrayList();
			modules.forEach(m -> {if(PublicUtil.isNotEmpty(m))moduleIdList.add(m.getId());});
		}
		return moduleIdList;
	}
	public String getModuleIds() {
		return Collections3.convertToString(getModuleIdList(), ",");
	}
	public void setModuleIdList(List<String> moduleIdList) {
		this.moduleIdList = moduleIdList;
		if (PublicUtil.isNotEmpty(moduleIdList)) {
			modules = Sets.newHashSet();
			moduleIdList.forEach(m -> {if(PublicUtil.isNotEmpty(m))modules.add(new Module(m));});
		}
	}



}
