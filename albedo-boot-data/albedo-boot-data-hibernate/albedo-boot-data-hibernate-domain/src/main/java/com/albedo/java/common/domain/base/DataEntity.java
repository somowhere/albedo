package com.albedo.java.common.domain.base;

import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.annotation.JsonField;
import com.alibaba.fastjson.annotation.JSONField;
import io.swagger.annotations.ApiModelProperty;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.envers.Audited;
import org.hibernate.validator.constraints.Length;
import org.springframework.data.annotation.*;
import org.springframework.data.annotation.Version;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlTransient;
import java.util.Date;

/**
 * Base abstract class for entities which will hold definitions for created, last modified by and created,
 * last modified by date.
 */
@MappedSuperclass
@Audited
@EntityListeners(AuditingEntityListener.class)
public abstract class DataEntity extends BaseEntity {

    private static final long serialVersionUID = 1L;


    @CreatedBy
    @Column(name = "created_by", nullable = false, length = 50, updatable = false)
    @JSONField(serialize = false)
    @ApiModelProperty(hidden = true)
    protected String createdBy;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by", updatable = false, insertable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    @JSONField(serialize = false)
    @JsonField
    @ApiModelProperty(hidden = true)
    protected User creator;

    @CreatedDate
    @Column(name = "created_date", nullable = false)
    @ApiModelProperty(hidden = true)
    protected Date createdDate = PublicUtil.getCurrentDate();

    @LastModifiedBy
    @Column(name = "last_modified_by", length = 50)
    @ApiModelProperty(hidden = true)
    protected String lastModifiedBy;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "last_modified_by", updatable = false, insertable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    @JSONField(serialize = false)
    @JsonField
    @ApiModelProperty(hidden = true)
    protected User modifier;

    @LastModifiedDate
    @Column(name = "last_modified_date")
    @ApiModelProperty(hidden = true)
    protected Date lastModifiedDate = PublicUtil.getCurrentDate();

    /*** 默认0，必填，离线乐观锁 */
    @Version
    @Column(name = "version_")
    @JSONField(serialize = false)
    @XmlTransient
    @ApiModelProperty(hidden = true)
    protected Integer version = 0;

    /*** 备注 */
    @Length(min = 0, max = 255)
    @Column(name = "description_")
    @XmlTransient
    protected String description;


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

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
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
