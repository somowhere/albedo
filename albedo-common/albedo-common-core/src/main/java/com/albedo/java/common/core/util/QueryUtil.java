package com.albedo.java.common.core.util;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.convert.Convert;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.EscapeUtil;
import com.albedo.java.common.core.annotation.SearchField;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.vo.QueryCondition;
import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;

import java.beans.PropertyDescriptor;
import java.nio.charset.StandardCharsets;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;


@UtilityClass
@Slf4j
public class QueryUtil {


	/**
	 * json 转换 查询集合
	 *
	 * @param queryConditionJson 格式
	 *                           [{"fieldName":"loginIdStringUtil.SPLIT_DEFAULToperation":"likeStringUtil.SPLIT_DEFAULTweight":0,"value":"ss"}]
	 * @return
	 */
	public static List<QueryCondition> convertJsonToQueryCondition(String queryConditionJson) {
		List<QueryCondition> list = null;
		if (StringUtil.isNotEmpty(queryConditionJson)) {
			try {
				list = JSONArray.parseArray(queryConditionJson, QueryCondition.class);
			} catch (Exception e) {
				log.warn(StringUtil.toAppendStr("queryCondition[", queryConditionJson,
					"] is not json or other error", e.getMessage()));
			}
		}
		if (list == null) {
			list = Lists.newArrayList();
		}

		return list;
	}

	/**
	 * 将查询json字符串转换为hql查询条件语句
	 *
	 * @param queryConditionJson 格式
	 *                           [{"fieldName":"loginIdStringUtil.SPLIT_DEFAULToperation":"likeStringUtil.SPLIT_DEFAULTweight":0,"value":"ss"}]
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
	 * @return
	 */
	public static String convertQueryConditionToStr(List<QueryCondition> andQueryConditionList, List<QueryCondition> orQueryConditionList, List<String> argList,
													Map<String, Object> paramMap) {

		return StringUtil.toAppendStr(convertQueryConditionToStr(andQueryConditionList, argList, paramMap, true),
			convertQueryConditionToStr(orQueryConditionList, argList, paramMap, false));
	}


	public static String convertQueryConditionToStr(List<QueryCondition> queryConditionList, List<String> argList,
													Map<String, Object> paramMap) {
		return convertQueryConditionToStr(queryConditionList, argList, paramMap, true);
	}

