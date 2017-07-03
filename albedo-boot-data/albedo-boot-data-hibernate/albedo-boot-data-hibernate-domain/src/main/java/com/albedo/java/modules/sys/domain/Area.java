/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.SearchField;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.validator.constraints.Length;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 * 区域管理Entity 区域管理
 *
 * @author admin
 * @version 2017-01-01
 */
@Entity
@Table(name = "sys_area_t")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Area extends TreeEntity<Area> {

    /**
     * F_SHORTNAME short_name  :  区域简称
     */
    public static final String F_SHORTNAME = "shortName";
    /**
     * F_LEVEL level_  :  区域等级
     */
    public static final String F_LEVEL = "level";
    /**
     * F_CODE code_  :  区域编码
     */
    public static final String F_CODE = "code";
    private static final long serialVersionUID = 1L;

    //columns START
    /**
     * shortName 区域简称
     */
    @Length(max = 32)
    @Column(name = "short_name", unique = false, nullable = true, length = 32)
    private String shortName;
    /**
     * level 区域等级
     */
    @Column(name = "level_", unique = false, nullable = true)
    @DictType(name = "sys_area_type")
    private Integer level;
    /**
     * code 区域编码
     */
    @Length(max = 32)
    @Column(name = "code_", unique = true, nullable = true, length = 32)
    @SearchField
    @NotNull
    private String code;

    //columns END
    public Area() {
    }

    public Area(String id) {
        this.id = id;
    }


    /**
     * shortName 区域简称
     */
    public String getShortName() {
        return this.shortName;
    }

    /**
     * shortName 区域简称
     */
    public void setShortName(String value) {
        this.shortName = value;
    }

    /**
     * level 区域等级
     */
    public Integer getLevel() {
        return this.level;
    }

    /**
     * level 区域等级
     */
    public void setLevel(Integer value) {
        this.level = value;
    }

    /**
     * code 区域编码
     */
    public String getCode() {
        return this.code;
    }

    /**
     * code 区域编码
     */
    public void setCode(String value) {
        this.code = value;
    }

    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("parentIds", getParentIds())
                .append("parentId", getParentId())
                .append("name", getName())
                .append("shortName", getShortName())
                .append("sort", getSort())
                .append("level", getLevel())
                .append("code", getCode())
                .append("description", getDescription())
                .append("isLeaf", getIsLeaf())
                .append("status", getStatus())
                .append("version", getVersion())
                .append("createdBy", getCreatedBy())
                .append("createdDate", getCreatedDate())
                .append("lastModifiedBy", getLastModifiedBy())
                .append("lastModifiedDate", getLastModifiedDate())
                .toString();
    }

    public int hashCode() {
        return new HashCodeBuilder()
                .append(getId())
                .toHashCode();
    }

    public boolean equals(Object obj) {
        if (obj instanceof Area == false) return false;
        if (this == obj) return true;
        Area other = (Area) obj;
        return new EqualsBuilder()
                .append(getId(), other.getId())
                .isEquals();
    }
}
