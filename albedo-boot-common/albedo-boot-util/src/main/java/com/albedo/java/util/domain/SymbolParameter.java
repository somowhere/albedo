package com.albedo.java.util.domain;

import java.util.HashMap;

/**
 * 属性操作符类 copyright 2014 albedo all right reserved author MrLi created on 2014年10月15日 下午2:59:16
 */
public class SymbolParameter extends HashMap<String, String> implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 构造类，例：new Parameter(new Object[][]{{"id", id}, {"parentIds", parentIds}})
     *
     * @param parameters 参数二维数组
     */
    public SymbolParameter(String[][] parameters) {
        if (parameters != null) {
            for (String[] os : parameters) {
                if (os.length == 2) {
                    put(os[0], os[1]);
                }
            }
        }
    }

}
