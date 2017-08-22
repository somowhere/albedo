package com.albedo.java.util.domain;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.SecurityHqlUtil;
import com.albedo.java.util.base.Encodes;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.spring.SpringContextHolder;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.Entity;
import org.springframework.data.mybatis.repository.dialect.Dialect;
import org.springframework.util.StringUtils;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;

@Slf4j
@Data
public class QueryCondition implements Comparable<QueryCondition>, java.io.Serializable {

    /*** 节点 */
    public static final String F_FILEDNODE = "fieldNode";
    /*** 实体属性 注意区分大小写 */
    public static final String F_FILEDNAME = "fieldName";
    /*** 操作符 */
    public static final String F_OPERATE = "operate";
    /*** 值 */
    public static final String F_ATTRTYPE = "attrType";
    public static final String F_FORMAT = "format";
    public static final String F_VALUE = "value";
    public static final String F_ENDVALUE = "endValue";
    /*** 查询权重 */
    public static final String F_WEIGHT = "weight";
    private static final long serialVersionUID = 1L;
    private Class<?> persistentClass;
    /**
     * 节点
     */
    private String fieldNode;
    /**
     * 实体属性 注意区分大小写
     */
    private String fieldName;
    /**
     * 操作符
     */
    private Operator operate;
    /**
     * 值类型
     */
    private String attrType;
    /**
     * 值格式
     */
    private String format;
    /**
     * 值
     */
    private Object value;
    /**
     * 第二个值 operate= between
     */
    private Object endValue;
    /**
     * @Fields ingore : 是否忽略
     */
    private boolean ingore = false;
    /**
     * 查询权重
     */
    private Integer weight = Integer.valueOf(0x186a0);

    /**
     * 是否解析动态条件查询前缀（一般自定义sql查询时建议设置为false,动态则设置为true）
     */
    @JSONField(serialize = false)
    private boolean analytiColumn = true;

    /**
     * 解析动态条件查询前缀
     */
    @JSONField(serialize = false)
    private String analytiColumnPrefix;
    @JSONField(serialize = false)
    private String fieldRealColumnName;

    public QueryCondition() {
    }

    public QueryCondition(String fieldNode, String fieldName, Operator operate, Object value) {
        this.fieldNode = fieldNode;
        this.fieldName = fieldName;
        this.operate = operate;
        this.value = value;
    }

    public QueryCondition(String fieldName, Operator operate, Object value, Class<?> persistentClass) {
        this.fieldName = fieldName;
        this.operate = operate;
        this.value = value;
        this.persistentClass = persistentClass;
    }

    public QueryCondition(String fieldName, Operator operate, Object value) {
        this.fieldName = fieldName;
        this.operate = operate;
        this.value = value;
    }

    /**
     * 返回等于筛选
     *
     * @param property 属性
     * @param value    值
     * @return 等于筛选
     */
    public static QueryCondition eq(String property, Object value) {
        return new QueryCondition(property, QueryCondition.Operator.eq, value);
    }

    /**
     * 返回不等于筛选
     *
     * @param property 属性
     * @param value    值
     * @return 不等于筛选
     */
    public static QueryCondition ne(String property, Object value) {
        return new QueryCondition(property, QueryCondition.Operator.ne, value);
    }

    /**
     * 返回大于筛选
     *
     * @param property 属性
     * @param value    值
     * @return 大于筛选
     */
    public static QueryCondition gt(String property, Object value) {
        return new QueryCondition(property, QueryCondition.Operator.gt, value);
    }

    /**
     * 返回小于筛选
     *
     * @param property 属性
     * @param value    值
     * @return 小于筛选
     */
    public static QueryCondition lt(String property, Object value) {
        return new QueryCondition(property, QueryCondition.Operator.lt, value);
    }

    /**
     * 返回大于等于筛选
     *
     * @param property 属性
     * @param value    值
     * @return 大于等于筛选
     */
    public static QueryCondition ge(String property, Object value) {
        return new QueryCondition(property, QueryCondition.Operator.ge, value);
    }

    /**
     * 返回小于等于筛选
     *
     * @param property 属性
     * @param value    值
     * @return 小于等于筛选
     */
    public static QueryCondition le(String property, Object value) {
        return new QueryCondition(property, QueryCondition.Operator.le, value);
    }

    /**
     * 返回相似筛选
     *
     * @param property 属性
     * @param value    值
     * @return 相似筛选
     */
    public static QueryCondition like(String property, Object value) {
        return new QueryCondition(property, QueryCondition.Operator.like, value);
    }

    /**
     * 返回包含筛选
     *
     * @param property 属性
     * @param value    值
     * @return 包含筛选
     */
    public static QueryCondition in(String property, Object value) {
        return new QueryCondition(property, QueryCondition.Operator.in, value);
    }

    /**
     * 返回为Null筛选
     *
     * @param property 属性
     * @return 为Null筛选
     */
    public static QueryCondition isNull(String property) {
        return new QueryCondition(property, QueryCondition.Operator.isNull, null);
    }

    /**
     * 返回不为Null筛选
     *
     * @param property 属性
     * @return 不为Null筛选
     */
    public static QueryCondition isNotNull(String property) {
        return new QueryCondition(property, QueryCondition.Operator.isNotNull, null);
    }

    public QueryCondition setAnalytiColumn(boolean flag) {
        this.analytiColumn = flag;
        return this;
    }

