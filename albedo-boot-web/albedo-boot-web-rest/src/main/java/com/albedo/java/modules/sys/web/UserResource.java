package com.albedo.java.modules.sys.web;

import com.albedo.java.common.config.template.tag.FormDirective;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.service.ModuleService;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.sys.UserVo;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataVoResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.stream.Collectors;

/**
 * REST controller for managing user.
 * <p>
 * <p>
 * This class accesses the User entity, and needs to fetch its collection of
 * authorities.
 * </p>
 * <p>
 * For a normal use-case, it would be better to have an eager relationship
 * between User and Authority, and send everything to the client side: there
 * would be no View Model and DTO, a lot less code, and an outer-join which
 * would be good for performance.
 * </p>
 * <p>
 * We use a View Model and a DTO for 3 reasons:
 * <ul>
 * <li>We want to keep a lazy association between the user and the authorities,
 * because people will quite often do relationships with the user, and we don't
 * want them to get the authorities all the time for nothing (for performance
 * reasons). This is the #1 goal: we should not impact our user' application
 * because of this use-case.</li>
 * <li>Not having an outer join causes n+1 requests to the database. This is not
 * a real issue as we have by default a second-level cache. This means on the
 * first HTTP call we do the n+1 requests, but then all authorities come from
 * the cache, so in fact it's much better than doing an outer join (which will
 * get lots of data from the database, for each HTTP call).</li>
 * <li>As this manages user, for security reasons, we'd rather have a DTO
 * layer.</li>
 * </ul>
 * <p>
 * Another option would be to have a specific JPA entity graph to handle this
 * case.
 * </p>
 *
 * @author somewhere
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/user")
public class UserResource extends DataVoResource<UserService, UserVo> {


    @Autowired(required = false)
    private PasswordEncoder passwordEncoder;
    @Autowired
    private ModuleService moduleService;


    @GetMapping(value = "/")
    @Timed
    public String list() {
        return "modules/sys/userList";
    }

    /**
     * 分页
     *
     * @param pm
     */
    @GetMapping(value = "/page")
    public ResponseEntity getPage(PageModel pm) {
        pm = service.findPage(pm, SecurityUtil.dataScopeFilterSql("d", "a"));
        JSON rs = JsonUtil.getInstance().setFreeFilters("roleIdList").setRecurrenceStr("org_name").toJsonObject(pm);
        return ResultBuilder.buildObject(rs);
    }

    /**
     * GET  /users/:id : get the "login" user.
     *
     * @param id the login of the user to find
     * @return the ResponseEntity with status 200 (OK) and with body the "id" user, or with status 404 (Not Found)
     */
    @GetMapping("/{id:" + Globals.LOGIN_REGEX + "}")
    @Timed
    public ResponseEntity getUser(@PathVariable String id) {
        log.debug("REST request to get User : {}", id);
        return ResultBuilder.buildOk(service.findOneById(id)
                .map(item -> service.copyBeanToVo(item)));
    }


    /**
     * GET  /users/:id : get the "login" user.
     *
     * @return the ResponseEntity with status 200 (OK) and with body the "id" user, or with status 404 (Not Found)
     */
    @GetMapping("/authorities")
    @Timed
    public ResponseEntity authorities() {
        String id = SecurityUtil.getCurrentUserId();
        log.debug("REST request to authorities  : {}", id);
        return ResultBuilder.buildOk(SecurityUtil.getModuleList().stream().map(item -> moduleService.copyBeanToVo(item)).collect(Collectors.toList()));
    }



    @GetMapping(value = "/edit", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
//	@Secured(AuthoritiesConstants.ADMIN)
    public String form(UserVo userVo, Model model, @RequestParam(required = false) Boolean isModal) {
        model.addAttribute("allRoles", FormDirective.convertComboDataList(SecurityUtil.getRoleList(), Role.F_ID, Role.F_NAME));
        return PublicUtil.toAppendStr("modules/sys/userForm", isModal ? "Modal" : "");
    }

    /**
     * 保存
     *
     * @param userVo
     * @return
     */
    @PostMapping(value = "/edit", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    @ApiImplicitParams(@ApiImplicitParam(paramType = "query", name = "confirmPassword"))
    public ResponseEntity save(@Valid @RequestBody UserVo userVo) {
        log.debug("REST request to save userVo : {}", userVo);
        // beanValidatorAjax(user);
        if (PublicUtil.isNotEmpty(userVo.getPassword()) && !userVo.getPassword().equals(userVo.getConfirmPassword())) {
            throw new RuntimeMsgException("两次输入密码不一致");
        }
        // Lowercase the user login before comparing with database
        if (!checkByProperty(Reflections.createObj(UserVo.class, Lists.newArrayList(UserVo.F_ID, UserVo.F_LOGINID),
                userVo.getId(), userVo.getLoginId()))) {
            throw new RuntimeMsgException("登录Id已存在");
        }
        if (PublicUtil.isNotEmpty(userVo.getEmail()) && !checkByProperty(Reflections.createObj(UserVo.class,
                Lists.newArrayList(UserVo.F_ID, UserVo.F_EMAIL), userVo.getId(), userVo.getEmail()))) {
            throw new RuntimeMsgException("邮箱已存在");
        }
        if (PublicUtil.isNotEmpty(userVo.getId())) {
            UserVo temp = service.findOneVo(userVo.getId());
            userVo.setPassword(PublicUtil.isEmpty(userVo.getPassword()) ? temp.getPassword() : passwordEncoder.encode(userVo.getPassword()));
        } else {
            userVo.setPassword(passwordEncoder.encode(userVo.getPassword()));
        }
        service.save(userVo);
        SecurityUtil.clearUserJedisCache();
        SecurityUtil.clearUserLocalCache();
        return ResultBuilder.buildOk("保存", userVo.getLoginId(), "成功");
    }

    /**
     * 批量删除
     *
     * @param ids
     * @return
     */
    @PostMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX + "}")
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete User: {}", ids);
        service.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        SecurityUtil.clearUserLocalCache();
        return ResultBuilder.buildOk("删除成功");
    }

    /**
     * 锁定or解锁
     *
     * @param ids
     * @return
     */
    @PostMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX + "}")
    @Timed
    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock User: {}", ids);
        service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        SecurityUtil.clearUserLocalCache();
        return ResultBuilder.buildOk("操作成功");
    }

}
