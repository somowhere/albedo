package com.albedo.java.vo.sys.query;

import lombok.Data;

/**
 * Created by lijie on 2017/3/2.
 */
@Data
public class AreaTreeQuery {

    private String all;
    private String parentId;
    private String extId;
    private Integer ltLevel;
    private Integer level;

}
