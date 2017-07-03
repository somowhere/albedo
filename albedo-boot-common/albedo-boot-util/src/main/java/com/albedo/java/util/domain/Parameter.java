package com.albedo.java.util.domain;

import java.util.HashMap;
import java.util.Map;

/**
 * 查询参数类 copyright 2014 albedo all right reserved author MrLi created on 2014年10月15日 下午2:59:16
 */
@SuppressWarnings("unchecked")
public class Parameter extends HashMap<String, Object> implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 构造类，例：new Parameter(id, parentIds)
     *
     * @param values 参数值
     */
    public Parameter(Object[] values) {
        if (values != null) {
            for (int i = 0; i < values.length; i++) {
                // if (PublicUtil.isNotEmpty(values[i])) {
                if (values[i] != null && values[i] instanceof Map) {
                    putAll((Map<? extends String, ? extends Object>) values[i]);
                } else if (values[i] != null && values[i].getClass().isArray()) {
                    putAll(new Parameter((Object[]) values[i]));
                } else {
                    put("p" + (i + 1), values[i]);
                }
                // }
            }
        }
    }

    /**
     * 构造类，例：new Parameter(new Object[][]{{"id", id}, {"parentIds", parentIds}})
     *
     * @param parameters 参数二维数组
     */
    public Parameter(Object[][] parameters) {
        if (parameters != null) {
            for (Object[] os : parameters) {
                if (os.length == 2) {
                    put((String) os[0], os[1]);
                }
            }
        }
    }

}
