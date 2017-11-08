package com.albedo.java.modules.gen.web;

import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.service.GenTemplateService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import java.net.URISyntaxException;

/**
 * 代码模板Controller
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/gen/genTemplate")
public class GenTemplateResource extends DataResource<GenTemplateService, GenTable> {

    @Resource
    private GenTemplateService genTemplateService;


    @RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public String list() {
        return "modules/sys/genTableList";
    }

    /**
     * @param pm
     * @return
     */
    @RequestMapping(value = "/page", method = RequestMethod.GET)
    public ResponseEntity getPage(PageModel<GenTable> pm) {

        genTemplateService.findPage(pm);
        JSON rs = JsonUtil.getInstance().setRecurrenceStr("org_name").toJsonObject(pm);
        return ResultBuilder.buildObject(rs);
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public String form(GenTable genTable, Model model) {
        return "modules/sys/genTableForm";
    }

    /**
     * @param genTable
     * @return
     * @throws URISyntaxException
     */
    @RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity save(GenTable genTable)
            throws URISyntaxException {
        log.debug("REST request to save GenTableVo : {}", genTable);
        // Lowercase the genTable login before comparing with database
        if (!checkByProperty(Reflections.createObj(GenTable.class, Lists.newArrayList(GenTable.F_ID, GenTable.F_NAME), genTable.getId(),
                genTable.getName()))) {
            throw new RuntimeMsgException("名称已存在");
        }
        genTemplateService.save(genTable);
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("保存", genTable.getName(), "成功");
    }

    /**
     * @param ids
     * @return
     */
    @RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
            + "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete GenTableVo: {}", ids);
        genTemplateService.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("删除成功");
    }

    @RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
            + "}", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    @Secured(AuthoritiesConstants.ADMIN)
    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock User: {}", ids);
        genTemplateService.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("操作成功");
    }

}
