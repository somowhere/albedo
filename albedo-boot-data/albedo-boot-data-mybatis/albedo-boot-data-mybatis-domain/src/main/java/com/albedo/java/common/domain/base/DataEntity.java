package com.albedo.java.common.domain.base;

import com.albedo.java.common.data.mybatis.persistence.BaseEntity;
import com.albedo.java.common.data.mybatis.persistence.IdGen;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.util.PublicUtil;
import com.alibaba.fastjson.annotation.JSONField;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.data.annotation.*;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.JoinColumn;
import org.springframework.data.mybatis.annotations.ManyToOne;
import org.springframework.data.mybatis.annotations.MappedSuperclass;

import javax.xml.bind.annotation.XmlTransient;
import java.util.Date;

/**
 * Base abstract class for entities which will hold definitions for created, last modified by and created,
 * last modified by date.
 */
@MappedSuperclass
@Data
public abstract class DataEntity extends BaseEntity {

    private static final long serialVersionUID = 1L;

//
//    @JSONField(serialize = false)@ApiModelProperty(hidden=true)
//    @Column(name = "created_by")
//    protected String createdBy;

    @ManyToOne @CreatedBy
    @JoinColumn(name = "created_by")
    protected User creator;

    @CreatedDate
    @Column(name = "created_date")
    protected Date createdDate = PublicUtil.getCurrentDate();


//    @Column(name = "last_modified_by")
//    protected String lastModifiedBy;

    @ManyToOne @LastModifiedBy
    @JoinColumn(name = "last_modified_by")
    protected User modifier;
    
    @LastModifiedDate
    @Column(name = "last_modified_date")
    protected Date lastModifiedDate = PublicUtil.getCurrentDate();

    /*** 默认0，必填，离线乐观锁 */
	@Version
	@JSONField(serialize = false)
	@XmlTransient@ApiModelProperty(hidden=true)
    @Column(name = "version_")
	protected Integer version = 0;

	/*** 备注 */
	@XmlTransient
    @Column(name = "description_")
	protected String description;
    /**
     * 插入之前执行方法，需要手动调用
     */
    @Override
    public void preInsert(){
        this.lastModifiedDate = new Date();
        this.createdDate = this.lastModifiedDate;
    }

    /**
     * 更新之前执行方法，需要手动调用
     */
    @Override
    public void preUpdate(){
        this.lastModifiedDate = new Date();
    }

}
