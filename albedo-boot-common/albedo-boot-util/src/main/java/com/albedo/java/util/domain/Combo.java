package com.albedo.java.util.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class Combo implements Serializable {

    private static final long serialVersionUID = 1L;
    private String id; // 下拉列表隐藏值
    private String name; // 下拉列表显示值
    private String parentId; // 树形结构父节点
    private String url; // 数据源地址
    private String target; // 目标
    private String where; // 数据源地址Hql 拼接条件
    private String module; // 实体名称
    private String ckecked; // 是否显示复选框
    private String extId; // 排除掉的编号（不能选择的编号）
    private String selectIds; // 默认选择值

}
