package com.albedo.java.common.domain.base;

import com.albedo.java.common.data.mybatis.persistence.BaseEntity;
import com.albedo.java.common.data.mybatis.persistence.IdGen;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.util.PublicUtil;
import com.alibaba.fastjson.annotation.JSONField;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.data.annotation.*;

import javax.xml.bind.annotation.XmlTransient;
import java.util.Date;

/**
 * Base abstract class for entities which will hold definitions for created, last modified by and created,
 * last modified by date.
 */
public abstract class DataEntity extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @CreatedBy
    @JSONField(serialize = false)@ApiModelProperty(hidden=true)
    protected String createdBy;
    
    protected User creator;

    @CreatedDate
    protected Date createdDate = PublicUtil.getCurrentDate();

    @LastModifiedBy
    protected String lastModifiedBy;

    protected User modifier;
    
    @LastModifiedDate
    protected Date lastModifiedDate = PublicUtil.getCurrentDate();

    /*** 默认0，必填，离线乐观锁 */
	@Version
	@JSONField(serialize = false)
	@XmlTransient@ApiModelProperty(hidden=true)
	protected Integer version = 0;

	/*** 备注 */
	@XmlTransient
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
    
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getLastModifiedBy() {
        return lastModifiedBy;
    }

    public void setLastModifiedBy(String lastModifiedBy) {
        this.lastModifiedBy = lastModifiedBy;
    }

    public Date getLastModifiedDate() {
        return lastModifiedDate;
    }

    public void setLastModifiedDate(Date lastModifiedDate) {
        this.lastModifiedDate = lastModifiedDate;
    }

	public User getModifier() {
		return modifier;
	}

	public void setModifier(User modifier) {
		this.modifier = modifier;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public User getCreator() {
		return creator;
	}

	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
