package com.albedo.java.vo.sys;

import com.albedo.java.vo.base.TreeEntityVo;
import lombok.Data;
import lombok.ToString;

/**
 * Copyright 2013 albedo All right reserved Author lijie Created on 2013-10-23
 * 下午1:55:43
 */
@Data
@ToString
public class DictVo extends TreeEntityVo {

    public static final String F_CODE = "code";
    private static final long serialVersionUID = 1L;
    /*** 编码 */
    private String code;
    /*** 字典值 */
    private String val;
    /*** 资源文件key */
    private String showName;
    /*** key */
    private String key;
    private Integer isShow = 1;
    private String parentCode;

}
