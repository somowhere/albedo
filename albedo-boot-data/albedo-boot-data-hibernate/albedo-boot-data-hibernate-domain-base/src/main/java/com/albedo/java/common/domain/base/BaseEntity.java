package com.albedo.java.common.domain.base;

import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.SearchField;
import io.swagger.annotations.ApiModelProperty;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.xml.bind.annotation.XmlTransient;

/**
 * 框架基础实体类（对应表中必须含status_字段）
 *
 * @author lijie version 2013-12-27 下午12:27:10
 */
@MappedSuperclass
public abstract class BaseEntity extends GeneralEntity {

    /**
     * 状态（-2：删除；-1：停用 0：正常 1:审核）
     */
    public static final String F_STATUS = "status";
    private static final long serialVersionUID = 1L;
    /*** 状态（-2：删除；-1：停用 0：正常 1:审核） */
    @Column(name = "status_")
    @XmlTransient
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
