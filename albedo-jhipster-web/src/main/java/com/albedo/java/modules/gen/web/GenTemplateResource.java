package com.albedo.java.modules.gen.web;

import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.service.GenTemplateService;
import com.albedo.java.modules.sys.service.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URISyntaxException;

/**
 * 代码模板Controller
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/gen/genTemplate")
public class GenTemplateResource extends DataResource<GenTable> {

	@Resource
	private GenTemplateService genTemplateService;

	@ModelAttribute
	public GenTable get(@RequestParam(required = false) String id) throws Exception {
		String path = request.getRequestURI();
		if (path != null && !path.contains("checkBy") && !path.contains("find") && PublicUtil.isNotEmpty(id)) {
			return genTemplateService.findOne(id);
		} else {
			return new GenTable();
		}
	}

	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String list() throws URISyntaxException {
		return "modules/sys/genTableList";
	}

	/**
	 * GET / : get all genTable.
	 * 
	 * @param pageable
	 *            the pagination information
	 * @return the ResponseEntity with status 200 (OK) and with body all genTable
	 * @throws URISyntaxException
	 *             if the pagination headers couldn't be generated
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public void getPage(PageModel<GenTable> pm, HttpServletResponse response) throws URISyntaxException {
		SpecificationDetail<GenTable> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
				QueryCondition.ne(GenTable.F_STATUS, GenTable.FLAG_DELETE));
		Page<GenTable> page = genTemplateService.findAll(spec, pm);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().setRecurrenceStr("org_name").toJsonObject(pm);
		writeJsonHttpResponse(rs.toString(), response);
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String form(GenTable genTable, Model model) throws URISyntaxException {
		return "modules/sys/genTableForm";
	}

	/**
	 * POST / : Creates a new genTable.
	 * <p>
	 * Creates a new genTable if the login and email are not already used, and sends
	 * an mail with an activation link. The genTable needs to be activated on
	 * creation.
	 * </p>
	 *
	 * @param managedGenTableVM
	 *            the genTable to create
	 * @param request
	 *            the HTTP request
	 * @return the ResponseEntity with status 201 (Created) and with body the
	 *         new genTable, or with status 400 (Bad Request) if the login or email
	 *         is already in use
	 * @throws URISyntaxException
	 *             if the Location URI syntax is incorrect
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void save(GenTable genTable, String confirmPassword, Model model, HttpServletRequest request, HttpServletResponse response)
			throws URISyntaxException {
		log.debug("REST request to save GenTable : {}", genTable);
		// Lowercase the genTable login before comparing with database
		if (!checkByProperty(Reflections.createObj(GenTable.class, Lists.newArrayList(GenTable.F_ID, GenTable.F_NAME), genTable.getId(),
				genTable.getName()))) {
			throw new RuntimeMsgException("名称已存在");
		}
		genTemplateService.save(genTable);

		addAjaxMsg(MSG_TYPE_SUCCESS, PublicUtil.toAppendStr("保存", genTable.getName(), "成功"), response);
	}

	/**
	 * DELETE //:login : delete the "login" GenTable.
	 *
	 * @param login
	 *            the login of the genTable to delete
	 * @return the ResponseEntity with status 200 (OK)
	 */
	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void delete(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to delete GenTable: {}", ids);
		genTemplateService.delete(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "删除成功", response);
	}

	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	@Secured(AuthoritiesConstants.ADMIN)
	public void lockOrUnLock(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to lockOrUnLock User: {}", ids);
		genTemplateService.lockOrUnLock(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "操作成功", response);
	}

}
