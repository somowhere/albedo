package com.albedo.java.common.security.service;

import com.albedo.java.common.security.*;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.google.common.collect.Lists;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

/**
 * Authenticate a user from the database.
 */
@Component("userDetailsService")
public class UserDetailsService implements org.springframework.security.core.userdetails.UserDetailsService {

    private final Logger log = LoggerFactory.getLogger(UserDetailsService.class);

    @Resource
    private UserRepository userRepository;

    @Override
    @Transactional
    public UserDetails loadUserByUsername(final String login) {
        log.debug("Authenticating {}", login);
        String lowercaseLogin = login.toLowerCase(Locale.ENGLISH);
        Optional<User> userFromDatabase = userRepository.findOneByLoginId(lowercaseLogin);
        return userFromDatabase.map(user -> {
            if (!user.getActivated()) {
                throw new UserNotActivatedException("User " + lowercaseLogin + " was not activated");
            }

            List<GrantedAuthority> grantedAuthorities = Lists.newArrayList(new SimpleGrantedAuthority("user"));
            if (SecurityAuthUtil.isAdmin(user.getId())) {
                grantedAuthorities.add(new SimpleGrantedAuthority(AuthoritiesConstants.ADMIN));
            }
            SecurityUtil.getModuleList(user.getId()).forEach(authority -> {
                if (PublicUtil.isNotEmpty(authority.getPermission())) {
                    Lists.newArrayList(authority.getPermission().split(StringUtil.SPLIT_DEFAULT)).forEach(p -> {
                        grantedAuthorities.add(new SimpleGrantedAuthority(p));
                    });
                }
            });
            return new UserPrincipal(user.getId(), lowercaseLogin,
                    user.getPassword(),
                    grantedAuthorities);
        }).orElseThrow(() -> new UsernameNotFoundException("User " + lowercaseLogin + " was not found in the " +
                "database"));
    }
}
