package com.albedo.java.common.security;

import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Iterator;

@Service
public class CustomizeAccessDecisionManager implements AccessDecisionManager {

    public void decide(Authentication authentication, Object object, Collection<ConfigAttribute> configAttributes)
            throws AccessDeniedException, InsufficientAuthenticationException {

        if (configAttributes == null) {
            return;
        }
        if (SecurityAuthUtil.isAdmin(SecurityUtil.getCurrentUserId())) {
            return;
        }


        Iterator<ConfigAttribute> ite = configAttributes.iterator();

        while (ite.hasNext()) {
            ConfigAttribute ca = ite.next();

//			if(Globals.AUTHENTICATED.equals(ca.toString()))return;

            String needRole = ca.getAttribute();
            // ga 为用户所被赋予的权限。 needRole 为访问相应的资源应该具有的权限。
            for (GrantedAuthority ga : authentication.getAuthorities()) {

                if (needRole.trim().equals(ga.getAuthority().trim())) {

                    return;
                }
            }
        }

        throw new AccessDeniedException("权限不足");

    }

    public boolean supports(ConfigAttribute attribute) {

        return true;

    }

    public boolean supports(Class<?> clazz) {
        return true;

    }
}
