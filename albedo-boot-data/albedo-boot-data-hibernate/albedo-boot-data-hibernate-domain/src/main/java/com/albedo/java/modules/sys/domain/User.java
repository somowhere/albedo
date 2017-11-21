package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.annotation.SearchField;
import com.albedo.java.util.base.Collections3;
import com.albedo.java.util.domain.Globals;
import com.alibaba.fastjson.annotation.JSONField;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import io.swagger.annotations.ApiModelProperty;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.*;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

import javax.persistence.CascadeType;
import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Set;
/**
 * A user.
 */
@Entity
@Table(name = "sys_user_t")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class User extends IdEntity {

    /*** F_LOGINID */
    public static final String F_LOGINID = "loginId";
    /*** F_LOGINID */
    public static final String F_EMAIL = "email";
    private static final long serialVersionUID = 1L;
    @NotBlank
    @Pattern(regexp = Globals.LOGIN_REGEX)
    @Size(min = 1, max = 50)
    @Column(name = "login_id", length = 50, unique = true, nullable = false)
    @SearchField
    private String loginId;

    @JSONField(serialize = false)
    @NotBlank
    @Size(min = 60, max = 60)
    @Column(name = "password_hash", length = 60)
    private String password;

    @Size(max = 32)
    @Column(name = "org_id", length = 32)
    private String orgId;

    @ManyToOne
    @JoinColumn(name = "org_id", updatable = false, insertable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    @ApiModelProperty(hidden = true)
    private Org org;

    @Size(max = 50)
    @Column(name = "name_", length = 50)
    private String name;
    @Size(max = 50)
    @Column(name = "phone_", length = 50)
    private String phone;

    @Email
    @Size(max = 100)
    @Column(name = "email_", length = 100)
    @SearchField
    private String email;

    @NotNull
    @Column(name = "activated_", nullable = false)
    private boolean activated = false;

    @Size(min = 2, max = 5)
    @Column(name = "lang_key", length = 5)
    private String langKey;

    @Size(max = 20)
    @Column(name = "activation_key", length = 20)
    @JSONField(serialize = false)
    private String activationKey;

    @Size(max = 20)
    @Column(name = "reset_key", length = 20)
    private String resetKey;

    @Column(name = "reset_date", nullable = true)
    private ZonedDateTime resetDate = null;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "sys_user_role_t",
            joinColumns = {@JoinColumn(name = "user_id", referencedColumnName = "id_")},
            inverseJoinColumns = {@JoinColumn(name = "role_id", referencedColumnName = "id_")})
    @Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
    @ApiModelProperty(hidden = true)
    private Set<Role> roles = Sets.newHashSet();

    @JSONField(serialize = false)
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "user")
    @Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
    @ApiModelProperty(hidden = true)
    private Set<PersistentToken> persistentTokens = Sets.newHashSet();

    @Transient
    @ApiModelProperty(hidden = true)
    private String roleNames;
    @Transient
    private List<String> roleIdList;


    /**
     * 用户拥有的角色名称字符串, 多个角色名称用','分隔.
     */
    public String getRoleNames() {
        if (PublicUtil.isEmpty(roleNames) && PublicUtil.isNotEmpty(roles)) {
            roleNames = Collections3.extractToString(roles, "name", ", ");
        }
        return roleNames;
    }

    public void setRoleNames(String roleNames) {
        this.roleNames = roleNames;
    }

    public String getLoginId() {
        return loginId;
    }

    //Lowercase the login before saving it in database
    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean getActivated() {
        return activated;
    }

    public void setActivated(boolean activated) {
        this.activated = activated;
    }

    public String getActivationKey() {
        return activationKey;
    }

    public void setActivationKey(String activationKey) {
        this.activationKey = activationKey;
    }

    public String getResetKey() {
        return resetKey;
    }

    public void setResetKey(String resetKey) {
        this.resetKey = resetKey;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ZonedDateTime getResetDate() {
        return resetDate;
    }

    public void setResetDate(ZonedDateTime resetDate) {
        this.resetDate = resetDate;
    }

    public String getLangKey() {
        return langKey;
    }

    public void setLangKey(String langKey) {
        this.langKey = langKey;
    }


    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public Set<PersistentToken> getPersistentTokens() {
        return persistentTokens;
    }

    public void setPersistentTokens(Set<PersistentToken> persistentTokens) {
        this.persistentTokens = persistentTokens;
    }

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public Org getOrg() {
        return org;
    }

    public void setOrg(Org org) {
        this.org = org;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        User user = (User) o;

        if (loginId==null || !loginId.equals(user.loginId)) {
            return false;
        }

        return true;
    }

    @Override
    public int hashCode() {
        return loginId == null ? 0 : loginId.hashCode();
    }

    @Override
    public String toString() {
        return "User{" +
                "loginId='" + loginId + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", activated='" + activated + '\'' +
                ", langKey='" + langKey + '\'' +
                ", activationKey='" + activationKey + '\'' +
                "}";
    }

    public List<String> getRoleIdList() {
        if (PublicUtil.isEmpty(roleIdList) && PublicUtil.isNotEmpty(roles)) {
            roleIdList = Lists.newArrayList();
            roles.forEach(m -> {
                if (PublicUtil.isNotEmpty(m)) roleIdList.add(m.getId());
            });
        }
        return roleIdList;
    }

    public void setRoleIdList(List<String> roleIdList) {
        this.roleIdList = roleIdList;
        if (PublicUtil.isNotEmpty(roleIdList)) {
            roles = Sets.newHashSet();
            roleIdList.forEach(m -> {
                if (PublicUtil.isNotEmpty(m)) {
                    roles.add(new Role(m));
                }
            });
        }
    }

    public String getRoleIds() {
        return Collections3.convertToString(getRoleIdList(), ",");
    }


}
