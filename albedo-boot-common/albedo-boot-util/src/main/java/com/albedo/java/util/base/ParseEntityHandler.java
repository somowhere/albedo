package com.albedo.java.util.base;

import com.albedo.java.util.PublicUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.beanutils.PropertyUtils;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ParseEntityHandler {

    private ParseEntityHandler ph = null;
    private Map<String, Field> tempMap = new HashMap<String, Field>();
    private List<String> freeFilterList = Lists.newArrayList("class", "pkName", "pk", "new", "version");
    private Map<String, String> symbolMap = Maps.newHashMap();
    private int recurrenceMaxCount = 3;
    private String allSymbol = "=";
    private String andOr = "and";

    private ParseEntityHandler() {
    }

    public ParseEntityHandler getInstance() {
        return getInstance(null);
    }

    public ParseEntityHandler getInstance(Map<String, String> symbolMap) {
        if (ph == null) {
            ph = new ParseEntityHandler();
        }
        if (PublicUtil.isNotEmpty(symbolMap))
            ph.symbolMap = symbolMap;
        return ph;
    }

    public ParseEntityHandler setRecurrenceMaxCount(int recurrenceMaxCount) {
        this.recurrenceMaxCount = recurrenceMaxCount;
        return this;
    }

    public ParseEntityHandler setAllSymbol(String allSymbol) {
        this.allSymbol = allSymbol;
        return this;
    }

    public ParseEntityHandler setAndOr(String andOr) {
        this.andOr = andOr;
        return this;
    }

    public ParseEntityHandler setSymbolMap(Map<String, String> symbolMap) {
        this.symbolMap = symbolMap;
        return this;
    }

    /**
     * 获取对象的公共属性
     *
     * @param fields
     * @param obj
     * @param params
     */
    private void checkObj(Object obj) {
        tempMap.clear();
        for (Field field : obj.getClass().getFields()) {
            tempMap.put(field.getName(), field);
        }
    }

    /**
     * 判断对象entity是否存在用户自定义对象
     *
     * @param entity
     * @param field
     * @return
     */
    private Boolean equals(Object entity, PropertyDescriptor p) {
        String className = entity.getClass().getName();
        return p.getPropertyType().getName().contains(className.substring(0, className.lastIndexOf(".")));
    }

    /**
     * invoke
     *
     * @param proxy  代理的实例
     * @param method 被拦截类所调用的方法
     * @param args   被拦截类所调用的方法的参数
     * @return
     * @throws Throwable
     */
    public String invoke(Object entity, Map<String, Object> params) {
        Object val = null;
        StringBuffer sb = new StringBuffer();
        List<String> args = Lists.newArrayList();
        Integer recurrenceCount = 0;
        if (entity != null) {
            List<Object> paramEntityList = Lists.newArrayList(entity);
            for (; PublicUtil.isNotEmpty(paramEntityList); ) {
                List<Object> tempList = Lists.newArrayList(paramEntityList);
                paramEntityList.clear();
                if (recurrenceMaxCount >= recurrenceCount || recurrenceMaxCount < 0) {
                    for (Object obj : tempList) {
                        checkObj(obj);
                        PropertyDescriptor[] ps = PropertyUtils.getPropertyDescriptors(obj);
                        for (PropertyDescriptor p : ps) {
                            if (freeFilterList.contains(p.getName()) || tempMap.containsKey(p.getName()))
                                continue;
                            try {
                                val = PropertyUtils.getProperty(obj, p.getName());
                            } catch (Exception e) {
                                continue;
                            }
                            String pName = p.getName();
                            if (PublicUtil.isNotEmpty(val)) {
                                if (equals(entity, p)) {
                                    args.add(pName);
                                    paramEntityList.add(val);
                                    args.remove(pName);
                                } else {
                                    for (String arg : args) {
                                        sb.append(arg).append(".");
                                    }
                                    String symbol = (symbolMap != null && symbolMap.containsKey(pName) ? symbolMap.get(pName) : allSymbol);
                                    sb.append(pName).append(" ").append(symbol).append(" :").append(pName).append(" ").append(andOr).append(" ");
                                    params.put(pName, symbol.equals("like") && !val.toString().startsWith("%") && !val.toString().endsWith("%") ? PublicUtil.toAppendStr("%", val, "%") : val);
                                }
                            }
                        }
                    }
                }
                recurrenceCount++;
            }
        }

        return sb.toString();
    }
}
