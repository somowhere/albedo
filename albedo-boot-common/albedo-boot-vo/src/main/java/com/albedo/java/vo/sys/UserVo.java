package com.albedo.java.vo.sys;

import com.albedo.java.util.base.Collections3;
import com.albedo.java.vo.base.DataEntityVo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.Size;
import java.time.ZonedDateTime;
import java.util.List;

/**
 * A user.
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UserVo extends DataEntityVo {

    public static final int PASSWORD_MIN_LENGTH = 0;

    public static final int PASSWORD_MAX_LENGTH = 100;

    /*** F_LOGINID */
    public static final String F_LOGINID = "loginId";
    /*** F_LOGINID */
    public static final String F_EMAIL = "email";
    private static final long serialVersionUID = 1L;
    private String id;
    private String loginId;
    @Size(max = PASSWORD_MAX_LENGTH)
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
    private ZonedDateTime resetDate = null;

    private List<String> roleIdList;
    private String roleNames;
    private String orgName;


    public String getRoleIds() {
        return Collections3.convertToString(getRoleIdList(), ",");
    }

}
