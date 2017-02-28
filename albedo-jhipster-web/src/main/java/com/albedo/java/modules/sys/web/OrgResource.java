package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.modules.sys.domain.Org;
import com.albedo.java.modules.sys.service.OrgService;
import com.albedo.java.modules.sys.service.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
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
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * REST controller for managing Station.
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/org")
public class OrgResource extends DataResource<Org> {

	@Inject
	private OrgService orgService;

	@RequestMapping(value = "findTreeData", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public void findTreeData(@RequestParam(required = false) String extId,
			@RequestParam(required = false) String showType, @RequestParam(required = false) Long grade,
			@RequestParam(required = false) String all, HttpServletResponse response) {
		String rs = orgService.findTreeData(extId, showType, grade, all);
		writeJsonHttpResponse(rs, response);
	}

	@ModelAttribute
	public Org get(@RequestParam(required = false) String id) throws Exception {
		String path = request.getRequestURI();
		if (path != null && !path.contains("checkBy") && !path.contains("find") && PublicUtil.isNotEmpty(id)) {
			return orgService.findOne(id);
		} else {
			return new Org();
		}
	}

	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String list()  {
		return "modules/sys/orgList";
	}
	/**
	 * GET / : get all org.
	 * 
	 * @param pageable
	 *            the pagination information
	 * @return the ResponseEntity with status 200 (OK) and with body all org
	 * @
	 *             if the pagination headers couldn't be generated
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public void getPage(PageModel<Org> pm, HttpServletResponse response)  {
		SpecificationDetail<Org> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
				QueryCondition.ne(Org.F_STATUS, Org.FLAG_DELETE));
		pm.setSortDefaultName(Direction.DESC, DataEntity.F_LASTMODIFIEDDATE);
		Page<Org> page = orgService.findAll(spec, pm);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().toJsonObject(pm);
		writeJsonHttpResponse(rs.toString(), response);
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String form(Org org, Model model)  {
		if(org == null){
			throw new RuntimeMsgException(PublicUtil.toAppendStr("查询模块管理失败，原因：无法查找到编号区域"));
		}
		if (StringUtil.isBlank(org.getId())){
			List<Org> list = orgService.findAllByParentId(org.getParentId());
			if (list.size() > 0){
				org.setSort(list.get(list.size()-1).getSort());
				if (org.getSort() != null){
					org.setSort(org.getSort() + 30);
				}
			}
		}
		if(PublicUtil.isNotEmpty(org.getParentId())){
			org.setParent(orgService.findOne(org.getParentId()));
		}
		return "modules/sys/orgForm";
	}

	/**
	 * POST / : Creates a new org.
	 * <p>
	 * Creates a new org if the login and email are not already used, and sends
	 * an mail with an activation link. The org needs to be activated on
	 * creation.
	 * </p>
	 *
	 * @param managedOrgVM
	 *            the org to create
	 * @param request
	 *            the HTTP request
	 * @return the ResponseEntity with status 201 (Created) and with body the
	 *         new org, or with status 400 (Bad Request) if the login or email
	 *         is already in use
	 * @
	 *             if the Location URI syntax is incorrect
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void save(Org org, String confirmPassword, Model model, HttpServletRequest request, HttpServletResponse response)
			 {
		log.debug("REST request to save Org : {}", org);
		// Lowercase the org login before comparing with database
		if (!checkByProperty(Reflections.createObj(Org.class, Lists.newArrayList(Org.F_ID, Org.F_NAME),
				org.getId(), org.getName()))) {
			throw new RuntimeMsgException("名称已存在");
		}
		orgService.save(org);
		
		addAjaxMsg(MSG_TYPE_SUCCESS, PublicUtil.toAppendStr("保存", org.getName(), "成功"), response);
	}

	/**
	 * DELETE //:login : delete the "login" Org.
	 *
	 * @param login
	 *            the login of the org to delete
	 * @return the ResponseEntity with status 200 (OK)
	 */
	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void delete(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to delete Org: {}", ids);
		orgService.delete(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "删除成功", response);
	}
	
	
	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void lockOrUnLock(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to lockOrUnLock User: {}", ids);
		orgService.lockOrUnLock(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "操作成功", response);
	}
	
}
