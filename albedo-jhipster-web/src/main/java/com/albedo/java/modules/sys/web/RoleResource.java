package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.service.RoleService;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URISyntaxException;

/**
 * REST controller for managing Station.
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/role")
public class RoleResource extends DataResource<Role> {

	@Inject
	private RoleService roleService;

	@ModelAttribute
	public Role get(@RequestParam(required = false) String id) throws Exception {
		String path = request.getRequestURI();
		if (path != null && !path.contains("checkBy") && !path.contains("find") && PublicUtil.isNotEmpty(id)) {
			return roleService.findOne(id);
		} else {
			return new Role();
		}
	}

	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String list() {
		return "modules/sys/roleList";
	}

	/**
	 * GET / : get all role.
	 * 
	 * @param pageable
	 *            the pagination information
	 * @return the ResponseEntity with status 200 (OK) and with body all role
	 * @throws URISyntaxException
	 *             if the pagination headers couldn't be generated
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public void getPage(PageModel<Role> pm, HttpServletResponse response) {
		SpecificationDetail<Role> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(), SecurityUtil.dataScopeFilter(),
				QueryCondition.ne(Role.F_STATUS, Role.FLAG_DELETE));
		Page<Role> page = roleService.findAll(spec, pm);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().setRecurrenceStr("org_name").toJsonObject(pm);
		writeJsonHttpResponse(rs.toString(), response);
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String form(Role role, Model model) {
		return "modules/sys/roleForm";
	}

	/**
	 * POST / : Creates a new role.
	 * <p>
	 * Creates a new role if the login and email are not already used, and sends
	 * an mail with an activation link. The role needs to be activated on
	 * creation.
	 * </p>
	 *
	 * @param managedRoleVM
	 *            the role to create
	 * @param request
	 *            the HTTP request
	 * @return the ResponseEntity with status 201 (Created) and with body the
	 *         new role, or with status 400 (Bad Request) if the login or email
	 *         is already in use
	 * @throws URISyntaxException
	 *             if the Location URI syntax is incorrect
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void save(Role role, String confirmPassword, Model model, HttpServletRequest request, HttpServletResponse response)
			throws URISyntaxException {
		log.debug("REST request to save Role : {}", role);
		// Lowercase the role login before comparing with database
		if (!checkByProperty(Reflections.createObj(Role.class, Lists.newArrayList(Role.F_ID, Role.F_NAME), role.getId(),
				role.getName()))) {
			throw new RuntimeMsgException("名称已存在");
		}
		roleService.save(role);

		addAjaxMsg(MSG_TYPE_SUCCESS, PublicUtil.toAppendStr("保存", role.getName(), "成功"), response);
	}

	/**
	 * DELETE //:login : delete the "login" Role.
	 *
	 * @param login
	 *            the login of the role to delete
	 * @return the ResponseEntity with status 200 (OK)
	 */
	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void delete(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to delete Role: {}", ids);
		roleService.delete(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "删除成功", response);
	}

	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void lockOrUnLock(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to lockOrUnLock User: {}", ids);
		roleService.lockOrUnLock(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "操作成功", response);
	}

}
