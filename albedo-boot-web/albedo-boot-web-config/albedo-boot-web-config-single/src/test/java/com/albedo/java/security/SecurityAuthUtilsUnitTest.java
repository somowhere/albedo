package com.albedo.java.security;

import com.albedo.java.common.security.SecurityAuthUtil;
import com.albedo.java.common.security.SecurityUtil;
import org.junit.Test;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import static org.assertj.core.api.Assertions.assertThat;

/**
* Test class for the SecurityUtils utility class.
*
* @see SecurityUtil
*/
public class SecurityAuthUtilsUnitTest {

    @Test
    public void testgetCurrentUserLogin() {
        SecurityContext securityContext = SecurityContextHolder.createEmptyContext();
        securityContext.setAuthentication(new UsernamePasswordAuthenticationToken("admin", "admin"));
        SecurityContextHolder.setContext(securityContext);
        String login = SecurityAuthUtil.getCurrentUserLogin();
        assertThat(login).isEqualTo("admin");
    }

    @Test
    public void testgetCurrentUserJWT() {
        SecurityContext securityContext = SecurityContextHolder.createEmptyContext();
        securityContext.setAuthentication(new UsernamePasswordAuthenticationToken("admin", "token"));
        SecurityContextHolder.setContext(securityContext);
        String jwt = SecurityAuthUtil.getCurrentUserJWT();
        assertThat(jwt).isEqualTo("token");
    }

}
