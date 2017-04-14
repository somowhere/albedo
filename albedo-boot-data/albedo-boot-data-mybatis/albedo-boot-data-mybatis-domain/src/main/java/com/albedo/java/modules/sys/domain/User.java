package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.util.PublicUtil;
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

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Set;

/**
 * A user.
 */
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class User extends IdEntity {

    private static final long serialVersionUID = 1L;
    /*** F_LOGINID */
	public static final String F_LOGINID = "loginId";
	/*** F_LOGINID */
	public static final String F_EMAIL = "email";
	@NotBlank
    @Pattern(regexp = Globals.LOGIN_REGEX)
    @Size(min = 1, max = 50)
    private String loginId;

    @JSONField(serialize=false)
    @NotBlank
    @Size(min = 60, max = 60)
    private String password;
    
    @Size(max = 32)
    private String orgId;
    
    private Org org;
    
    @Size(max = 50)
    private String name;
    @Size(max = 50)
    private String phone;

    @Email
    @Size(max = 100)
    private String email;

    @NotNull
    private boolean activated = false;

    @Size(min = 2, max = 5)
    private String langKey;

    @Size(max = 20)
    @JSONField(serialize=false)
    private String activationKey;

    @Size(max = 20)
    private String resetKey;

    private ZonedDateTime resetDate = null;

    @ApiModelProperty(hidden=true)
    private Set<Role> roles = Sets.newHashSet();

    @JSONField(serialize=false)
    @ApiModelProperty(hidden=true)
    private Set<PersistentToken> persistentTokens =  Sets.newHashSet();    
    
    @ApiModelProperty(hidden=true)
    private String roleNames;
    private List<String> roleIdList;
    
    
    /** 用户拥有的角色名称字符串, 多个角色名称用','分隔. */
	public String getRoleNames() {
		if (PublicUtil.isEmpty(roleNames) && PublicUtil.isNotEmpty(roles)) {
			roleNames = Collections3.extractToString(roles, "name", ", ");
		}
		return roleNames;
	}

	public List<String> getRoleIdList() {
		if (PublicUtil.isEmpty(roleIdList) && PublicUtil.isNotEmpty(roles)) {
			roleIdList = Lists.newArrayList();
			roles.forEach(m -> {if(PublicUtil.isNotEmpty(m))roleIdList.add(m.getId());});
		}
		return roleIdList;
	}
	public String getRoleIds() {
		return Collections3.convertToString(getRoleIdList(), ",");
	}

	public void setRoleIdList(List<String> roleIdList) {
		this.roleIdList = roleIdList;
		if (PublicUtil.isNotEmpty(roleIdList)) {
			roles = Sets.newHashSet();
			roleIdList.forEach(m -> {if(PublicUtil.isNotEmpty(m))roles.add(new Role(m));});
		}
	}


}
