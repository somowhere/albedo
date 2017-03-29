package com.albedo.java.vo.base;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by lijie on 2017/3/29.
 */
@Data
public class GeneralVo implements Serializable {
    protected Integer status;
    protected Date createdDate;
    protected Date lastModifiedDate;
}
