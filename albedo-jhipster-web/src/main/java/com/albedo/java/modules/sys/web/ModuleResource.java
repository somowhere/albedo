package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.modules.sys.domain.Module;
import com.albedo.java.modules.sys.service.ModuleService;
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
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URISyntaxException;
import java.util.List;

/**
 * REST controller for managing Station.
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/module")
public class ModuleResource extends DataResource<Module> {

	@Inject
	private ModuleService moduleService;

	@ModelAttribute
	public Module get(@RequestParam(required = false) String id) throws Exception {
		String path = request.getRequestURI();
		if (path != null && !path.contains("checkBy") && !path.contains("find") && PublicUtil.isNotEmpty(id)) {
			return moduleService.findOne(id);
		} else {
			return new Module();
		}
	}
	
	@RequestMapping(value = "findTreeData", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public void findTreeData(@RequestParam(required = false) String type,@RequestParam(required = false) String all, HttpServletResponse response) {
		String rs = moduleService.findTreeData(type, all);
		writeJsonHttpResponse(rs, response);
	}
	

	@RequestMapping(value = "/ico", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public String ico() {
		return "modules/sys/moduleIco";
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String list() {
		return "modules/sys/moduleList";
	}
	/**
	 * GET / : get all module.
	 * 
	 * @param pm
	 *            the pagination information
	 * @return the ResponseEntity with status 200 (OK) and with body all module
	 * @throws URISyntaxException
	 *             if the pagination headers couldn't be generated
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public void getPage(@RequestBody PageModel<Module> pm, HttpServletResponse response) {
		SpecificationDetail<Module> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
				QueryCondition.ne(Module.F_STATUS, Module.FLAG_DELETE));
		Page<Module> page = moduleService.findAll(spec, pm);
		pm.setSortDefaultName(Direction.DESC, DataEntity.F_LASTMODIFIEDDATE);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().toJsonObject(pm);
		writeJsonHttpResponse(rs.toString(), response);
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String form(Module module, Model model) {
		if(module == null){
			throw new RuntimeMsgException(PublicUtil.toAppendStr("查询模块管理失败，原因：无法查找到编号区域"));
		}
		if (StringUtil.isBlank(module.getId())){
			List<Module> list = moduleService.findAllByParentId(module.getParentId());
			if (list.size() > 0){
				module.setSort(list.get(list.size()-1).getSort());
				if (module.getSort() != null){
					module.setSort(module.getSort() + 30);
				}
			}
		}
		if(PublicUtil.isNotEmpty(module.getParentId())){
			module.setParent(moduleService.findOne(module.getParentId()));
		}
		return "modules/sys/moduleForm";
	}

	/**
	 *
	 * @param module
	 * @param confirmPassword
	 * @param model
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void save(Module module, String confirmPassword, Model model, HttpServletRequest request, HttpServletResponse response)
			{
		log.debug("REST request to save Module : {}", module);
		// Lowercase the module login before comparing with database
		if (PublicUtil.isNotEmpty(module.getPermission()) && !checkByProperty(Reflections.createObj(Module.class, Lists.newArrayList(Module.F_ID, Module.F_PERMISSION),
				module.getId(), module.getPermission()))) {
			throw new RuntimeMsgException("权限已存在");
		}
		moduleService.save(module);
		
		addAjaxMsg(MSG_TYPE_SUCCESS, PublicUtil.toAppendStr("保存", module.getName(), "成功"), response);
	}

	/**
	 * DELETE //:login : delete the "login" Module.
	 *
	 * @param login
	 *            the login of the module to delete
	 * @return the ResponseEntity with status 200 (OK)
	 */
	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void delete(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to delete Module: {}", ids);
		moduleService.delete(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "删除成功", response);
	}
	
	
	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	@Secured(AuthoritiesConstants.ADMIN)
	public void lockOrUnLock(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to lockOrUnLock User: {}", ids);
		moduleService.lockOrUnLock(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "操作成功", response);
	}
	
}
