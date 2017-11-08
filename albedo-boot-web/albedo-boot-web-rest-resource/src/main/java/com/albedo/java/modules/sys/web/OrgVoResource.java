package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.service.OrgService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.sys.OrgVo;
import com.albedo.java.vo.sys.query.AntdTreeResult;
import com.albedo.java.vo.sys.query.OrgTreeQuery;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.TreeVoResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;

/**
 * REST controller for managing Station.
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/org")
public class OrgVoResource extends TreeVoResource<OrgService, OrgVo> {

    @Resource
    private OrgService orgService;

    @GetMapping(value = "findTreeData")
    public ResponseEntity findTreeData(OrgTreeQuery orgTreeQuery) {
        List<AntdTreeResult> rs = orgService.findTreeDataRest(orgTreeQuery, SecurityUtil.getOrgList());
        return ResultBuilder.buildOk(rs);
    }
    @GetMapping(value = "/")
    @Timed
    public String list() {
        return "modules/sys/orgList";
    }

    /**
     * @param pm
     * @return
     */
    @GetMapping(value = "/page")
    public ResponseEntity getPage(PageModel pm) {
        pm.setSortDefaultName(Direction.DESC, DataEntity.F_LASTMODIFIEDDATE);
        orgService.findPage(pm, SecurityUtil.dataScopeFilter(
                SecurityUtil.getCurrentUserId(), "this", ""));
        JSON rs = JsonUtil.getInstance().toJsonObject(pm);
        return ResultBuilder.buildObject(rs);
    }
    /**
     * @param orgVo
     * @return
     */
    @PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity save(@Valid @RequestBody OrgVo orgVo) {
        log.debug("REST request to save orgVo : {}", orgVo);
        // Lowercase the org login before comparing with database
        if (!checkByProperty(Reflections.createObj(OrgVo.class, Lists.newArrayList(OrgVo.F_ID, OrgVo.F_NAME),
                orgVo.getId(), orgVo.getName()))) {
            throw new RuntimeMsgException("名称已存在");
        }
        orgService.save(orgVo);
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("保存", orgVo.getName(), "成功");
    }

    /**
     * @param ids
     * @return
     */
    @PostMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
            + "}")
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete Org: {}", ids);
        orgService.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
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
        orgService.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("操作成功");
    }

}
