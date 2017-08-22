package com.albedo.java.vo.sys;

import com.albedo.java.vo.base.GeneralEntityVo;
import lombok.Data;
import lombok.ToString;

import java.time.ZonedDateTime;
import java.util.List;

/**
 * A user.
 */
@Data
@ToString
public class UserForm extends GeneralEntityVo {

    /*** F_LOGINID */
    public static final String F_LOGINID = "loginId";
    /*** F_LOGINID */
    public static final String F_EMAIL = "email";
    private static final long serialVersionUID = 1L;
    private String id;
    private String loginId;
    private String password;
    private String confirmPassword;
    private String orgId;

    private String name;
    private String phone;

    private String email;

    private boolean activated = false;

    private String langKey;

    private String activationKey;

    private String resetKey;
    private Integer status;
    private ZonedDateTime resetDate = null;

    private List<String> roleIdList;

    public void setRoleIdList(List<String> roleIdList) {
        this.roleIdList = roleIdList;
    }


}
