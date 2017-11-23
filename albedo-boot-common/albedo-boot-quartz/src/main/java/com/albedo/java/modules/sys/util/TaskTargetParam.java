package com.albedo.java.modules.sys.util;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.config.SystemConfig;
import com.alibaba.fastjson.annotation.JSONField;

/**
 * Created by ftp on 2017/1/24.
 */
public class TaskTargetParam {
    private String attrType = SystemConfig.TYPE_STRING;
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
                if (SystemConfig.TYPE_STRING.equalsIgnoreCase(type)) {
                    val = PublicUtil.toStrString(value);
                } else if (SystemConfig.TYPE_INTEGER.equalsIgnoreCase(type) || SystemConfig.TYPE_INT.equalsIgnoreCase(type)) {
                    val = PublicUtil.parseInt(value, 0);
                } else if (SystemConfig.TYPE_LONG.equalsIgnoreCase(type)) {
                    val = PublicUtil.parseLong(value, 0L);
                } else if (SystemConfig.TYPE_SHORT.equalsIgnoreCase(type)) {
                    val = Short.parseShort(String.valueOf(value));
                } else if (SystemConfig.TYPE_FLOAT.equalsIgnoreCase(type)) {
                    val = Float.parseFloat(String.valueOf(value));
                } else if (SystemConfig.TYPE_DOUBLE.equalsIgnoreCase(type)) {
                    val = Double.parseDouble(String.valueOf(value));
                } else if (SystemConfig.TYPE_DATE.equalsIgnoreCase(value)) {
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
