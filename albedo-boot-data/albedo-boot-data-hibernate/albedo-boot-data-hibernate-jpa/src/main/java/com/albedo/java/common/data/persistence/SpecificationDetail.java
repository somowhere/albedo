package com.albedo.java.common.data.persistence;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.QueryUtil;
import com.albedo.java.util.domain.Order;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.domain.QueryCondition.Operator;
import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.*;
import java.io.Serializable;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.List;

@SuppressWarnings("unchecked")
public class SpecificationDetail<T> implements Specification<T>, Serializable {
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    /**
     * 属性分隔符
     */
    private static final String PROPERTY_SEPARATOR = ".";
    protected static Logger logger = LoggerFactory.getLogger(SpecificationDetail.class);
    /**
     * and条件
     */
    private List<QueryCondition> andQueryConditions = Lists.newArrayList();
    /**
     * or条件
     */
    private List<QueryCondition> orQueryConditions = Lists.newArrayList();
    /**
     * 排序属性
     */
    private List<com.albedo.java.util.domain.Order> orders = Lists.newArrayList();

    /**
     * 获取Path
     *
     * @param root         Path
     * @param propertyName 属性路径
     * @return Path
     */
    public static <T> Path getPath(Root<T> root, String propertyName) {
        String[] names = StringUtils.split(propertyName, PROPERTY_SEPARATOR);
        Path expression = root.get(names[0]);
        for (int i = 1; i < names.length; i++) {
            expression = expression.get(names[i]);
        }
        return expression;
    }

    private List<javax.persistence.criteria.Order> toOrders(Root<T> root, CriteriaBuilder criteriaBuilder) {
        List<javax.persistence.criteria.Order> orderList = Lists.newArrayList();
        if (PublicUtil.isEmpty(orders)) {
            return orderList;
        }
        for (com.albedo.java.util.domain.Order order : orders) {
            if (order == null) {
                continue;
            }
            String property = order.getProperty();
            com.albedo.java.util.domain.Order.Direction direction = order.getDirection();
            Path<?> path = getPath(root, property);
            if (path == null || direction == null) {
                continue;
            }
            if (direction.equals(Order.Direction.asc)) {
                orderList.add(criteriaBuilder.asc(path));
            } else if (direction.equals(Order.Direction.asc)) {
                orderList.add(criteriaBuilder.desc(path));
            }
        }
        return orderList;
    }

    /**
     * 转换为Predicate
     *
     * @param root Root
     * @return Predicate
     */
    private Predicate toGetPredicate(List<QueryCondition> queryConditions, Root<T> root, CriteriaBuilder builder,
                                     Condition con) {
        if (PublicUtil.isNotEmpty(andQueryConditions)) {
            List<Predicate> predicates = Lists.newArrayList();
            java.util.Collections.sort(queryConditions);
            for (QueryCondition queryCondition : queryConditions) {
                // nested path translate, 如Task的名为"user.name"的filedName,
                // 转换为Task.user.name属性
                String[] names = StringUtils.split(queryCondition.getFieldName(), ".");
                Path expression = root.get(names[0]);
                for (int i = 1; i < names.length; i++) {
                    expression = expression.get(names[i]);
                }
                Operator op = queryCondition.getOperate();
                if (Operator.in.equals(op)) {
                    String tempValue = String.valueOf(queryCondition.getValue());
                    List<Object> list = Lists.newArrayList();
                    Lists.newArrayList(tempValue.split(",")).forEach(item -> {
                        list.add(QueryUtil.getQueryValue(queryCondition, item));
                    });
                    predicates.add(expression.in(list));
                } else {
                    Object val = QueryUtil.getQueryValue(queryCondition, null);
                    predicates.add(Operator.eq.equals(op) ?
                            builder.equal(expression, val) : Operator.ne.equals(op) ?
                            builder.notEqual(expression, val) : Operator.like.equals(op) ?
                            builder.like(expression, "%" + val + "%") : Operator.between.equals(op) ?
                            builder.between(expression, (Date) val, (Date) QueryUtil.getQueryValue(queryCondition, queryCondition.getEndValue())) : Operator.gt.equals(op) ?
                            builder.greaterThan(expression, (Comparable) val) : Operator.lt.equals(op) ?
                            builder.lessThan(expression, (Comparable) val) : Operator.ge.equals(op) ?
                            builder.greaterThanOrEqualTo(expression, (Comparable) val) : Operator.le.equals(op) ?
                            builder.lessThanOrEqualTo(expression, (Comparable) val) : Operator.isNull.equals(op) ?
                            expression.isNull() : Operator.isNotNull.equals(op) ? expression.isNotNull() : null);
                }
            }
            if (predicates.size() > 0) {
                Predicate[] items = predicates.toArray(new Predicate[predicates.size()]);
                return Condition.AND.equals(con) ? builder.and(items) : builder.or(items);
            }
        }
        return builder.conjunction();
    }

