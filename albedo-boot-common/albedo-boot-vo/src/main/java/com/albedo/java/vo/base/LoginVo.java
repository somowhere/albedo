package com.albedo.java.vo.base;


import com.albedo.java.util.domain.Globals;
import com.albedo.java.vo.sys.UserVo;
import lombok.Data;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

/**
 * View Model object for storing a user's credentials.
 */
@Data
@ToString
public class LoginVo {

    @Pattern(regexp = Globals.LOGIN_REGEX)
    @NotNull
    @Size(min = 1, max = 50)
    private String username;

    @NotNull
    @Size(min = 6, max = UserVo.PASSWORD_MAX_LENGTH)
    private String password;

    private Boolean rememberMe;

    public Boolean isRememberMe() {
        return rememberMe;
    }

    public void setRememberMe(Boolean rememberMe) {
        this.rememberMe = rememberMe;
    }

}
