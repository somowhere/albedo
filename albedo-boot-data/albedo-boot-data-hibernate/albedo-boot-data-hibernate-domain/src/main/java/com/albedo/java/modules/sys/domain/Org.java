package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.util.annotation.DictType;
import com.alibaba.fastjson.annotation.JSONField;
import io.swagger.annotations.ApiModelProperty;
import lombok.ToString;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.*;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import java.util.Set;

/**
 * Copyright 2013 albedo All right reserved Author lijie Created on 2013-10-23 下午4:30:34
 * @author somewhere
 */
@Entity
@Table(name = "sys_org_t")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@ToString
public class Org extends TreeEntity<Org> {

    public static final String F_TYPE = "type";
    private static final long serialVersionUID = 1L;
    /*** 组织编码 */
    @Column(name = "code_")
    private String code;

    /*** 拼音简码 */
    @Column(name = "en_")
    private String en;
    /*** 机构类型（1：公司；2：部门；3：小组） */
    @Column(name = "type_")
    @DictType(name = "sys_org_type")
    private String type;
    /*** 机构等级（1：一级；2：二级；3：三级；4：四级） */
    @Column(name = "grade_")
    @DictType(name = "sys_org_grade")
    private String grade;

    @OneToMany(mappedBy = "org", fetch = FetchType.EAGER)
    @Where(clause = "status_=0")
    @OrderBy(value = "created_date")
    @Fetch(FetchMode.SUBSELECT)
    @NotFound(action = NotFoundAction.IGNORE)
    @Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
    @JSONField(serialize = false)
    @ApiModelProperty(hidden = true)
    private Set<User> users;

    public Org() {
    }

    public Org(String id, String parentIds) {
        this.setId(id);
        this.parentIds = parentIds;
    }

    public Org(String id) {
        this.setId(id);
    }


    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }


    public String getEn() {
        return en;
    }

    public void setEn(String en) {
        this.en = en;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }

}
