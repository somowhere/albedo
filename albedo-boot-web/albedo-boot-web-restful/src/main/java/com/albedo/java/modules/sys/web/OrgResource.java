package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Org;
import com.albedo.java.modules.sys.service.OrgService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.sys.OrgForm;
import com.albedo.java.vo.sys.query.OrgTreeQuery;
import com.albedo.java.vo.sys.query.AntdTreeResult;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * REST controller for managing Station.
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/org")
public class OrgResource extends DataResource<OrgService, Org> {

    @Resource
    private OrgService orgService;

    @GetMapping(value = "findTreeData")
    public ResponseEntity findTreeData(OrgTreeQuery orgTreeQuery) {
        List<AntdTreeResult> rs = orgService.findTreeDataRest(orgTreeQuery, SecurityUtil.getOrgList());
        return ResultBuilder.buildOk(rs);
    }

    /**
     * @param pm
     * @return
     */
    @GetMapping(value = "/")
    public ResponseEntity page(PageModel<Org> pm) {

        pm.setSortDefaultName(Direction.DESC, DataEntity.F_LASTMODIFIEDDATE);
        orgService.findPage(pm, SecurityUtil.dataScopeFilter(
                SecurityUtil.getCurrentUserId(), "this", ""));
        JSON rs = JsonUtil.getInstance().toJsonObject(pm);
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
     * @param org
     * @return
     */
    @PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity save(OrgForm orgForm) {
        log.debug("REST request to save orgForm : {}", orgForm);
        // Lowercase the org login before comparing with database
        if (!checkByProperty(Reflections.createObj(Org.class, Lists.newArrayList(Org.F_ID, Org.F_NAME),
                orgForm.getId(), orgForm.getName()))) {
            throw new RuntimeMsgException("名称已存在");
        }
        orgService.save(orgForm);
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("保存", orgForm.getName(), "成功");
    }

    /**
     * @param ids
     * @return
     */
    @PostMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
            + "}", produces = MediaType.APPLICATION_JSON_VALUE)
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
            + "}", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock User: {}", ids);
        orgService.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("操作成功");
    }

}
