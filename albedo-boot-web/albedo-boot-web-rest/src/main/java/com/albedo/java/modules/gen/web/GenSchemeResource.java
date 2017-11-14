package com.albedo.java.modules.gen.web;

import com.albedo.java.common.config.template.tag.FormDirective;
import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.gen.domain.GenScheme;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.service.GenSchemeService;
import com.albedo.java.modules.gen.service.GenTableService;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.ModuleService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Collections3;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.vo.gen.GenSchemeVo;
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

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;

/**
 * 生成方案Controller
 *
 * @author somewhere
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/gen/genScheme")
public class GenSchemeResource extends DataVoResource<GenSchemeService, GenSchemeVo> {

    @Resource
    private GenSchemeService genSchemeService;

    @Resource
    private GenTableService genTableService;

    @Resource
    private ModuleService moduleService;

    @GetMapping(value = "/")
    @Timed
    public String list() {
        return "modules/gen/genSchemeList";
    }

    /**
     * @param pm
     * @return
     */
    @GetMapping(value = "/page")
    @Timed
    public ResponseEntity getPage(PageModel pm) {
        genSchemeService.findPage(pm);
        JSON rs = JsonUtil.getInstance().setRecurrenceStr("genTable_name").toJsonObject(pm);
        return ResultBuilder.buildObject(rs);
    }

    @GetMapping(value = "/edit")
    @Timed
    public String form(GenSchemeVo genSchemeVo, Boolean isModal, Model model) {
        if (StringUtil.isBlank(genSchemeVo.getPackageName())) {
            genSchemeVo.setPackageName("com.albedo.java.modules");
        }
        if (StringUtil.isBlank(genSchemeVo.getFunctionAuthor())) {
            genSchemeVo.setFunctionAuthor(SecurityUtil.getCurrentUser().getLoginId());
        }
        //同步模块数据
        genSchemeVo.setSyncModule(true);
        model.addAttribute("genSchemeVo", genSchemeVo);
        GenConfig config = GenUtil.getConfig();
        model.addAttribute("config", config);

        model.addAttribute("categoryList", FormDirective.convertComboDataList(config.getCategoryList(), Dict.F_VAL, Dict.F_NAME));
        model.addAttribute("viewTypeList", FormDirective.convertComboDataList(config.getViewTypeList(), Dict.F_VAL, Dict.F_NAME));

        List<GenTable> tableList = genTableService.findAll(), list = Lists.newArrayList();
        List<GenScheme> schemeList = genSchemeService.findAll(genSchemeVo.getId());
        @SuppressWarnings("unchecked")
        List<String> tableIds = Collections3.extractToList(schemeList, "genTableId");
        for (GenTable table : tableList) {
            if (!tableIds.contains(table.getId())) {
                list.add(table);
            }
        }
        model.addAttribute("tableList", FormDirective.convertComboDataList(list, GenTable.F_ID, GenTable.F_NAMESANDCOMMENTS));
        return PublicUtil.toAppendStr("modules/gen/genSchemeForm", isModal ? "Modal" : "");
    }

    @PostMapping(value = "/edit", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity save(@Valid @RequestBody GenSchemeVo genSchemeVo) {
        genSchemeService.save(genSchemeVo);
        SecurityUtil.clearUserJedisCache();
        if (genSchemeVo.getSyncModule()) {
            GenTableVo genTableVo = genSchemeVo.getGenTable();
            if (genTableVo == null || PublicUtil.isEmpty(genTableVo.getClassName())) {
                genTableVo = genTableService.findOneVo(genSchemeVo.getGenTableId());
            }
            String url = PublicUtil.toAppendStr("/", StringUtil.lowerCase(genSchemeVo.getModuleName()), (StringUtil.isNotBlank(genSchemeVo.getSubModuleName()) ? "/" + StringUtil.lowerCase(genSchemeVo.getSubModuleName()) : ""), "/",
                    StringUtil.uncapitalize(genTableVo.getClassName()), "/");
            moduleService.generatorModuleData(genSchemeVo.getName(), genSchemeVo.getParentModuleId(), url);
            SecurityUtil.clearUserJedisCache();
        }
        // 生成代码
        if (genSchemeVo.getGenCode()) {
            genSchemeService.generateCode(genSchemeVo);
        }
        return ResultBuilder.buildOk("保存", genSchemeVo.getName(), "成功");
    }

    @PostMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
            + "}")
    @Timed
    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock genTable: {}", ids);
        genSchemeService.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        SecurityUtil.clearUserJedisCache();
        return ResultBuilder.buildOk("操作成功");
    }

    @PostMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
            + "}")
    @Timed
    @Secured(AuthoritiesConstants.ADMIN)
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete User: {}", ids);
        genSchemeService.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        return ResultBuilder.buildOk("删除成功");
    }


}