	/**
	 * 查询集合 转换 查询条件
	 *
	 * @param queryConditionList
	 * @param paramMap           返回的参数map
	 * @return
	 */
	public static String convertQueryConditionToStr(List<QueryCondition> queryConditionList, List<String> argList,
													Map<String, Object> paramMap, boolean isAnd) {
		StringBuffer sb = new StringBuffer();
		if (CollUtil.isNotEmpty(queryConditionList)) {
			if (paramMap == null) {
				paramMap = Maps.newHashMap();
			}
			java.util.Collections.sort(queryConditionList);
			//前缀解析
			String argStr = CollUtil.isNotEmpty(argList) ? CollUtil.convertToString(argList, ".") + "." : "", operate = null;
			for (QueryCondition queryCondition : queryConditionList) {
				if (queryCondition.isIngore()) {
					continue;
				}
				operate = queryCondition.getOperate().getOperator();
				if (queryCondition.getValue() instanceof String) { //字符串编码处理
					String tempStr = queryCondition.getValue().toString();
					if (tempStr.contains("&")) {
						queryCondition.setValue(
							new String(EscapeUtil.unescapeHtml4(tempStr).getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8));
					}
				}
				//sql合法性检查
				if (queryCondition != null && queryCondition.legalityCheck()) {
					if (StringUtil.isEmpty(operate)) {
						queryCondition.setOperate(QueryCondition.Operator.eq.getOperator());
					}
					sb.append(" ").append(isAnd ? CommonConstants.CONDITION_AND : CommonConstants.CONDITION_OR)
						.append(CommonConstants.SPACE).append(argStr + queryCondition.getFieldName()).append(" ")
						.append(operate);
					if (!QueryCondition.Operator.isNotNull.equals(queryCondition.getOperate())
						&& !QueryCondition.Operator.isNull.equals(queryCondition.getOperate())) {
						String paramFieldName = StringUtil.toAppendStr(argStr, queryCondition.getFieldName())
							.replace(".", "_");
						if (paramFieldName.contains(StringUtil.SPLIT_DEFAULT)) {
							paramFieldName = StringUtil.getRandomString(6);
						}
						switch (operate) {
							case CommonConstants.CONDITION_IN:
							case CommonConstants.CONDITION_NOTIN:
								if (queryCondition.getValue() instanceof String) {
									String val = String.valueOf(queryCondition.getValue());
									queryCondition.setValue(val.contains(StringUtil.SPLIT_DEFAULT) ? Lists.newArrayList(val.split(StringUtil.SPLIT_DEFAULT))
										: Lists.newArrayList(val));
								}
								if (queryCondition.getValue() instanceof Collection) {
									Collection col = (Collection) queryCondition.getValue();
									if (CollUtil.isNotEmpty(col)) {
										sb.append(" (");
										Integer i = 0;
										for (Iterator iterator = col.iterator(); iterator.hasNext(); i++) {
											buildConditionCaluse(sb, StringUtil.toAppendStr(paramFieldName, i));
											sb.append(", ");
											paramMap.put(StringUtil.toAppendStr(paramFieldName, i),
												getQueryValue(queryCondition, iterator.next()));
										}
										sb.delete(sb.lastIndexOf(StringUtil.SPLIT_DEFAULT), sb.length()).append(")");
									}
								} else {
									log.warn(StringUtil.toAppendStr("queryFieldName[", paramFieldName,
										"] operation is '", operate, "', but value[",
										queryCondition.getValue(), "] is not Collection, please check!!!"));
								}
								break;
							case CommonConstants.CONDITION_LIKE:
							case CommonConstants.CONDITION_ILIKE:
								String val = (String) queryCondition.getValue();
								buildConditionCaluse(sb, paramFieldName);
								paramMap.put(paramFieldName, !val.startsWith("%") && !val.endsWith("%")
									? StringUtil.toAppendStr("%", val, "%") : val);
								break;
							case CommonConstants.CONDITION_BETWEEN:
								buildConditionCaluse(sb, StringUtil.toAppendStr(paramFieldName, "1"));
								sb.append(" and ");
								buildConditionCaluse(sb, StringUtil.toAppendStr(paramFieldName, "2"));
								paramMap.put(paramFieldName + "1", getQueryValue(queryCondition, null));
								paramMap.put(paramFieldName + "2",
									getQueryValue(queryCondition, queryCondition.getEndValue()));
								break;
							default:
								buildConditionCaluse(sb, paramFieldName);
								paramMap.put(paramFieldName, getQueryValue(queryCondition, null));
								break;
						}
					}
				} else {
					log.warn(StringUtil.toAppendStr("Illegal query conditions ---------> queryFieldName[",
						queryCondition.getFieldName(), "]  operation[", operate, "] value[",
						queryCondition.getValue(), "], please check!!!"));
				}
			}
		}
		if (StringUtil.isNotEmpty(sb.toString())) {
			if (!isAnd) {
				sb.delete(0, 4).insert(0, " and (").append(")");
			}
		}
		return sb.toString();
	}

	public static void buildConditionCaluse(StringBuffer sb, Object val) {
//        if (mybatis)
//            sb.append("#{").append(val).append("}");
//        else
		sb.append(":").append(val);
	}

