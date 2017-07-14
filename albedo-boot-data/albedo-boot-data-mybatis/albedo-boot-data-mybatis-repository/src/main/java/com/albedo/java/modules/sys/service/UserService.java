package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.service.DataService;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.OrgRepository;
import com.albedo.java.modules.sys.repository.PersistentTokenRepository;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.util.DateUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.RandomUtil;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.vo.sys.UserForm;
import com.albedo.java.vo.sys.UserResult;
import org.springframework.beans.BeanUtils;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * Service class for managing users.
 */
@Service
@Transactional
public class UserService extends DataService<UserRepository, User, String> {

    @Resource
    OrgRepository orgRepository;
    @Resource
    private PersistentTokenRepository persistentTokenRepository;
    @Resource
    private RoleRepository roleRepository;

    public UserResult copyBeanToResult(User user) {
        UserResult userResult = new UserResult();
        BeanUtils.copyProperties(user, userResult);
        userResult.setRoleNames(user.getRoleNames());
        if (user.getOrg() != null) userResult.setOrgName(user.getOrg().getName());
        return userResult;
    }

    public UserForm copyBeanToForm(User user) {
        UserForm userForm = new UserForm();
        BeanUtils.copyProperties(user, userForm);
        return userForm;
    }

    public User copyFormToBean(UserForm userForm) {
        return copyFormToBean(userForm, new User());
    }

    public User copyFormToBean(UserForm userForm, User user) {
        BeanUtils.copyProperties(userForm, user);
        user.setRoleIdList(userForm.getRoleIdList());
        return user;
    }


    public Optional<UserResult> activateRegistration(String key) {
        log.debug("Activating user for activation key {}", key);
        return repository.findOneByActivationKey(key)
                .map(user -> {
                    // activate given user for the registration key.
                    user.setActivated(true);
                    user.setActivationKey(null);
                    repository.save(user);
                    log.debug("Activated user: {}", user);
                    return copyBeanToResult(user);
                });
    }

    public UserResult save(UserForm userForm) {
        User user = PublicUtil.isNotEmpty(userForm.getId()) ? repository.findOneById(userForm.getId()) : new User();
        copyFormToBean(userForm, user);
        if (user.getLangKey() == null) {
            user.setLangKey("zh-cn"); // default language
        } else {
            user.setLangKey(user.getLangKey());
        }
        user.setResetKey(RandomUtil.generateResetKey());
        user.setResetDate(PublicUtil.getCurrentDate());
        user.setActivated(true);
        user = repository.save(user);
        if (PublicUtil.isNotEmpty(user.getRoleIdList())) {
            repository.deleteUserRoles(user);
            repository.addUserRoles(user);
        }
        log.debug("Save Information for User: {}", user);

        return copyBeanToResult(user);
    }

    @Transactional(readOnly = true)
    public Optional<UserResult> getUserWithAuthoritiesByLogin(String login) {
        return repository.findOneByLoginId(login).map(u -> {
            u.getRoles().size();
            return copyBeanToResult(u);
        });
    }

    @Transactional(readOnly = true)
    public UserResult getUserWithAuthorities(String id) {
        User user = repository.findOne(id);
        return copyBeanToResult(user);
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
        List<User> users = repository.findAllByActivatedIsFalseAndCreatedDateBefore(DateUtil.addDays(PublicUtil.getCurrentDate(), -3));
        for (User user : users) {
            log.debug("Deleting not activated user {}", user.getLoginId());
            repository.delete(user);
        }
    }


    @Transactional(readOnly = true)
    public UserResult findResult(String id) {
        User user = repository.findOne(id);
        return copyBeanToResult(user);
    }

    @Transactional(readOnly = true)
    public UserForm findForm(String id) {
        User user = repository.findOne(id);
        return copyBeanToForm(user);
    }
    @Transactional(readOnly = true)
    public PageModel<User> findPageRest(PageModel<User> pm, List<QueryCondition> andQueryConditions, List<QueryCondition> orQueryConditions) {
        //拼接查询动态对象
        SpecificationDetail<User> spec = DynamicSpecifications.bySearchQueryCondition(
                    andQueryConditions,
                        QueryCondition.ne(User.F_STATUS, User.FLAG_DELETE).setAnalytiColumnPrefix("a"),
                        QueryCondition.ne("a.id_", "1").setAnalytiColumn(false));
        spec.orAll(orQueryConditions);
        //动态生成sql分页查询
//        Page<User> page = repository.findAll(spec, pm);
//        pm.setPageInstance(page);
//        pm.getData().forEach(item -> item.setOrg(orgRepository.findBasicOne(item.getOrgId())));
        //自定义sql分页查询
        findBasePage(pm, spec, false, "selectPage", "countPage");


        return pm;
    }
    @Transactional(readOnly = true)
    public PageModel<User> findPage(PageModel<User> pm, List<QueryCondition> authQueryConditions) {
        //拼接查询动态对象
        SpecificationDetail<User> spec = DynamicSpecifications.
                buildSpecification(pm.getQueryConditionJson(),
                        QueryCondition.ne(User.F_STATUS, User.FLAG_DELETE).setAnalytiColumnPrefix("a"),
                        QueryCondition.ne("a.id_", "1").setAnalytiColumn(false));
        spec.orAll(authQueryConditions);
        //动态生成sql分页查询
//        Page<User> page = repository.findAll(spec, pm);
//        pm.setPageInstance(page);
//        pm.getData().forEach(item -> item.setOrg(orgRepository.findBasicOne(item.getOrgId())));
        //自定义sql分页查询
        findBasePage(pm, spec, false, "selectPage", "countPage");


        return pm;
    }


}
