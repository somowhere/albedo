/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.data.persistence;

import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.SearchField;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.MappedSuperclass;

import java.io.Serializable;

/**
 * Entity支持类
 *
 * @author lj
 * @version 2014-05-16
 */
@MappedSuperclass
public abstract class BaseEntity<ID extends Serializable> extends GeneralEntity<ID> {

    private static final long serialVersionUID = 1L;
    @Column(name = "status_")
    @SearchField
    @DictType(name = "sys_status")
    @ApiModelProperty(hidden = true)
    protected Integer status;

    public BaseEntity() {
        super();
        this.status = FLAG_NORMAL;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

}
