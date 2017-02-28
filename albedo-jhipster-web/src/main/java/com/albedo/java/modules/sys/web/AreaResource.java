package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Area;
import com.albedo.java.modules.sys.service.AreaService;
import com.albedo.java.modules.sys.service.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URISyntaxException;

/**
 * 区域管理Controller 区域管理
 * @author admin
 * @version 2017-01-05
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/sys/area")
public class AreaResource extends DataResource<Area> {

	@Resource
	private AreaService areaService;
	
	@ModelAttribute
	public Area get(@RequestParam(required = false) String id) throws Exception {
		String path = request.getRequestURI();
		if (path!=null && !path.contains("checkBy") && !path.contains("find") && PublicUtil.isNotEmpty(id)) {
			return areaService.findOne(id);
		} else {
			return new Area();
		}
	}
	@RequestMapping(value = "findTreeData", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public void findTreeData(@RequestParam(required=false) String all,
			@RequestParam(required=false) String parentId, @RequestParam(required=false) String extId,
			@RequestParam(required=false) Integer ltLevel, @RequestParam(required=false) Integer level, HttpServletResponse response) {
		String rs = areaService.findTreeData( extId, all, parentId, ltLevel, level);
		writeJsonHttpResponse(rs, response);
	}
	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String list() {
		return "modules/sys/areaList";
	}

	/**
	 * GET / : get all area.
	 * 
	 * @param pageable
	 *            the pagination information
	 * @return the ResponseEntity with status 200 (OK) and with body all area
	 * @throws URISyntaxException
	 *             if the pagination headers couldn't be generated
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public void getPage(PageModel<Area> pm, HttpServletResponse response) {
		SpecificationDetail<Area> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(), SecurityUtil.dataScopeFilter(),
				QueryCondition.ne(Area.F_STATUS, Area.FLAG_DELETE));
		Page<Area> page = areaService.findAll(spec, pm);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().setRecurrenceStr("creator_name").toJsonObject(pm);
		writeJsonHttpResponse(rs.toString(), response);
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String form(Area area, Model model) {
		if(area==null){
			throw new RuntimeMsgException("无法获取区域管理数据");
		}
		if (PublicUtil.isNotEmpty(area.getId())){
			Area item = areaService.findTopByParentId(area.getParentId());
			if (item!=null){
				area.setSort(area.getSort() + item.getSort());
			}
		}
		if (area.getSort() == null){
			area.setSort(30);
		}
		if(PublicUtil.isNotEmpty(area.getParentId())){
			area.setParent(areaService.findOne(area.getParentId()));
		}
		model.addAttribute("area", area);
		
		return "modules/sys/areaForm";
	}

	/**
	 * POST / : Save a area.
	 *
	 * @param request the HTTP request
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void save(Area area, Model model, HttpServletRequest request, HttpServletResponse response) {
		log.debug("REST request to save Area : {}", area);
		Area areaValidate = new Area(area.getId());
		areaValidate.setCode(area.getCode());
		if (PublicUtil.isNotEmpty(area.getCode()) && !checkByProperty(areaValidate)) {
			throw new RuntimeMsgException(PublicUtil.toAppendStr("保存区域管理'", area.getCode(),"'失败，区域编码已存在"));
		}
		areaService.save(area);

		addAjaxMsg(MSG_TYPE_SUCCESS, PublicUtil.toAppendStr("保存区域管理成功"), response);
	}

	/**
	 * DELETE //:login : delete the "login" Area.
	 *
	 * @param login
	 *            the login of the area to delete
	 * @return the ResponseEntity with status 200 (OK)
	 */
	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void delete(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to delete Area: {}", ids);
		areaService.delete(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "删除区域管理成功", response);
	}

	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void lockOrUnLock(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to lockOrUnLock Area: {}", ids);
		areaService.lockOrUnLock(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "操作区域管理成功", response);
	}

}