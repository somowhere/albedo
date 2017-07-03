package com.albedo.java.util.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class ComboQuery implements Serializable {

    private static final long serialVersionUID = 1L;
    private String columns; // 下拉列表隐藏值
    private String tableName; // 下拉列表显示值
    private String condition; // 树形结构父节点


}
