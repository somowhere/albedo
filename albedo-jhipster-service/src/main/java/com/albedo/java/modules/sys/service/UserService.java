package com.albedo.java.modules.sys.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.repository.service.BaseService;
import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.PersistentTokenRepository;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.util.RandomUtil;
import com.albedo.java.util.DateUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import org.springframework.data.domain.Page;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import java.time.LocalDate;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Set;

/**
 * Service class for managing users.
 */
@Service
@Transactional
public class UserService extends BaseService<User> {

    @Inject
    private PasswordEncoder passwordEncoder;

    @Inject
    private UserRepository userRepository;

    @Inject
    private PersistentTokenRepository persistentTokenRepository;

    @Inject
    private RoleRepository roleRepository;

    public Optional<User> activateRegistration(String key) {
        log.debug("Activating user for activation key {}", key);
        return userRepository.findOneByActivationKey(key)
            .map(user -> {
                // activate given user for the registration key.
                user.setActivated(true);
                user.setActivationKey(null);
                userRepository.save(user);
                log.debug("Activated user: {}", user);
                return user;
            });
    }

    public Optional<User> completePasswordReset(String newPassword, String key) {
       log.debug("Reset user password for reset key {}", key);

       return userRepository.findOneByResetKey(key)
            .filter(user -> {
                ZonedDateTime oneDayAgo = ZonedDateTime.now().minusHours(24);
                return user.getResetDate().isAfter(oneDayAgo);
           })
           .map(user -> {
                user.setPassword(passwordEncoder.encode(newPassword));
                user.setResetKey(null);
                user.setResetDate(null);
                userRepository.save(user);
                return user;
           });
    }

    public Optional<User> requestPasswordReset(String mail) {
        return userRepository.findOneByEmail(mail)
            .filter(User::getActivated)
            .map(user -> {
                user.setResetKey(RandomUtil.generateResetKey());
                user.setResetDate(ZonedDateTime.now());
                userRepository.save(user);
                return user;
            });
    }

    public User create(String login, String password, String name, String email,
        String langKey) {

        User newUser = new User();
        Role authority = roleRepository.findOne(AuthoritiesConstants.USER);
        Set<Role> authorities = Sets.newHashSet();
        String encryptedPassword = passwordEncoder.encode(password);
        newUser.setLoginId(login);
        // new user gets initially a generated password
        newUser.setPassword(encryptedPassword);
        newUser.setName(name);
        newUser.setEmail(email);
        newUser.setLangKey(langKey);
        // new user is not active
        newUser.setActivated(false);
        // new user gets registration key
        newUser.setActivationKey(RandomUtil.generateActivationKey());
        authorities.add(authority);
        newUser.setRoles(authorities);
        userRepository.save(newUser);
        log.debug("Created Information for User: {}", newUser);
        SecurityUtil.clearUserJedisCache();
        SecurityUtil.clearUserLocalCache();
        return newUser;
    }

    public User save(User user) {
        if (user.getLangKey() == null) {
            user.setLangKey("zh-cn"); // default language
        } else {
            user.setLangKey(user.getLangKey());
        }
        if(PublicUtil.isNotEmpty(user.getId())){
        	User temp = findOne(user.getId());
        	user.setPassword(PublicUtil.isEmpty(user.getPassword()) ? temp.getPassword() : passwordEncoder.encode(user.getPassword()));
        }else{
        	user.setPassword(passwordEncoder.encode(user.getPassword()));
        }
        
        user.setResetKey(RandomUtil.generateResetKey());
        user.setResetDate(ZonedDateTime.now());
        user.setActivated(true);
        user = userRepository.save(user);
        log.debug("Save Information for User: {}", user);
        SecurityUtil.clearUserJedisCache();
        SecurityUtil.clearUserLocalCache();
        return user;
    }

    public void update(String name, String email, String langKey) {
        userRepository.findOneById(SecurityUtil.getCurrentUserId()).ifPresent(u -> {
            u.setName(name);
            u.setEmail(email);
            u.setLangKey(langKey);
            userRepository.save(u);
            log.debug("Changed Information for User: {}", u);
        });
    }