	public static Object getQueryValue(QueryCondition queryCondition, Object val) {
		String type = queryCondition.getAttrType();
		if (val == null) {
			val = queryCondition.getValue();
		}
		if (StringUtil.isNotEmpty(type) && ObjectUtil.isNotNull(val)) {
			if (CommonConstants.TYPE_INTEGER.equalsIgnoreCase(type) || CommonConstants.TYPE_INT.equalsIgnoreCase(type)) {
				val = Convert.toInt(val, 0);
			} else if (CommonConstants.TYPE_LONG.equalsIgnoreCase(type)) {
				val = Convert.toLong(val, 0L);
			} else if (CommonConstants.TYPE_SHORT.equalsIgnoreCase(type)) {
				val = Short.parseShort(String.valueOf(val));
			} else if (CommonConstants.TYPE_FLOAT.equalsIgnoreCase(type)) {
				val = Float.parseFloat(String.valueOf(val));
			} else if (CommonConstants.TYPE_DOUBLE.equalsIgnoreCase(type)) {
				val = Double.parseDouble(String.valueOf(val));
			} else if (CommonConstants.TYPE_DATE.equalsIgnoreCase(type)) {
				val = StringUtil.isNotEmpty(queryCondition.getFormat()) ?
					DateUtil.parse(String.valueOf(val), queryCondition.getFormat()).toJdkDate()
					: DateUtil.parse(String.valueOf(val)).toJdkDate();
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
			if (StringUtil.isNotEmpty(where)) {
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
	public static List<QueryCondition> convertObjectToQueryCondition(Object entity, Map<String, QueryCondition.Operator> operateMap) {
		List<QueryCondition> list = Lists.newArrayList();
		if (ObjectUtil.isNotNull(entity)) {
			Object val;
			String key;
			SearchField an;
			List<String> argList = Lists.newArrayList();
			List<Object> paramEntityList = Lists.newArrayList();
			paramEntityList.add(Lists.newArrayList(entity, argList));
			Object obj;
			String targetClassName = entity.getClass().getName(), baseClassName = StringUtil.sub(targetClassName, 0, StringUtil.getFromIndex(targetClassName, "\\.", 3));
			while (CollUtil.isNotEmpty(paramEntityList)) {
				List<Object> tempList = Lists.newArrayList(paramEntityList);
				paramEntityList.clear();
				// proxy.getClass().getMethod("clearCount").invoke(proxy);
				// //情况参数位置 hibernate4之后去掉参数索引
				for (Object objItem : tempList) {
					if (objItem instanceof Collection) {
						List<Object> objItemList = (List<Object>) objItem;
						if (CollUtil.isEmpty(objItemList)) {
							continue;
						} else {
							obj = objItemList.get(0);
							argList = (List<String>) objItemList.get(1);
						}
					} else {
						obj = objItem;
					}
					PropertyDescriptor[] ps = BeanVoUtil.getPropertyDescriptors(obj.getClass());
					for (PropertyDescriptor p : ps) {
						key = p.getName();
						try {
							val = BeanUtil.getFieldValue(obj, key);
							an = ClassUtil.findAnnotation(obj.getClass(), key, SearchField.class);
						} catch (Exception e) {
							log.info("T:{} exception:{} ", key, e.getMessage());
							continue;
						}
						if (ObjectUtil.isNotEmpty(val) && an != null) {
							if (val.getClass().getName().contains(baseClassName)) {
								argList.add(key);
								paramEntityList.add(Lists.newArrayList(val, Lists.newArrayList(argList)));
								argList.remove(key);
							} else {
								if (CollUtil.isNotEmpty(argList)) {
									key = StringUtil.toAppendStr(
										CollUtil.convertToString(argList, "."), ".", key);
								}
								list.add(new QueryCondition(key,
									CollUtil.isNotEmpty(operateMap) &&
										operateMap.get(key) != null
										? operateMap.get(key) : an.op(),
									val));
							}
						}
					}
				}
			}

		}
		return list;
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
		return sb.toString().split(StringUtil.SPLIT_DEFAULT);
	}

}
