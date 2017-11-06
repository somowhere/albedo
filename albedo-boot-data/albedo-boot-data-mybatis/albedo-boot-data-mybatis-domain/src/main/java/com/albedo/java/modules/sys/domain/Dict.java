package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.SearchField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.Entity;

import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlAttribute;

/**
 * Copyright 2013 albedo All right reserved Author lijie Created on 2013-10-23
 * 下午1:55:43
 */
@Entity(table = "sys_dict_t")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class Dict extends TreeEntity<Dict> {

    /**
     * 叶子节点
     */
    public static final String FLAG_LEAF = "0";
    /**
     * 非叶子节点
     */
    public static final String FLAG_UNLEAF = "1";
    public static final String F_CODE = "code";
    public static final String F_VAL = "val";
    private static final long serialVersionUID = 1L;
    /*** 编码 */
    @SearchField
    @Column(name = "code_")
    private String code;
    /*** 字典值 */
    @Column(name = "val_")
    private String val;
    /*** 资源文件key */
    @Column(name = "show_name")
    private String showName;
    /*** key */
    @Column(name = "key_")
    private String key;
    @NotNull
    @Column(name = "is_show")
    @DictType(name = "sys_yes_no")
    private Integer isShow = 1;
    @Transient
    private String parentCode;

    public Dict(String id) {
        this.id = id;
    }

    public String getShowName() {
        return showName;
    }

    public void setShowName(String showName) {
        this.showName = showName;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @XmlAttribute
    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public Integer getIsShow() {
        return isShow;
    }

    public void setIsShow(Integer isShow) {
        this.isShow = isShow;
    }

    @XmlAttribute
    public String getDescription() {
        return super.getDescription();
    }

    public void setDescription(String description) {
        super.setDescription(description);
    }

    @XmlAttribute
    public String getName() {
        return super.getName();
    }

    public void setName(String name) {
        super.setName(name);
    }

    public String getParentCode() {
        if (PublicUtil.isEmpty(parentCode) && parent != null) {
            parentCode = parent.getCode();
        }
        return parentCode;
    }

    public void setParentCode(String parentCode) {
        this.parentCode = parentCode;
    }

}
