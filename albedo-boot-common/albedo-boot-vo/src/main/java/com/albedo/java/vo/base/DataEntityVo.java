package com.albedo.java.vo.base;

import lombok.Data;

/**
 * 通常的数据基类 copyright 2014 albedo all right reserved author 李杰 created on 2014年12月31日 下午1:57:09
 */
@Data
public class DataEntityVo extends GeneralEntityVo {

    private String id;
    private Integer status = GeneralEntityVo.FLAG_NORMAL;
    private String description;

}
