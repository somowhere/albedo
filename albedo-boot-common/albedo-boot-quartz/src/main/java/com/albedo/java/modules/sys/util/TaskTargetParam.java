package com.albedo.java.modules.sys.util;

import com.albedo.java.util.PublicUtil;
import com.alibaba.fastjson.annotation.JSONField;

/**
 * Created by ftp on 2017/1/24.
 */
public class TaskTargetParam {
    private String attrType = "String";
    private String format;
    private String value;

    public TaskTargetParam() {
    }

    public TaskTargetParam(String value) {
        this.value = value;
    }

    public TaskTargetParam(String attrType, String value) {
        this.attrType = attrType;
        this.value = value;
    }

    public TaskTargetParam(String attrType, String format, String value) {

        this.attrType = attrType;
        this.format = format;
        this.value = value;
    }

    public String getAttrType() {
        return attrType;
    }

    public void setAttrType(String attrType) {

        this.attrType = attrType;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @JSONField(serialize = false)
    public Object getRelValue() {
        String type = attrType;
        Object val = null;
        if (value != null)
            if (PublicUtil.isNotEmpty(type) && PublicUtil.isNotEmpty(value)) {
                if ("String".equalsIgnoreCase(type)) {
                    val = PublicUtil.toStrString(value);
                } else if ("Integer".equalsIgnoreCase(type) || "int".equalsIgnoreCase(type)) {
                    val = PublicUtil.parseInt(value, 0);
                } else if ("Long".equalsIgnoreCase(type)) {
                    val = PublicUtil.parseLong(value, 0l);
                } else if ("Short".equalsIgnoreCase(type)) {
                    val = Short.parseShort(String.valueOf(value));
                } else if ("Float".equalsIgnoreCase(type)) {
                    val = Float.parseFloat(String.valueOf(value));
                } else if ("Double".equalsIgnoreCase(type)) {
                    val = Double.parseDouble(String.valueOf(value));
                } else if ("Date".equalsIgnoreCase(value)) {
                    val = PublicUtil.parseDate(String.valueOf(value), format);
                }
            }
        return val;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }
}