    public void update(String id, String login, String firstName, String lastName, String email,
        boolean activated, String langKey, Set<String> authorities) {
        userRepository
            .findOneById(id)
            .ifPresent(u -> {
                u.setLoginId(login);
                u.setName(firstName);
                u.setEmail(email);
                u.setActivated(activated);
                u.setLangKey(langKey);
                Set<Role> managedAuthorities = u.getRoles();
                managedAuthorities.clear();
                authorities.stream().forEach(
                    authority -> managedAuthorities.add(roleRepository.findOne(authority))
                );
                log.debug("Changed Information for User: {}", u);
            });
    }

    public void delete(String ids) {
    	Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id ->{
    		userRepository.findOneById(id).map(u -> {
    			deleteById(id);
                log.debug("Deleted User: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("用户 " + id + " 信息为空，删除失败"));
    	});
    	SecurityUtil.clearUserJedisCache();
    	SecurityUtil.clearUserLocalCache();
    }
    
    public void lockOrUnLock(String ids) {
    	Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id ->{
    		userRepository.findOneById(id).map(u -> {
    			operateStatusById(id, BaseEntity.FLAG_NORMAL.equals(u.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL);
                log.debug("LockOrUnLock User: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("用户 " + id + " 信息为空，操作失败"));
    	});
    	SecurityUtil.clearUserJedisCache();
    	SecurityUtil.clearUserLocalCache();
	}
    

    public void changePassword(String userId, String password, String newPassword, String confirmPassword) {
    	
    	if(PublicUtil.isEmpty(password) || PublicUtil.isEmpty(newPassword) || PublicUtil.isEmpty(confirmPassword)){
        	throw new RuntimeMsgException("新旧密码不能为空");
        }
    	if(password.equals(newPassword)){
    		throw new RuntimeMsgException("新旧密码不能一致");
    	}
    	if(!newPassword.equals(confirmPassword)){
    		throw new RuntimeMsgException("新密码与确认密码不一致");
    	}
        userRepository.findOneById(SecurityUtil.getCurrentUserId()).ifPresent(u -> {
            if(!passwordEncoder.matches(password, u.getPassword())){
            	throw new RuntimeMsgException("旧密码输入有误");
            }
            u.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(u);
            log.debug("Changed password for User: {}", u);
        });
    }

    @Transactional(readOnly = true)
    public Optional<User> getUserWithAuthoritiesByLogin(String login) {
        return userRepository.findOneByLoginId(login).map(u -> {
            u.getRoles().size();
            return u;
        });
    }

    @Transactional(readOnly = true)
    public User getUserWithAuthorities(String id) {
        User user = userRepository.findOne(id);
        user.getRoles().size(); // eagerly load the association
        return user;
    }

    @Transactional(readOnly = true)
    public User getUserWithAuthorities() {
        Optional<User> optionalUser = userRepository.findOneById(SecurityUtil.getCurrentUserId());
        User user = null;
        if (optionalUser.isPresent()) {
          user = optionalUser.get();
            user.getRoles().size(); // eagerly load the association
         }
         return user;
    }

    /**
     * Persistent Token are used for providing automatic authentication, they should be automatically deleted after
     * 30 days.
     * <p>
     * This is scheduled to get fired everyday, at midnight.
     * </p>
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void removeOldPersistentTokens() {
        LocalDate now = LocalDate.now();
        persistentTokenRepository.findByTokenDateBefore(now.minusMonths(1)).stream().forEach(token -> {
            log.debug("Deleting token {}", token.getSeries());
            User user = token.getUser();
            user.getPersistentTokens().remove(token);
            persistentTokenRepository.delete(token);
        });
    }

    /**
     * Not activated users should be automatically deleted after 3 days.
     * <p>
     * This is scheduled to get fired everyday, at 01:00 (am).
     * </p>
     */
    @Scheduled(cron = "0 0 1 * * ?")
    public void removeNotActivatedUsers() {
//        ZonedDateTime now = ZonedDateTime.now();
        List<User> users = userRepository.findAllByActivatedIsFalseAndCreatedDateBefore(DateUtil.addDays(PublicUtil.getCurrentDate(), -3));
        for (User user : users) {
            log.debug("Deleting not activated user {}", user.getLoginId());
            userRepository.delete(user);
        }
    }

	
	@Transactional(readOnly=true)
	public User findOne(String id) {
		return userRepository.findOne(id);
	}

	@Transactional(readOnly=true)
	public Page<User> findAll(SpecificationDetail<User> spec, PageModel<User> pm) {
		return userRepository.findAll(spec, pm);
	}
	
	
}
