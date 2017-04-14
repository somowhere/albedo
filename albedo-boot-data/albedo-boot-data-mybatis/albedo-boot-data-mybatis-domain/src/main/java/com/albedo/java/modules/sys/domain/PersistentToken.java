package com.albedo.java.modules.sys.domain;

import com.albedo.java.util.annotation.SearchField;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.time.LocalDate;

/**
 * Persistent tokens are used by Spring Security to automatically log in users.
 *
 * @see com.albedo.java.common.security.service.CustomPersistentRememberMeServices
 */
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class PersistentToken implements Serializable {

    private static final long serialVersionUID = 1L;

    private static final int MAX_USER_AGENT_LEN = 255;

	@SearchField
	protected String id; // 编号
    private String series;

    @JsonIgnore
    @NotNull
    private String tokenValue;
    
    private LocalDate tokenDate;

    //an IPV6 address max length is 39 characters
    @Size(min = 0, max = 39)
    private String ipAddress;

    private String userAgent;

    /*** 用户 */
	@Length(min = 0, max = 2000)
	private String userId;
	/*** 用户  */
	 @JsonIgnore
	private User user;
	
}
