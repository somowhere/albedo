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
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mybatis.annotations.*;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * A user.
 */
@Entity(table = "sys_user_t")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class User extends IdEntity {

    /*** F_LOGINID */
    public static final String F_LOGINID = "loginId";
    /*** F_LOGINID */
    public static final String F_EMAIL = "email";
    private static final long serialVersionUID = 1L;
    @NotBlank
    @Pattern(regexp = Globals.LOGIN_REGEX)
    @Size(min = 1, max = 50)
    @Column(name = "login_id")
    @SearchField
    private String loginId;

    @JSONField(serialize = false)
    @NotBlank
    @Size(min = 60, max = 60)
    @Column(name = "password_hash")
    private String password;

    @Size(max = 32)
    @Column(name = "org_id")
    private String orgId;

    @ManyToOne
    @JoinColumn(name = "org_id", insertable = false, updatable = false)
    @ApiModelProperty(hidden = true)
    private Org org;

    @Size(max = 50)
    @Column(name = "name_")
    private String name;
    @Size(max = 50)
    @Column(name = "phone_")
    private String phone;

    @Email
    @Size(max = 100)
    @Column(name = "email_")
    private String email;

    @NotNull
    @Column(name = "activated_")
    private boolean activated = false;

    @Size(min = 2, max = 5)
    @Column(name = "lang_key")
    private String langKey;

    @Size(max = 20)
    @Column(name = "activation_key")
    @JSONField(serialize = false)
    private String activationKey;

    @Size(max = 20)
    @Column(name = "reset_key")
    private String resetKey;

    @Column(name = "reset_date")
    private Date resetDate = null;
    @ManyToMany
    @JoinTable(
            name = "sys_user_role_t",
            joinColumns = {@JoinColumn(name = "user_id", referencedColumnName = "id_")},
            inverseJoinColumns = {@JoinColumn(name = "role_id", referencedColumnName = "id_")})
    @ApiModelProperty(hidden = true)
    @JSONField(serialize = false)
    private Set<Role> roles = Sets.newHashSet();
    @JSONField(serialize = false)
    @OneToMany
    @ApiModelProperty(hidden = true)
    @JoinColumn(name = "user_id")
    private Set<PersistentToken> persistentTokens = Sets.newHashSet();
    @Transient
    @ApiModelProperty(hidden = true)
    private String roleNames;
    @Transient
    private List<String> roleIdList;

    public User(String id) {
        this.id = id;
    }

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

    public Date getResetDate() {
        return resetDate;
    }

    public void setResetDate(Date resetDate) {
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

    public Org getOrg() {
        return org;
    }

    public void setOrg(Org org) {
        this.org = org;
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
                if (PublicUtil.isNotEmpty(m)) roles.add(new Role(m));
            });
        }
    }

}
