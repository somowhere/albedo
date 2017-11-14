package com.albedo.java.modules.gen.web;

import com.albedo.java.common.config.template.tag.FormDirective;
import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.service.GenTableService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.gen.GenTableVo;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataVoResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;

/**
 * 业务表Controller
 *
 * @author somewhere
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/gen/genTable")
public class GenTableResource extends DataVoResource<GenTableService, GenTableVo> {

    @GetMapping(value = "/")
    @Timed
    public String list(Model model) {
        model.addAttribute("tableList", FormDirective.convertComboDataList(service.findTableListFormDb(null), GenTable.F_NAME, GenTable.F_NAMESANDCOMMENTS));
        return "modules/gen/genTableList";
    }

    /**
     * @param pm
     * @return
     */
    @GetMapping(value = "/page")
    @Timed
    public ResponseEntity getPage(PageModel<GenTable> pm) {

        pm = service.findPage(pm, SecurityUtil.dataScopeFilterSql("d", "a"));
        JSON rs = JsonUtil.getInstance().setRecurrenceStr("org_name").toJsonObject(pm);
        return ResultBuilder.buildObject(rs);
    }

    @GetMapping(value = "/edit")
    public String form(GenTableVo genTableVo, Model model) {
        Map<String, Object> map = service.findFormData(genTableVo);
        model.addAllAttributes(map);
        return "modules/gen/genTableForm";
    }

    @PostMapping(value = "/edit", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity save(@Valid @RequestBody GenTableVo genTableVo) {
        // 验证表是否已经存在
        if (StringUtil.isBlank(genTableVo.getId()) && !service.checkTableName(genTableVo.getName())) {
            throw new RuntimeMsgException("保存失败！" + genTableVo.getName() + " 表已经存在！");
        }
        service.save(genTableVo);
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk(PublicUtil.toAppendStr("保存", genTableVo.getName(), "成功"));
    }

    @PostMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX + "}")
    @Timed
    @Secured(AuthoritiesConstants.ADMIN)
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete genTable: {}", ids);
        service.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)), SecurityUtil.getCurrentUserId());
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("删除成功");
    }

    @PostMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX + "}")
    @Timed
    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock genTable: {}", ids);
        service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("操作成功");
    }

}
