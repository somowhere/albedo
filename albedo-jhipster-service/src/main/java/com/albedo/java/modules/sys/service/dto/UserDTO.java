package com.albedo.java.modules.sys.service.dto;

import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.util.domain.Globals;
import org.hibernate.validator.constraints.Email;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * A DTO representing a user, with his authorities.
 */
public class UserDTO {

    @Pattern(regexp = Globals.LOGIN_REGEX)
    @Size(min = 1, max = 50)
    private String loginId;

    @Size(max = 50)
    private String name;

    @Email
    @Size(min = 5, max = 100)
    private String email;

    private boolean activated = false;

    @Size(min = 2, max = 5)
    private String langKey;

    private Set<String> roles;

    public UserDTO() {
    }

    public UserDTO(User user) {
        this(user.getLoginId(), user.getName(),
            user.getEmail(), user.getActivated(), user.getLangKey(),
            user.getRoles().stream().map(Role::getName)
                .collect(Collectors.toSet()));
    }

    public UserDTO(String loginId, String name,
        String email, boolean activated, String langKey, Set<String> roles) {

        this.loginId = loginId;
        this.name = name;
        this.email = email;
        this.activated = activated;
        this.langKey = langKey;
        this.roles = roles;
    }

    public String getName() {
		return name;
	}

	public String getLoginId() {
        return loginId;
    }

    public String getEmail() {
        return email;
    }

    public boolean isActivated() {
        return activated;
    }

    public String getLangKey() {
        return langKey;
    }
    public Set<String> getRoles() {
        return roles;
    }

    @Override
    public String toString() {
        return "UserDTO{" +
            "loginId='" + loginId + '\'' +
            ", name='" + name + '\'' +
            ", email='" + email + '\'' +
            ", activated=" + activated +
            ", langKey='" + langKey + '\'' +
            ", roles=" + roles +
            "}";
    }
}
