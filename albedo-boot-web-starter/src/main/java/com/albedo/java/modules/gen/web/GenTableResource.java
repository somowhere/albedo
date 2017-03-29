package com.albedo.java.modules.gen.web;

import com.albedo.java.common.config.template.tag.FormDirective;
import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.service.GenTableService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.Map;

/**
 * 业务表Controller
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/gen/genTable")
public class GenTableResource extends DataResource<GenTable> {

	@Resource
	private GenTableService genTableService;

	@ModelAttribute
	public GenTable get(@RequestParam(required = false) String id) {
		String path = request.getRequestURI();
		if (path != null && !path.contains("checkBy") && !path.contains("find") && StringUtil.isNotBlank(id)) {
			return genTableService.findOne(id);
		} else {
			return new GenTable();
		}
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	@Timed
	public String list(Model model) {
		model.addAttribute("tableList",  FormDirective.convertComboDataList(genTableService.findTableListFormDb(new GenTable()), GenTable.F_NAME, GenTable.F_NAMESANDCOMMENTS));
		return "modules/gen/genTableList";
	}

	/**
	 *
	 * @param pm
	 * @return
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	@Timed
	public ResponseEntity getPage(PageModel<GenTable> pm) {
		SpecificationDetail<GenTable> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
				QueryCondition.ne(GenTable.F_STATUS, GenTable.FLAG_DELETE));
		Page<GenTable> page = genTableService.findAll(spec, pm);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().setRecurrenceStr("org_name").toJsonObject(pm);
		return ResultBuilder.buildObject(rs);
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public String form(GenTable genTable, Model model) {
		Map<String, Object> map = genTableService.findFormData(genTable);
			model.addAllAttributes(map);
		return "modules/gen/genTableForm";
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity save(GenTable genTable, Model model, RedirectAttributes redirectAttributes) {
		// 验证表是否已经存在
		if (StringUtil.isBlank(genTable.getId()) && !genTableService.checkTableName(genTable.getName())) {
			throw new RuntimeMsgException("保存失败！" + genTable.getName() + " 表已经存在！");
		}
		genTableService.save(genTable);
		return ResultBuilder.buildOk(PublicUtil.toAppendStr("保存", genTable.getName(), "成功"));
	}

	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	@Secured(AuthoritiesConstants.ADMIN)
	public ResponseEntity delete(@PathVariable String ids) {
		log.debug("REST request to delete genTable: {}", ids);
		genTableService.delete(ids);
		return ResultBuilder.buildOk("删除成功");
	}
	
	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public ResponseEntity lockOrUnLock(@PathVariable String ids) {
		log.debug("REST request to lockOrUnLock genTable: {}", ids);
		genTableService.lockOrUnLock(ids);
		return ResultBuilder.buildOk("操作成功");
	}

}
