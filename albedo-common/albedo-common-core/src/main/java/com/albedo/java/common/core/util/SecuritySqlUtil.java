package com.albedo.java.common.core.util;

import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;

/**
 * 数据Sql安全类
 *
 * @author somewhere version 2014-1-6 上午9:16:30
 */
@UtilityClass
@Slf4j
public class SecuritySqlUtil {

	/**
	 * 检查条件字符串是否合法
	 *
	 * @param where
	 * @return
	 */
	public static boolean checkStrForSqlWhere(String where) {
		if (where != null) {
			return !where.contains(" delete ") && !where.contains(" select ") && !where.contains(" update ")
				&& !where.contains(" insert ") && !where.contains(";");
		}
		return true;
	}

	/**
	 * 检查条件字符串是否合法
	 *
	 * @param where
	 * @return
	 */
	public static boolean checkStrForSqlWhereItem(String where) {
		if (where != null) {
			return !where.contains(" ") && !checkStrForSqlWhere(where);
		}
		return true;
	}

	/**
	 * 检查排序字符串是否合法
	 *
	 * @param orderBy
	 * @return
	 */
	public static boolean checkStrForSqlOrderBy(String orderBy) {
		if (orderBy != null) {
			return !orderBy.contains("order by") && !orderBy.contains(" and ") && !orderBy.contains(" or ")
				&& !orderBy.contains(" delete ") && !orderBy.contains(" select ") && !orderBy.contains(" update ")
				&& !orderBy.contains(" insert ") && !orderBy.contains(";");
		}
		return true;
	}

	/**
	 * 根据class 获取对应module名称
	 *
	 * @param cls
	 * @return
	 */
	public static String getModuleByClass(Class<?> cls) {
		String className = cls.getName();
		return className.substring(className.lastIndexOf(StringUtil.DOT) + 1);
	}

}
