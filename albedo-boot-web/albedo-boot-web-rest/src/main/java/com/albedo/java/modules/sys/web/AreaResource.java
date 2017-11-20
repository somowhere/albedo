package com.albedo.java.modules.sys.web;

import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.service.AreaService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.sys.AreaVo;
import com.albedo.java.vo.sys.query.AreaTreeQuery;
import com.albedo.java.vo.sys.query.TreeResult;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.TreeVoResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;


/**
 * 区域Controller 区域
 *
 * @author admin
 * @version 2017-11-10
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/sys/area")
public class AreaResource extends TreeVoResource<AreaService, AreaVo> {

    /**
     * GET / : 获取树型结构数据 区域.
     *
     * @param areaTreeQuery
     * @return the ResponseEntity with status 200 (OK) and with body all area
     */
    @GetMapping(value = "findTreeData")
    public ResponseEntity findTreeData(AreaTreeQuery areaTreeQuery) {
        List<TreeResult> treeResultList = service.findTreeData(areaTreeQuery, SecurityUtil.getAreaList());
        return ResultBuilder.buildOk(treeResultList);
    }

    /**
     * GET / : 获取分页界面 区域.
     */
    @GetMapping(value = "/")
    public String list() {
        return "modules/sys/areaList";
    }

    /**
     * GET / : 获取分页数据源 区域.
     *
     * @param pm the pagination information
     * @return the ResponseEntity with status 200 (OK) and with body all area
     */
    @GetMapping(value = "/page")
    @Timed
    public ResponseEntity getPage(PageModel pm) {
        service.findPage(pm, SecurityUtil.dataScopeFilter());
        JSON json = JsonUtil.getInstance().setRecurrenceStr().toJsonObject(pm);
        return ResultBuilder.buildObject(json);
    }

    /**
     * GET / : 保存 a 区域Vo 页.
     *
     * @param areaVo
     */
    @GetMapping(value = "/edit")
    @Timed
    public String form(AreaVo areaVo) {
        if (areaVo == null) {
            throw new RuntimeMsgException(PublicUtil.toAppendStr("查询模块管理失败，原因：无法查找到编号区域"));
        }
        if (PublicUtil.isNotEmpty(areaVo.getParentId())) {
            service.findOptionalTopByParentId(areaVo.getParentId()).ifPresent(item -> areaVo.setSort(item.getSort() + 30));
            service.findOneById(areaVo.getParentId()).ifPresent(item -> areaVo.setParentName(item.getName()));
        }
        if (areaVo.getSort() == null) {
            areaVo.setSort(30);
        }
        return "modules/sys/areaForm";
    }

    /**
     * POST / : 保存 a 区域Vo.
     *
     * @param {className}Vo
     */
    @PostMapping(value = "/edit", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity save(@Valid @RequestBody AreaVo areaVo) {
        log.debug("REST request to save Area : {}", areaVo);
        service.save(areaVo);
        return ResultBuilder.buildOk("保存区域成功");
    }

    /**
     * DELETE //:id : delete the "id" Area.
     *
     * @param ids the id of the area to delete
     * @return the ResponseEntity with status 200 (OK)
     */
    @PostMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
            + "}", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete Area: {}", ids);
        service.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        return ResultBuilder.buildOk("删除区域成功");
    }

    /**
     * lock //:id : lockOrUnLock the "id" Area.
     *
     * @param ids the id of the area to lock
     * @return the ResponseEntity with status 200 (OK)
     */
    @PostMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
            + "}", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock Area: {}", ids);
        service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        return ResultBuilder.buildOk("操作区域成功");
    }

}