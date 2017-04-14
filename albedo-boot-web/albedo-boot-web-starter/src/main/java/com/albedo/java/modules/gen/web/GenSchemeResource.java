package com.albedo.java.modules.gen.web;

import com.albedo.java.common.config.template.tag.FormDirective;
import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
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
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.List;

/**
 * 生成方案Controller
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/gen/genScheme")
public class GenSchemeResource extends DataResource<GenScheme> {

	@Resource
	private GenSchemeService genSchemeService;

	@Resource
	private GenTableService genTableService;

	@Resource
	private ModuleService moduleService;

	@ModelAttribute
	public GenScheme get(@RequestParam(required = false) String id) {
		String path = request.getRequestURI();
		if (path != null && !path.contains("checkBy") && !path.contains("find") && StringUtil.isNotBlank(id)) {
			return genSchemeService.findOne(id);
		} else {
			return new GenScheme();
		}
	}
	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String list() {
		return "modules/gen/genSchemeList";
	}

	/**
	 *
	 * @param pm
	 * @return
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	@Timed
	public ResponseEntity getPage(PageModel<GenScheme> pm) {
		SpecificationDetail<GenScheme> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
				QueryCondition.ne(GenScheme.F_STATUS, GenScheme.FLAG_DELETE));
		Page<GenScheme> page = genSchemeService.findAll(spec, pm);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().setRecurrenceStr("genTable_name").toJsonObject(pm);
		return ResultBuilder.buildObject(rs);
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String form(GenScheme genScheme, Boolean isModal, Model model) {
		if (StringUtil.isBlank(genScheme.getPackageName())) {
			genScheme.setPackageName("com.albedo.java.modules");
		}
		 if (StringUtil.isBlank(genScheme.getFunctionAuthor())){
			 genScheme.setFunctionAuthor(SecurityUtil.getCurrentUser().getLoginId());
		 }
		genScheme.setSyncModule(true); // 同步模块数据
		model.addAttribute("genScheme", genScheme);
		GenConfig config = GenUtil.getConfig();
		model.addAttribute("config", config);
		
		model.addAttribute("categoryList",  FormDirective.convertComboDataList(config.getCategoryList(), Dict.F_VAL, Dict.F_NAME));
		model.addAttribute("viewTypeList",  FormDirective.convertComboDataList(config.getViewTypeList(), Dict.F_VAL, Dict.F_NAME));
		
		List<GenTable> tableList = genTableService.findAll(), list = Lists.newArrayList();
		List<GenScheme> schemeList = genSchemeService.findAll(genScheme.getId());
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

	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public ResponseEntity save(GenScheme genScheme, Model model, RedirectAttributes redirectAttributes) {
		genSchemeService.save(genScheme);
		SecurityUtil.clearUserJedisCache();
		if (genScheme.getSyncModule()) {
			GenTable genTable = genScheme.getGenTable();
			if (genTable == null || PublicUtil.isEmpty(genTable.getClassName()))
				genTable = genTableService.findOne(genScheme.getGenTable().getId());
			String url = PublicUtil.toAppendStr("/", StringUtil.lowerCase(genScheme.getModuleName()), (StringUtil.isNotBlank(genScheme.getSubModuleName()) ? "/" + StringUtil.lowerCase(genScheme.getSubModuleName()) : ""), "/",
					StringUtil.uncapitalize(genTable.getClassName()), "/");
			moduleService.generatorModuleData(genScheme.getName(), genScheme.getParentModuleId(), url);
			SecurityUtil.clearUserJedisCache();
		}
		// 生成代码
		if (genScheme.getGenCode()) {
			genSchemeService.generateCode(genScheme);
		}
		return ResultBuilder.buildOk("保存", genScheme.getName(), "成功");
	}

	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public ResponseEntity lockOrUnLock(@PathVariable String ids) {
		log.debug("REST request to lockOrUnLock genTable: {}", ids);
		genSchemeService.lockOrUnLock(ids, SecurityUtil.getCurrentAuditor());
		SecurityUtil.clearUserJedisCache();
		return ResultBuilder.buildOk("操作成功");
	}
	
	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	@Secured(AuthoritiesConstants.ADMIN)
	public ResponseEntity delete(@PathVariable String ids) {
		log.debug("REST request to delete User: {}", ids);
		genSchemeService.delete(ids, SecurityUtil.getCurrentAuditor());
		return ResultBuilder.buildOk("删除成功");
	}
	

}
