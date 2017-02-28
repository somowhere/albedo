package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.DictService;
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

/**
 * REST controller for managing Station.
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/dict")
public class DictResource extends DataResource<Dict> {

	@Inject
	private DictService dictService;

	
	@ModelAttribute
	public Dict get(@RequestParam(required = false) String id) throws Exception {
		String path = request.getRequestURI();
		if (path != null && !path.contains("checkBy") && !path.contains("find") && PublicUtil.isNotEmpty(id)) {
			return dictService.findOne(id);
		} else {
			return new Dict();
		}
	}
	
	@RequestMapping(value = "findTreeData", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public void findTreeData(@RequestParam(required = false) String type,
			@RequestParam(required = false) String all, HttpServletResponse response) {
		String rs = dictService.findTreeData(type, all);
		writeJsonHttpResponse(rs, response);
	}
	

	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String list() throws URISyntaxException {
		return "modules/sys/dictList";
	}
	/**
	 * GET / : get all dict.
	 * 
	 * @param pageable
	 *            the pagination information
	 * @return the ResponseEntity with status 200 (OK) and with body all dict
	 * @throws URISyntaxException
	 *             if the pagination headers couldn't be generated
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public void getPage(PageModel<Dict> pm, HttpServletResponse response) throws URISyntaxException {
		SpecificationDetail<Dict> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
				QueryCondition.ne(Dict.F_STATUS, Dict.FLAG_DELETE));
		pm.setSortDefaultName(Direction.DESC, Dict.F_SORT, Dict.F_LASTMODIFIEDDATE);
		Page<Dict> page = dictService.findAll(spec, pm);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().setRecurrenceStr("parent_name").toJsonObject(pm);
		writeJsonHttpResponse(rs.toString(), response);
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String form(Dict dict, Model model) throws URISyntaxException {
		if(dict==null){
			throw new RuntimeMsgException("无法获取字典数据");
		}
		if (StringUtil.isBlank(dict.getId())){
			Dict item = dictService.findFristByParentId(dict.getParentId());
			if (item!=null){
				dict.setSort(dict.getSort() + item.getSort() + 30);
			}
		}
		if (dict.getSort() == null){
			dict.setSort(30);
		}
		if(PublicUtil.isNotEmpty(dict.getParentId())){
			dict.setParent(dictService.findOne(dict.getParentId()));
		}
		model.addAttribute("dict", dict);
		return "modules/sys/dictForm";
	}

	/**
	 * POST / : Creates a new dict.
	 * <p>
	 * Creates a new dict if the login and email are not already used, and sends
	 * an mail with an activation link. The dict needs to be activated on
	 * creation.
	 * </p>
	 *
	 * @param managedDictVM
	 *            the dict to create
	 * @param request
	 *            the HTTP request
	 * @return the ResponseEntity with status 201 (Created) and with body the
	 *         new dict, or with status 400 (Bad Request) if the login or email
	 *         is already in use
	 * @throws URISyntaxException
	 *             if the Location URI syntax is incorrect
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void save(Dict dict, String confirmPassword, Model model, HttpServletRequest request, HttpServletResponse response)
			throws URISyntaxException {
		log.debug("REST request to save Dict : {}", dict);
		// Lowercase the dict login before comparing with database
		if (!checkByProperty(Reflections.createObj(Dict.class, Lists.newArrayList(Dict.F_ID, Dict.F_CODE),
				dict.getId(), dict.getName()))) {
			throw new RuntimeMsgException("编码已存在");
		}
		dictService.save(dict);
		
		addAjaxMsg(MSG_TYPE_SUCCESS, PublicUtil.toAppendStr("保存", dict.getName(), "成功"), response);
	}

	/**
	 * DELETE //:login : delete the "login" Dict.
	 *
	 * @param login
	 *            the login of the dict to delete
	 * @return the ResponseEntity with status 200 (OK)
	 */
	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void delete(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to delete Dict: {}", ids);
		dictService.delete(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "删除成功", response);
	}
	
	
	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	@Secured(AuthoritiesConstants.ADMIN)
	public void lockOrUnLock(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to lockOrUnLock User: {}", ids);
		dictService.lockOrUnLock(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "操作成功", response);
	}
	
}
