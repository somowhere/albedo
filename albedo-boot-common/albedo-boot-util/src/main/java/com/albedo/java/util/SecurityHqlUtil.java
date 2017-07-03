package com.albedo.java.util;

/**
 * 数据Hql安全类
 *
 * @author lijie version 2014-1-6 上午9:16:30
 */
public class SecurityHqlUtil {

    /**
     * 检查条件字符串是否合法
     *
     * @param where
     * @return
     */
    public static boolean checkStrForHqlWhere(String where) {
        if (where != null) {
            if (where.contains(" delete ") || where.contains(" select ") || where.contains(" update ") || where.contains(" insert ") || where.contains(";")) {
                return false;
            }
        }
        return true;
    }

    /**
     * 检查排序字符串是否合法
     *
     * @param orderBy
     * @return
     */
    public static boolean checkStrForHqlOrderBy(String orderBy) {
        if (orderBy != null) {
            if (orderBy.contains("order by") || orderBy.contains(" and ") || orderBy.contains(" or ") || orderBy.contains(" delete ") || orderBy.contains(" select ") || orderBy.contains(" update ") || orderBy.contains(" insert ")
                    || orderBy.contains(";")) {
                return false;
            }
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
        return className.substring(className.lastIndexOf(".") + 1);
    }

}
