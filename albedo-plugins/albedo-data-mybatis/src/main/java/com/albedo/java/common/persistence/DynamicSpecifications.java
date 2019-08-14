package com.albedo.java.common.persistence;

import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.QueryCondition;
import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Lists;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class DynamicSpecifications {
	public static final String MYBITS_SEARCH_PARAMS_MAP = "paramsMap";
	public static final String MYBITS_SEARCH_DSF = "_sqlConditionDsf";
	public static final String MYBITS_SEARCH_CONDITION = "_condition";
	protected static Logger logger = LoggerFactory.getLogger(DynamicSpecifications.class);

	public static <T> SpecificationDetail<T> bySearchQueryCondition(final List<QueryCondition> queryConditions) {
		return new SpecificationDetail<T>().andAll(queryConditions);
	}

	public static <T> SpecificationDetail<T> bySearchQueryCondition(final List<QueryCondition> queryConditions, QueryCondition... conditions) {
		return new SpecificationDetail<T>().andAll(queryConditions).and(conditions);
	}

	public static <T> SpecificationDetail<T> bySearchQueryCondition(QueryCondition... conditions) {
		return new SpecificationDetail<T>().and(conditions);
	}

	public static <T> SpecificationDetail<T> bySearchQueryCondition(Class<T> persistentClass, List<QueryCondition> queryConditions) {
		return new SpecificationDetail<T>().setPersistentClass(persistentClass).andAll(queryConditions);
	}

	public static <T> SpecificationDetail<T> bySearchQueryCondition(Class<T> persistentClass, QueryCondition... conditions) {
		return new SpecificationDetail<T>().setPersistentClass(persistentClass).and(conditions);
	}

	public static <T> SpecificationDetail<T> buildSpecification(String queryConditionJson, QueryCondition... conditions) {
		return buildSpecification(null, queryConditionJson, null, conditions);
	}

	public static <T> SpecificationDetail<T> buildSpecification(Class<T> persistentClass, String queryConditionJson, QueryCondition... conditions) {
		return buildSpecification(persistentClass, queryConditionJson, null, conditions);
	}

	public static <T> SpecificationDetail<T> buildSpecification(Class<T> persistentClass, String queryConditionJson,
																List<QueryCondition> list,
																QueryCondition... conditions) {
		if (list == null) list = Lists.newArrayList();

		if (StringUtil.isNotEmpty(queryConditionJson)) {
			try {
				list.addAll(JSONArray.parseArray(queryConditionJson, QueryCondition.class));
			} catch (Exception e) {
				logger.warn(StringUtil.toAppendStr("queryCondition[", queryConditionJson,
					"] is not json or other error", e.getMessage()));
			}
		}

		return new SpecificationDetail<T>().andAll(list).and(conditions).setPersistentClass(persistentClass);
	}

}
