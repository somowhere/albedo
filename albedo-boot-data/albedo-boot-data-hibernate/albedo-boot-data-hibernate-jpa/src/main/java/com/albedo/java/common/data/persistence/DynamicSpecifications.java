package com.albedo.java.common.data.persistence;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.QueryCondition;
import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Lists;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class DynamicSpecifications {
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

    public static <T> SpecificationDetail<T> buildSpecification(String queryConditionJson, QueryCondition... conditions) {
        return buildSpecification(queryConditionJson, null, conditions);
    }

    public static <T> SpecificationDetail<T> buildSpecification(String queryConditionJson, List<QueryCondition> list, QueryCondition... conditions) {
        if (list == null) list = Lists.newArrayList();

        if (PublicUtil.isNotEmpty(queryConditionJson)) {
            try {
                list.addAll(JSONArray.parseArray(queryConditionJson, QueryCondition.class));
            } catch (Exception e) {
                logger.warn(PublicUtil.toAppendStr("queryCondition[", queryConditionJson,
                        "] is not json or other error", e.getMessage()));
            }
        }

        return new SpecificationDetail<T>().andAll(list).and(conditions);
    }

}