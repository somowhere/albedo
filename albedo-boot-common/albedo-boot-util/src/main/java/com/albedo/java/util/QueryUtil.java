package com.albedo.java.util;

import com.albedo.java.util.annotation.SearchField;
import com.albedo.java.util.base.Collections3;
import com.albedo.java.util.base.Encodes;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.config.SystemConfig;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.domain.QueryCondition.Operator;
import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.beanutils.PropertyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.beans.PropertyDescriptor;
import java.io.UnsupportedEncodingException;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public class QueryUtil {

    protected static Logger logger = LoggerFactory.getLogger(QueryUtil.class);

    /**
     * json 转换 查询集合
     *
     * @param queryConditionJson 格式
     *                           [{"fieldName":"loginId","operation":"like","weight":0,"value":"ss"}]
     * @return
     */
    public static List<QueryCondition> convertJsonToQueryCondition(String queryConditionJson) {
        List<QueryCondition> list = null;
        if (PublicUtil.isNotEmpty(queryConditionJson)) {
            try {
                list = JSONArray.parseArray(queryConditionJson, QueryCondition.class);
            } catch (Exception e) {
                logger.warn(PublicUtil.toAppendStr("queryCondition[", queryConditionJson,
                        "] is not json or other error", e.getMessage()));
            }
        }
        if (list == null)
            list = Lists.newArrayList();

        return list;
    }

    /**
     * 将查询json字符串转换为hql查询条件语句
     *
     * @param queryConditionJson 格式
     *                           [{"fieldName":"loginId","operation":"like","weight":0,"value":"ss"}]
     * @param paramMap           参数map
     * @return
     */
    public static String convertJsonQueryConditionToStr(String queryConditionJson, List<String> argList,
                                                        Map<String, Object> paramMap) {
        List<QueryCondition> queryConditionList = convertJsonToQueryCondition(queryConditionJson);
        return convertQueryConditionToStr(queryConditionList, argList, paramMap);
    }

    /**
     * 将查询对象动态拼接为sql条件
     *
     * @param andQueryConditionList 并且查询条件
     * @param orQueryConditionList  或者查询条件
     * @param argList               前缀
     * @param paramMap              参数map
     * @param isMybatis             是否为mybaits
     * @return
     */
    public static String convertQueryConditionToStr(List<QueryCondition> andQueryConditionList, List<QueryCondition> orQueryConditionList, List<String> argList,
                                                    Map<String, Object> paramMap, boolean isMybatis) {

        return PublicUtil.toAppendStr(convertQueryConditionToStr(andQueryConditionList, argList, paramMap, isMybatis, true),
                convertQueryConditionToStr(orQueryConditionList, argList, paramMap, isMybatis, false));
    }


    public static String convertQueryConditionToStr(List<QueryCondition> queryConditionList, List<String> argList,
                                                    Map<String, Object> paramMap) {
        return convertQueryConditionToStr(queryConditionList, argList, paramMap, false, true);
    }

    /**
     * 查询集合 转换 查询条件
     *
     * @param queryConditionList
     * @param paramMap           返回的参数map
     * @return
     */
    public static String convertQueryConditionToStr(List<QueryCondition> queryConditionList, List<String> argList,
                                                    Map<String, Object> paramMap, boolean mybatis, boolean isAnd) {
        StringBuffer sb = new StringBuffer();
        if (PublicUtil.isNotEmpty(queryConditionList)) {
            if (paramMap == null)
                paramMap = Maps.newHashMap();
            java.util.Collections.sort(queryConditionList);
            //前缀解析
            String argStr = PublicUtil.isNotEmpty(argList) ? Collections3.convertToString(argList, ".") + "." : "", operate = null;
            for (QueryCondition queryCondition : queryConditionList) {
                if (queryCondition.isIngore())
                    continue;
                operate = queryCondition.getOperate().getOperator();
                if (queryCondition.getValue() instanceof String) { //字符串编码处理
                    String tempStr = queryCondition.getValue().toString();
                    if (tempStr.contains("&")) {
                        try {
                            queryCondition.setValue(
                                    new String(Encodes.unescapeHtml(tempStr).getBytes("ISO-8859-1"), "UTF-8"));
                        } catch (UnsupportedEncodingException e) {
                            e.printStackTrace();
                            logger.warn("Illegal query conditions ---------> queryFieldName[",
                                    queryCondition.getFieldName(), "]  operation[", operate,
                                    "] value[", queryCondition.getValue(), "], please check!!!");
                        }
                    }
                }
                //sql合法性检查
                if (queryCondition != null && queryCondition.legalityCheck()) {
                    if (PublicUtil.isEmpty(operate))
                        queryCondition.setOperate(Operator.eq.getOperator());
                    sb.append(" ").append(isAnd ? SystemConfig.CONDITION_AND : SystemConfig.CONDITION_OR)
                            .append(SystemConfig.SPACE).append(queryCondition.isAnalytiColumn() && PublicUtil.isNotEmpty(queryCondition.getFieldRealColumnName()) ? queryCondition.getFieldRealColumnName()
                            : argStr + queryCondition.getFieldName()).append(" ")
                            .append(operate);
                    if (!Operator.isNotNull.equals(queryCondition.getOperate())
                            && !Operator.isNull.equals(queryCondition.getOperate())) {
                        String paramFieldName = PublicUtil.toAppendStr(argStr, queryCondition.getFieldName())
                                .replace(".", "_");
                        if (paramFieldName.contains(","))
                            paramFieldName = PublicUtil.getRandomString(6);
                        switch (operate) {
                            case SystemConfig.CONDITION_IN:
                            case SystemConfig.CONDITION_NOTIN:
                                if (queryCondition.getValue() instanceof String) {
                                    String val = String.valueOf(queryCondition.getValue());
                                    queryCondition.setValue(val.contains(",") ? Lists.newArrayList(val.split(","))
                                            : Lists.newArrayList(val));
                                }
                                if (queryCondition.getValue() instanceof Collection) {
                                    Collection col = (Collection) queryCondition.getValue();
                                    if (PublicUtil.isNotEmpty(col)) {
                                        sb.append(" (");
                                        Integer i = 0;
                                        for (Iterator iterator = col.iterator(); iterator.hasNext(); i++) {
                                            buildConditionCaluse(sb, PublicUtil.toAppendStr(paramFieldName, i), mybatis);
                                            sb.append(", ");
                                            paramMap.put(PublicUtil.toAppendStr(paramFieldName, i),
                                                    getQueryValue(queryCondition, iterator.next()));
                                        }
                                        sb.delete(sb.lastIndexOf(","), sb.length()).append(")");
                                    }
                                } else {
                                    logger.warn(PublicUtil.toAppendStr("queryFieldName[", paramFieldName,
                                            "] operation is '", operate, "', but value[",
                                            queryCondition.getValue(), "] is not Collection, please check!!!"));
                                }
                                break;
                            case SystemConfig.CONDITION_LIKE:
                            case SystemConfig.CONDITION_ILIKE:
                                String val = (String) queryCondition.getValue();
                                buildConditionCaluse(sb, paramFieldName, mybatis);
                                paramMap.put(paramFieldName, !val.startsWith("%") && !val.toString().endsWith("%")
                                        ? PublicUtil.toAppendStr("%", val, "%") : val);
                                break;
                            case SystemConfig.CONDITION_BETWEEN:
                                buildConditionCaluse(sb, PublicUtil.toAppendStr(paramFieldName, "1"), mybatis);
                                sb.append(" and ");
                                buildConditionCaluse(sb, PublicUtil.toAppendStr(paramFieldName, "2"), mybatis);
                                paramMap.put(paramFieldName + "1", getQueryValue(queryCondition, null));
                                paramMap.put(paramFieldName + "2",
                                        getQueryValue(queryCondition, queryCondition.getEndValue()));
                                break;
                            default:
                                buildConditionCaluse(sb, paramFieldName, mybatis);
                                paramMap.put(paramFieldName, getQueryValue(queryCondition, null));
                                break;
                        }
                    }
                } else {
                    logger.warn(PublicUtil.toAppendStr("Illegal query conditions ---------> queryFieldName[",
                            queryCondition.getFieldName(), "]  operation[", operate, "] value[",
                            queryCondition.getValue(), "], please check!!!"));
                }
            }
        }
        if (PublicUtil.isNotEmpty(sb.toString())) {
            if (!isAnd) {
                sb.delete(0, 4).insert(0, " and (").append(")");
            }
        }
        return sb.toString();
    }

    public static void buildConditionCaluse(StringBuffer sb, Object val, boolean mybatis) {
        if (mybatis)
            sb.append("#{").append(val).append("}");
        else
            sb.append(":").append(val);
    }

    public static Object getQueryValue(QueryCondition queryCondition, Object val) {
        String type = queryCondition.getAttrType();
        if (val == null)
            val = queryCondition.getValue();
        if (PublicUtil.isNotEmpty(type) && PublicUtil.isNotEmpty(val)) {
            if (SystemConfig.TYPE_INTEGER.equalsIgnoreCase(type) || SystemConfig.TYPE_INT.equalsIgnoreCase(type)) {
                val = PublicUtil.parseInt(val, 0);
            } else if (SystemConfig.TYPE_LONG.equalsIgnoreCase(type)) {
                val = PublicUtil.parseLong(val, 0L);
            } else if (SystemConfig.TYPE_SHORT.equalsIgnoreCase(type)) {
                val = Short.parseShort(String.valueOf(val));
            } else if (SystemConfig.TYPE_FLOAT.equalsIgnoreCase(type)) {
                val = Float.parseFloat(String.valueOf(val));
            } else if (SystemConfig.TYPE_DOUBLE.equalsIgnoreCase(type)) {
                val = Double.parseDouble(String.valueOf(val));
            } else if (SystemConfig.TYPE_DATE.equalsIgnoreCase(type)) {
                val = PublicUtil.parseDate(String.valueOf(val), queryCondition.getFormat());
            }
        }
        return val;
    }

    /**
     * 将查询集合拼接到查询语句后
     *
     * @param hql
     * @param queryConditionList
     * @param paramMap
     * @return
     */
    public static String convertJsonToQueryCondition(String hql, List<QueryCondition> queryConditionList,
                                                     List<String> argList, Map<String, Object> paramMap) {
        StringBuffer sb = new StringBuffer(hql);
        if (paramMap != null) {
            String where = convertQueryConditionToStr(queryConditionList, argList, paramMap);
            if (PublicUtil.isNotEmpty(where)) {
                String upper = hql.toUpperCase();
                int lastIndexWhere = upper.lastIndexOf(" WHERE "), lastIndexOrder = upper.lastIndexOf(" ORDER ");
                if (lastIndexWhere == -1) {
                    sb.append(" WHERE ");
                    where = where.trim();
                    if (where.startsWith(" and") || where.startsWith(" AND") || where.startsWith("and")
                            || where.startsWith("AND")) {
                        where = where.substring(4);
                    }
                    sb.append(where);
                } else {
                    if (lastIndexOrder > lastIndexWhere) {
                        sb.insert(lastIndexOrder, where);
                    } else {
                        if (where.startsWith(" and") || where.startsWith(" AND") || where.startsWith("and") || where.startsWith("AND")) {
                            where = where.substring(4);
                        }
                        sb.insert(lastIndexWhere + 6, where + " and ");
                    }
                }
            }
        }
        return sb.toString();
    }

    /**
     * 将对象不为空的属性转换为List<QueryCondition> 仅解析基本类型
     *
     * @param entity
     * @param operateMap
     * @return
     */
    public static List<QueryCondition> convertObjectToQueryCondition(Object entity, Map<String, Operator> operateMap, Class<?> persistentClass) {
        List<QueryCondition> list = Lists.newArrayList();
        if (PublicUtil.isNotEmpty(entity)) {
            Object val = null;
            String key = null;
            SearchField an = null;
            List<String> argList = Lists.newArrayList();
            List<Object> paramEntityList = Lists.newArrayList();
            paramEntityList.add(Lists.newArrayList(entity, argList));
            Object obj = null;
            while (PublicUtil.isNotEmpty(paramEntityList)) {
                List<Object> tempList = Lists.newArrayList(paramEntityList);
                paramEntityList.clear();
                // proxy.getClass().getMethod("clearCount").invoke(proxy);
                // //情况参数位置 hibernate4之后去掉参数索引
                for (Object objItem : tempList) {
                    if (objItem instanceof Collection) {
                        List<Object> objItemList = (List<Object>) objItem;
                        if (PublicUtil.isEmpty(objItemList)) {
                            continue;
                        } else {
                            obj = objItemList.get(0);
                            argList = (List<String>) objItemList.get(1);
                        }
                    } else {
                        obj = objItem;
                    }
                    PropertyDescriptor[] ps = PropertyUtils.getPropertyDescriptors(obj);
                    for (PropertyDescriptor p : ps) {
                        key = p.getName();
                        try {
                            val = PropertyUtils.getProperty(obj, key);
                            an = Reflections.getAnnotation(obj, key, SearchField.class);
                        } catch (Exception e) {
                            logger.info("key:{} exception:{} ", key, e.getMessage());
                            continue;
                        }
                        if (PublicUtil.isNotEmpty(val) && an != null) {
                            if (Reflections.checkClassIsBase(val.getClass().getName())) {
                                argList.add(key);
                                paramEntityList.add(Lists.newArrayList(val, Lists.newArrayList(argList)));
                                argList.remove(key);
                            } else {
                                if (PublicUtil.isNotEmpty(argList))
                                    key = PublicUtil.toAppendStr(Collections3.convertToString(argList, "."), ".", key);
                                list.add(new QueryCondition(key,
                                        PublicUtil.isNotEmpty(operateMap) && PublicUtil.isNotEmpty(operateMap.get(key))
                                                ? operateMap.get(key) : an.op(),
                                        val, persistentClass));
                            }
                        }
                    }
                }
            }

        }
        return list;
    }

    /**
     * 将对象不为空的属性转换为List<QueryCondition> 仅解析基本类型
     *
     * @param entity
     * @param operateMap
     * @return
     */
    public static List<QueryCondition> convertObjectToQueryCondition(Object entity, Map<String, Operator> operateMap) {
        return convertObjectToQueryCondition(entity, operateMap, null);
    }

    /**
     * 在sql中寻找与最外层select对应的from的index 调用前请先转成大写。
     *
     * @param tempSql
     * @return
     */
    public static int findOuterFromIndex(String tempSql) {
        int selectNum = 0, fromIndex = -1;
        for (int i = 0; i < tempSql.length() - 7; ) { // 挨着寻找
            char ch = tempSql.charAt(i);
            if ('S' != ch && 'F' != ch) {
                i++;
                continue;
            }
            String select = tempSql.substring(i, i + 7); // 防止selects
            String from = tempSql.substring(i, i + 5); // 防止froms干扰
            if ("SELECT ".equals(select)) { // 找到select关键词
                selectNum++;
                i = i + 7;
                continue;
            } else if ("FROM ".equals(from)) { // 找到from关键词
                selectNum--;
                if (selectNum == 0) { // 已经找到相应from
                    fromIndex = i;
                    break;
                }
                i = i + 5;
            }
            i++;
        }
        if (selectNum > 0 || fromIndex < 8) {
            throw new RuntimeException("sql语句中select与from不对应，请检查sql语句：" + tempSql);
        }
        return fromIndex;
    }

    /**
     * 在sql中寻找与最外层select对应的GroupBy的index 调用前请先转成大写。
     *
     * @param tempSql
     * @return
     */
    public static int findOuterGroupByIndex(String tempSql) {
        int selectNum = 0, groupByIndex = -1;
        for (int i = 0; i < tempSql.length() - 9; ) { // 挨着寻找
            char ch = tempSql.charAt(i);
            if ('S' != ch && 'G' != ch) {
                i++;
                continue;
            }
            String select = tempSql.substring(i, i + 7); // 防止selects
            String groupBy = tempSql.substring(i, i + 9);
            if ("SELECT ".equals(select)) { // 找到select关键词
                selectNum++;
                i = i + 7;
                continue;
            } else if ("GROUP BY ".equals(groupBy)) { // 找到groupBy关键词
                selectNum--;
                if (selectNum == 0) { // 已经找到相应groupBy
                    groupByIndex = i;
                    break;
                }
                i = i + 9;
            }
            i++;
        }
        return groupByIndex;
    }

    /**
     * 用队列思想实现分离别名 1 更加columnStr定义两个char数组。 2 遍历值数组，得到每个列名和逗号。 3 在将得到的列名串转成列名数组。
     *
     * @param colunmStr
     * @return
     */
    public static String[] getColumnNames3(String colunmStr) {
        char[] array = colunmStr.toCharArray();
        StringBuffer sb = new StringBuffer();
        StringBuffer tempSb = new StringBuffer();
        int bracketCount = 0;
        for (int i = 0; i < array.length; i++) {
            if (array[i] == '(') {
                bracketCount++;
                continue;
            }
            if (array[i] == ')') {
                bracketCount--;
                continue;
            }
            if (bracketCount == 0) {
                if (array[i] != ' ' && array[i] != ',') {
                    tempSb.append(array[i]);
                } else if (array[i] == ' '
                        && (i < array.length - 1 && !(array[i + 1] == ' ') && !(array[i + 1] == ','))) {
                    tempSb.delete(0, tempSb.length());
                } else if (array[i] == ',') {
                    tempSb.append(array[i]);
                    sb.append(tempSb.toString());
                    tempSb.delete(0, tempSb.length());
                }
            }
        }
        sb.append(tempSb.toString());
        return sb.toString().split(",");
    }

}