    public QueryCondition setAnalytiColumnPrefix(String analytiPrefix) {
        this.analytiColumnPrefix = analytiPrefix;
        return this;
    }

    public String getFieldNode() {
        return fieldNode;
    }

    public void setFieldNode(String fieldNode) {
        this.fieldNode = fieldNode;
    }

    public String getFieldName() {
        if (PublicUtil.isNotEmpty(fieldName) && fieldName.contains("this.")) {
            fieldName = fieldName.replace("this.", "");
        }
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    @JSONField(serialize = false)
    public String getFieldRealColumnName() {
        if (fieldRealColumnName == null) {
            String columnName = null, fieldPropery = fieldName;
            Class<?> targetPersistentClass = persistentClass;
            if (analytiColumn) {
                try {
                    if (persistentClass != null && PublicUtil.isNotEmpty(getFieldName())) {
                        String quota = analytiColumnPrefix;
                        int indexQuote = fieldPropery.indexOf(".");
                        if (PublicUtil.isEmpty(quota)) {
                            Entity entity = Reflections.getAnnotation(targetPersistentClass, Entity.class);
                            quota = null != entity && StringUtils.hasText(entity.name()) ? entity.name() :
                                    StringUtils.uncapitalize(targetPersistentClass.getSimpleName());
                            if (indexQuote != -1) {
                                quota += "." + fieldPropery.substring(0, fieldPropery.lastIndexOf("."));
                            }
                        }
                        if (indexQuote != -1) {
                            String[] properties = fieldPropery.split("\\.");
                            int size = properties.length;
                            for (int i = 0; i < size - 1; i++) {
                                Field field = Reflections.getAccessibleField(targetPersistentClass, properties[i]);
                                targetPersistentClass = field.getType();
                            }
                            fieldPropery = properties[size - 1];
                        }
                        Column column = Reflections.getAnnotationByClazz(targetPersistentClass, fieldPropery, Column.class);
                        if (column != null) columnName = column.name();

                        if (PublicUtil.isNotEmpty(columnName)) {
                            Dialect dialect = SpringContextHolder.getBean(Dialect.class);
                            fieldRealColumnName = dialect.openQuote() + quota + dialect.closeQuote() + '.' + columnName;
                        }
                    }
                } catch (Exception e) {
                    log.warn(e.getMessage());
                }
            }

        }
        return fieldRealColumnName;
    }

    public Operator getOperate() {
        return operate;
    }

    public void setOperate(Operator operate) {
        this.operate = operate;
    }

    public void setOperate(String operate) {
        this.operate = Operator.valueOf(operate);
    }

    public String getAttrType() {
        return attrType;
    }

    public void setAttrType(String attrType) {
        this.attrType = attrType;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        //字符串编码处理
        if (value instanceof String) {
            String tempStr = value.toString();
            if (tempStr.contains("&")) {
                try {
                    value = new String(Encodes.unescapeHtml(tempStr).getBytes("ISO-8859-1"), "UTF-8");
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                    log.warn("Illegal query conditions ---------> queryFieldName[",
                            fieldName, "]  operation[", operate.getOperator(),
                            "] value[", value, "], please check!!!");
                }
            }
        }
        this.value = value;
    }

    @JSONField(serialize = false)
    public boolean legalityCheck() {
        return SecurityHqlUtil.checkStrForHqlWhere(fieldName)
                && SecurityHqlUtil.checkStrForHqlWhere(operate.getOperator())
                && SecurityHqlUtil.checkStrForHqlWhere(String.valueOf(value));
    }


    public Object getEndValue() {
        return endValue;
    }

    public void setEndValue(Object endValue) {
        this.endValue = endValue;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public boolean isIngore() {
        return ingore;
    }

    public void setIngore(boolean ingore) {
        this.ingore = ingore;
    }

    public int compareTo(QueryCondition arg) {
        int weight = valueOfQueryType(operate) - valueOfQueryType(arg.getOperate());
        return weight != 0 ? weight : this.weight.intValue() - arg.weight.intValue();
    }

    private int valueOfQueryType(Operator op) {
        if (Operator.eq.equals(op))
            return 0;
        if (Operator.ne.equals(op))
            return 1;
        if (Operator.between.equals(op))
            return 2;
        if (Operator.in.equals(op))
            return 3;
        if (Operator.ge.equals(op) || Operator.gt.equals(op))
            return 4;
        if (Operator.le.equals(op) || Operator.lt.equals(op))
            return 5;
        if (Operator.like.equals(op))
            return 6;
        return !"query".equals(op) ? 999 : 100;
    }

    /**
     * 运算符
     */
    public enum Operator {

        /**
         * 等于
         */
        eq("="),

        /**
         * 不等于
         */
        ne("!="),

        /**
         * 大于
         */
        gt(">"),

        /**
         * 小于
         */
        lt("<"),

        /**
         * 大于等于
         */
        ge(">="),

        /**
         * 小于等于
         */
        le("<="),

        /**
         * 类似
         */
        like("like"),
        /**
         * 类似
         */
        between("between"),

        /**
         * 包含
         */
        in("in"),

        /**
         * 包含
         */
        notIn("not in"),

        /**
         * 为Null
         */
        isNull("is Null"),

        /**
         * 不为Null
         */
        isNotNull("is Not Null");

        private String operator;

        Operator(String operator) {
            this.operator = operator;
        }

        public String getOperator() {
            return operator;
        }

        public void setOperator(String operator) {
            this.operator = operator;
        }
    }

}
