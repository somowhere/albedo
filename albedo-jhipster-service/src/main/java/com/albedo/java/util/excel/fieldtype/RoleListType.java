//package com.albedo.util.excel.fieldtype;
//
//import java.util.List;
//
//import com.albedo.modules.sys.entity.Role;
//import com.albedo.modules.sys.service.RoleService;
//import com.albedo.util.StringUtil;
//import com.albedo.util.base.Collections3;
//import com.albedo.util.spring.SpringContextHolder;
//import com.google.common.collect.Lists;
//
///** 字段类型转换 copyright 2014 albedo all right reserved author 李杰 created on 2014年10月20日 下午2:35:55 */
//public class RoleListType {
//
//	private static RoleService roleService = SpringContextHolder.getBean(RoleService.class);
//
//	/** 获取对象值（导入） */
//	public static Object getValue(String val) {
//		List<Role> roleList = Lists.newArrayList();
//		List<Role> allRoleList = roleService.findAllList();
//		for (String s : StringUtil.split(val, ",")) {
//			for (Role e : allRoleList) {
//				if (e.getName().equals(s.replaceAll(" ", ""))) {
//					roleList.add(e);
//				}
//			}
//		}
//		return roleList.size() > 0 ? roleList : null;
//	}
//
//	/** 设置对象值（导出） */
//	public static String setValue(Object val) {
//		if (val != null) {
//			@SuppressWarnings("unchecked")
//			List<Role> roleList = (List<Role>) val;
//			return Collections3.extractToString(roleList, "name", ", ");
//		}
//		return "";
//	}
//
//}
