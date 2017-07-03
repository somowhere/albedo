package com.albedo.java.vo.sys;

import com.albedo.java.vo.base.GeneralVo;
import lombok.Data;
import lombok.ToString;

import java.time.ZonedDateTime;
import java.util.List;

/**
 * A user.
 */
@Data
@ToString
public class UserResult extends GeneralVo {

    /*** F_LOGINID */
    public static final String F_LOGINID = "loginId";
    /*** F_LOGINID */
    public static final String F_EMAIL = "email";
    private static final long serialVersionUID = 1L;
    private String loginId;
    private String orgId;
    private String orgName;
    private String name;
    private String phone;
    private String email;
    private boolean activated = false;
    private String langKey;
    private String activationKey;
    private String resetKey;
    private ZonedDateTime resetDate = null;
    private String roleNames;
    private List<String> roleIdList;

}
