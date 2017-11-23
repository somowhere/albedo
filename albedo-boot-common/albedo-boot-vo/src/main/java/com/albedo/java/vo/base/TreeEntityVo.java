package com.albedo.java.vo.base;

import lombok.Data;

/**
 * 通常的数据基类 copyright 2014 albedo all right reserved author 李杰 created on 2014年12月31日 下午1:57:09
 */
@Data
public class TreeEntityVo extends DataEntityVo {
    public static final String F_NAME = "name";
    public static final String F_PARENTID = "parentId";
    public static final String F_PARENTIDS = "parentIds";
    public static final String F_ISLEAF = "isLeaf";
    public static final String F_SORT = "sort";
    public static final String F_PARENT = "parent";
    /*** 模块名称 */
    protected String name;
    /*** 上级模块 */
    protected String parentId;
    /*** 上级模块 */
    protected String parentIds;
    /*** 序号 */
    protected Integer sort = 0;
    /*** 父模块名称 */
    private String parentName;
    private boolean isLeaf;

}
