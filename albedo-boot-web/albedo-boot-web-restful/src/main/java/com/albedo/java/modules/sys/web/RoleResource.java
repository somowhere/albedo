package com.albedo.java.modules.sys.web;

import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.util.DictUtil;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.base.SelectResult;
import com.albedo.java.vo.sys.RoleForm;
import com.albedo.java.vo.sys.query.DictQuery;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.stream.Collectors;


/**
 * REST controller for managing Station.
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/role")
public class RoleResource extends DataResource<RoleService, Role> {

    @GetMapping(value = "/findSelectData")
    public ResponseEntity findSelectData() {
        return ResultBuilder.buildOk(SecurityUtil.getRoleList().stream().map(item -> new SelectResult(item.getId(), item.getName())).collect(Collectors.toList()));
    }

    /**
     * @param pm
     * @return
     */
    @GetMapping(value = "/")
    public ResponseEntity getPage(PageModel<Role> pm) {
        service.findPage(pm, SecurityUtil.dataScopeFilter(SecurityUtil.getCurrentUserId(), "org", "creator"));
        JSON rs = JsonUtil.getInstance().setRecurrenceStr("org_name").toJsonObject(pm);
        return ResultBuilder.buildObject(rs);
    }

    /**
     *
     * @param id
     * @return
     */
    @GetMapping("/{id:" + Globals.LOGIN_REGEX + "}")
    @Timed
    public ResponseEntity getUser(@PathVariable String id) {
        log.debug("REST request to get Role : {}", id);
        return ResultBuilder.buildOk(service.findOneById(id)
                .map(item -> service.copyBeanToResult(item)));
    }
    /**
     * @param roleForm
     * @return
     */
    @PostMapping(value = "/",produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity save(@Valid @RequestBody RoleForm roleForm) {
        log.debug("REST request to save RoleForm : {}", roleForm);
        // Lowercase the role login before comparing with database
        if (!checkByProperty(Reflections.createObj(Role.class, Lists.newArrayList(Role.F_ID, Role.F_NAME),
                roleForm.getId(), roleForm.getName()))) {
            throw new RuntimeMsgException("名称已存在");
        }
        service.save(roleForm);
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("保存", roleForm.getName(), "成功");
    }

    /**
     * @param ids
     * @return
     */
    @PostMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
            + "}", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete Role: {}", ids);
        service.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("删除成功");
    }

    /**
     * @param ids
     * @return
     */
    @RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
            + "}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock User: {}", ids);
        service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("操作成功");
    }

}
