package com.albedo.java.modules.sys.web;

import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.base.SelectResult;
import com.albedo.java.vo.sys.RoleVo;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataVoResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.stream.Collectors;


/**
 * REST controller for managing Station.
 *
 * @author somewhere
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/role")
public class RoleResource extends DataVoResource<RoleService, RoleVo> {

    @GetMapping(value = "/findSelectData")
    public ResponseEntity findSelectData() {
        return ResultBuilder.buildOk(SecurityUtil.getRoleList().stream().map(item -> new SelectResult(item.getId(), item.getName())).collect(Collectors.toList()));
    }

    /**
     * @param id
     * @return
     */
    @GetMapping("/{id:" + Globals.LOGIN_REGEX + "}")
    @Timed
    public ResponseEntity getUser(@PathVariable String id) {
        log.debug("REST request to get Role : {}", id);
        return ResultBuilder.buildOk(service.findOneById(id)
                .map(item -> service.copyBeanToVo(item)));
    }

    @RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public String list() {
        return "modules/sys/roleList";
    }

    /**
     * @param pm
     * @return
     */
    @GetMapping(value = "/page")
    public ResponseEntity getPage(PageModel pm) {
        service.findPage(pm, SecurityUtil.dataScopeFilter(SecurityUtil.getCurrentUserId(), "org", "creator"));
        JSON rs = JsonUtil.getInstance().setRecurrenceStr("org_name").toJsonObject(pm);
        return ResultBuilder.buildObject(rs);
    }

    @GetMapping(value = "/edit")
    @Timed
    public String form(RoleVo roleVo) {
        return "modules/sys/roleForm";
    }


    /**
     * @param roleVo
     * @return
     */
    @PostMapping(value = "/edit", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity save(@Valid @RequestBody RoleVo roleVo) {
        log.debug("REST request to save RoleVo : {}", roleVo);
        // Lowercase the role login before comparing with database
        if (!checkByProperty(Reflections.createObj(RoleVo.class, Lists.newArrayList(RoleVo.F_ID, RoleVo.F_NAME),
                roleVo.getId(), roleVo.getName()))) {
            throw new RuntimeMsgException("名称已存在");
        }
        service.save(roleVo);
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("保存", roleVo.getName(), "成功");
    }

    /**
     * @param ids
     * @return
     */
    @PostMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
            + "}")
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
    @PostMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
            + "}")
    @Timed
    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock User: {}", ids);
        service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("操作成功");
    }

}
