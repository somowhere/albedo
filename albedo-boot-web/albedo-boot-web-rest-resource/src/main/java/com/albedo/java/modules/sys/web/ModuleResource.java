package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.service.ModuleService;
import com.albedo.java.util.JedisUtil;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.GlobalJedis;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.sys.ModuleVo;
import com.albedo.java.vo.sys.query.ModuleMenuTreeResult;
import com.albedo.java.vo.sys.query.ModuleTreeQuery;
import com.albedo.java.vo.sys.query.TreeResult;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.TreeVoResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;

/**
 * REST controller for managing Station.
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/module")
public class ModuleResource extends TreeVoResource<ModuleService, ModuleVo> {

    @Resource
    private ModuleService moduleService;

    @GetMapping(value = "findMenuData")
    public ResponseEntity findMenuData(ModuleTreeQuery moduleTreeQuery) {
        List<ModuleMenuTreeResult> rs = moduleService.findMenuData(moduleTreeQuery, SecurityUtil.getModuleList());
        return ResultBuilder.buildOk(rs);
    }

    @GetMapping(value = "findTreeData")
    public ResponseEntity findTreeData(ModuleTreeQuery moduleTreeQuery) {
        List<TreeResult> rs = moduleService.findTreeData(moduleTreeQuery, SecurityUtil.getModuleList());
        return ResultBuilder.buildOk(rs);
    }

    @GetMapping(value = "/ico")
    public String ico() {
        return "modules/sys/moduleIco";
    }

    @GetMapping(value = "/")
    public String list() {
        return "modules/sys/moduleList";
    }

    /**
     * @param pm
     * @return
     */
    @GetMapping(value = "/page")
    public ResponseEntity getPage(PageModel pm) {
        moduleService.findPage(pm, SecurityUtil.dataScopeFilter());
        pm.setSortDefaultName(Direction.DESC, DataEntity.F_LASTMODIFIEDDATE);
        JSON rs = JsonUtil.getInstance().toJsonObject(pm);
        return ResultBuilder.buildObject(rs);
    }

    @GetMapping(value = "/edit")
    @Timed
    public String form(ModuleVo moduleVo) {
        if (moduleVo == null) {
            throw new RuntimeMsgException(PublicUtil.toAppendStr("查询模块管理失败，原因：无法查找到编号区域"));
        }
        if (PublicUtil.isNotEmpty(moduleVo.getParentId())) {
            moduleService.findOneById(moduleVo.getParentId()).ifPresent(item -> moduleVo.setParentName(item.getName()));
            moduleService.findOptionalTopByParentId(moduleVo.getParentId()).ifPresent(item -> moduleVo.setSort(item.getSort() + 30));
        }
        if (moduleVo.getSort() == null) {
            moduleVo.setSort(30);
        }

        return "modules/sys/moduleForm";
    }

    /**
     * @param moduleVo
     * @return
     */
    @PostMapping(value = "/edit", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity save(@Valid @RequestBody ModuleVo moduleVo) {
        log.debug("REST request to save ModuleVo : {}", moduleVo);
        // Lowercase the module login before comparing with database
        if (PublicUtil.isNotEmpty(moduleVo.getPermission()) && !checkByProperty(Reflections.createObj(ModuleVo.class,
                Lists.newArrayList(ModuleVo.F_ID, ModuleVo.F_PERMISSION),
                moduleVo.getId(), moduleVo.getPermission()))) {
            throw new RuntimeMsgException("权限已存在");
        }
        moduleService.save(moduleVo);
        SecurityUtil.clearUserJedisCache();
        JedisUtil.removeSys(GlobalJedis.RESOURCE_MODULE_DATA_MAP);
        return ResultBuilder.buildOk("保存", moduleVo.getName(), "成功");
    }

    /**
     * @param ids
     * @return
     */
    @PostMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
            + "}")
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete Module: {}", ids);
        moduleService.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        JedisUtil.removeSys(GlobalJedis.RESOURCE_MODULE_DATA_MAP);
        return ResultBuilder.buildOk("删除成功");
    }

    /**
     * @param ids
     * @return
     */
    @PostMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
            + "}")
    @Timed
    @Secured(AuthoritiesConstants.ADMIN)
    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock User: {}", ids);
        moduleService.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        JedisUtil.removeSys(GlobalJedis.RESOURCE_MODULE_DATA_MAP);
        return ResultBuilder.buildOk("操作成功");
    }

}
