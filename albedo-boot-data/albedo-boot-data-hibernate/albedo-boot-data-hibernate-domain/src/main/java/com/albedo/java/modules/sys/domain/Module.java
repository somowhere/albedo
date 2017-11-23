package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.SearchField;
import com.albedo.java.util.domain.RequestMethod;
import lombok.Data;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * Copyright 2013 albedo All right reserved Author lijie Created on 2013-10-23 下午4:29:21
 */
@Entity
@Table(name = "SYS_MODULE_T")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@Data
public class Module extends TreeEntity<Module> {

    public static final String F_ID = "id";
    /*** 菜单模块 MENUFLAG = 0 */
    public static final String TYPE_MENU = "1";
    /*** 权限模块 MODULEFLAG = 1 */
    public static final String TYPE_OPERATE = "2";
    public static final String F_PERMISSION = "permission";
    private static final long serialVersionUID = 1L;
    /*** 模块类型 0 菜单模块 1权限模块 */
    @Column(name = "type_")
    @SearchField
    @DictType(name = "sys_module_type")
    private String type;
    /*** 目标 */
    @Column(name = "target_")
    private String target;
    /*** 请求方法*/
    @Column(name = "request_method")
    @DictType(name = "sys_request_method")
    private String requestMethod;
    /*** 链接地址 */
    @Column(name = "url_")
    private String url;
    /*** 图标class */
    @Column(name = "icon_cls")
    private String iconCls;
    /*** 权限标识 */
    @Column(name = "permission_")
    @SearchField
    private String permission;
    /*** 针对顶层菜单，0 普通展示下级菜单， 1以树形结构展示 */
    @Column(name = "show_type")
    private String showType;
    /*** 服务名称 */
    @Column(name = "microservice_")
    private String microservice;
//    @ManyToMany(mappedBy = "modules", fetch = FetchType.LAZY)
//    @Where(clause = "status_=0")
//    @OrderBy("id")
//    @NotFound(action = NotFoundAction.IGNORE)
//    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
//    @JSONField(serialize = false)
//    private Set<Role> roles = Sets.newHashSet(); // 拥有角色列表

    /*** 父模块名称 */
    @Transient
    private String parentName;

    public Module() {
    }

    public Module(String id) {
        this.id = id;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getHref() {
        if (url != null) {
            int indexSplit = url.indexOf(StringUtil.SPLIT_DEFAULT);
            return indexSplit == -1 ? url : url.substring(0, indexSplit);
        }
        return url;
    }

    public String getHrefName() {
        String temp = getHref();
        return StringUtil.toCamelCase(temp, '/');
    }

    public String getRequestMethod() {
        return requestMethod;
    }

    public void setRequestMethod(RequestMethod requestMethod) {
        this.requestMethod = requestMethod.name();
    }

    public void setRequestMethod(String requestMethod) {
        this.requestMethod = requestMethod;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getIconCls() {
        return iconCls;
    }

    public void setIconCls(String iconCls) {
        this.iconCls = iconCls;
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }

    public String getShowType() {
        return showType;
    }

    public void setShowType(String showType) {
        this.showType = showType;
    }

    public boolean isShow() {
        return FLAG_NORMAL.equals(status);
    }


}
