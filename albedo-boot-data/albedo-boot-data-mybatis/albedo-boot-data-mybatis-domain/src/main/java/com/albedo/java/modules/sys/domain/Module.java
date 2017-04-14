package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.SearchField;
import com.albedo.java.util.domain.RequestMethod;
import com.alibaba.fastjson.annotation.JSONField;
import com.google.common.collect.Sets;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Set;

/** Copyright 2013 albedo All right reserved Author lijie Created on 2013-10-23 下午4:29:21 */
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Module extends TreeEntity<Module> {

	private static final long serialVersionUID = 1L;
	public static final String F_ID = "id";
	/*** 菜单模块 MENUFLAG = 0 */
	public static final String TYPE_MENU = "1";
	/*** 权限模块 MODULEFLAG = 1 */
	public static final String TYPE_OPERATE = "2";
	public static final String F_PERMISSION = "permission";
	/*** 模块类型 0 菜单模块 1权限模块 */
	@SearchField @DictType(name = "sys_module_type")
	private String type;
	/*** 目标 */
	private String target;
	/*** 请求方法*/
	 @DictType(name="sys_request_method")
	private String requestMethod;
	/*** 链接地址 */
	private String url;
	/*** 图标class */
	private String iconCls;
	/*** 权限标识 */
	@SearchField
	private String permission;
	/*** 针对顶层菜单，0 普通展示下级菜单， 1以树形结构展示 */
	private String showType;

	@JSONField(serialize=false)
	private Set<Role> roles = Sets.newHashSet(); // 拥有角色列表

	/*** 父模块名称 */
	private String parentName;

	public Module(String id) {
		this.id = id;
	}

	public String getHref() {
		if(url!=null){
			int indexSplit = url.indexOf(StringUtil.SPLIT_DEFAULT);
			return indexSplit == -1 ? url : url.substring(0, indexSplit);
		}
		return url;
	}
	
	public String getHrefName() {
		String temp = getHref();
		return StringUtil.toCamelCase(temp, '/');
	}
	public void setRequestMethod(RequestMethod requestMethod) {
		this.requestMethod = requestMethod.name();
	}
}