    @Override
    public Predicate toPredicate(Root<T> root, CriteriaQuery<?> query, CriteriaBuilder builder) {
        Predicate restrictions = builder.and(toGetPredicate(andQueryConditions, root, builder, Condition.AND));
        restrictions = builder.and(restrictions, toGetPredicate(orQueryConditions, root, builder, Condition.OR));
        query.orderBy(toOrders(root, builder));
        return restrictions;
    }

    /**
     * 添加一个and条件
     *
     * @param condition 该条件
     * @return 链式调用
     */
    public SpecificationDetail<T> and(QueryCondition condition) {
        this.andQueryConditions.add(condition);
        return this;
    }

    public SpecificationDetail<T> andAll(String queryConditionJson) {
        List<QueryCondition> list = null;
        if (PublicUtil.isNotEmpty(queryConditionJson)) {
            try {
                list = JSONArray.parseArray(queryConditionJson, QueryCondition.class);
            } catch (Exception e) {
                logger.warn(PublicUtil.toAppendStr("queryCondition[", queryConditionJson,
                        "] is not json or other error", e.getMessage()));
            }
        }
        if (list == null) {
            list = Lists.newArrayList();
        }
        this.andQueryConditions.addAll(list);
        return this;
    }

    /**
     * 添加多个and条件
     *
     * @param condition 该条件
     * @return 链式调用
     */
    public SpecificationDetail<T> and(QueryCondition... condition) {
        this.andQueryConditions.addAll(Arrays.asList(condition));
        return this;
    }

    public SpecificationDetail<T> andAll(Collection<QueryCondition> conditions) {
        this.andQueryConditions.addAll(conditions);
        return this;
    }

    /**
     * 添加一个or条件
     *
     * @param condition 该条件
     * @return 链式调用
     */
    public SpecificationDetail<T> or(QueryCondition condition) {
        this.orQueryConditions.add(condition);
        return this;
    }

    /**
     * 添加多个or条件
     *
     * @param condition 该条件
     * @return 链式调用
     */
    public SpecificationDetail<T> or(QueryCondition... condition) {
        this.orQueryConditions.addAll(Arrays.asList(condition));
        return this;
    }

    public SpecificationDetail<T> orAll(Collection<QueryCondition> conditions) {
        this.orQueryConditions.addAll(conditions);
        return this;
    }

    public SpecificationDetail<T> orAll(String queryConditionJson) {
        List<QueryCondition> list = null;
        if (PublicUtil.isNotEmpty(queryConditionJson)) {
            try {
                list = JSONArray.parseArray(queryConditionJson, QueryCondition.class);
            } catch (Exception e) {
                logger.warn(PublicUtil.toAppendStr("queryCondition[", queryConditionJson,
                        "] is not json or other error", e.getMessage()));
            }
        }
        if (list == null) {
            list = Lists.newArrayList();
        }
        this.orQueryConditions.addAll(list);
        return this;
    }

    /**
     * 升序字段
     *
     * @param property 该字段对应变量名
     * @return 链式调用
     */
    public SpecificationDetail<T> orderASC(String... property) {
        if (PublicUtil.isNotEmpty(property)) {
            for (int i = 0; i < property.length; i++) {
                this.orders.add(com.albedo.java.util.domain.Order.asc(property[i]));
            }
        }
        return this;
    }

    /**
     * 降序字段
     *
     * @param property 该字段对应变量名
     * @return 链式调用
     */
    public SpecificationDetail<T> orderDESC(String... property) {
        if (PublicUtil.isNotEmpty(property)) {
            for (int i = 0; i < property.length; i++) {
                this.orders.add(com.albedo.java.util.domain.Order.desc(property[i]));
            }
        }
        return this;
    }

    /**
     * 清除所有条件
     *
     * @return 该实例
     */
    public SpecificationDetail<T> clearAll() {
        if (!this.andQueryConditions.isEmpty()) {
            this.andQueryConditions.clear();
        }
        if (!this.orQueryConditions.isEmpty()) {
            this.orQueryConditions.clear();
        }
        if (!this.orders.isEmpty()) {
            this.orders.clear();
        }
        return this;
    }

    /**
     * 清除and条件
     *
     * @return 该实例
     */
    public SpecificationDetail<T> clearAnd() {
        if (!this.andQueryConditions.isEmpty())
            this.andQueryConditions.clear();
        return this;
    }

    /**
     * 清除or条件
     *
     * @return 该实例
     */
    public SpecificationDetail<T> clearOr() {
        if (!this.orQueryConditions.isEmpty())
            this.andQueryConditions.clear();
        return this;
    }

    /**
     * 清除order条件
     *
     * @return 该实例
     */
    public SpecificationDetail<T> clearOrder() {
        if (!this.orders.isEmpty())
            this.orders.clear();
        return this;
    }
    /**
     * 连接条件
     */
    public enum Condition {
        AND, OR
    }
}
