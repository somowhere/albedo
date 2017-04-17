package com.albedo.java.modules.sys.web;

import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Area;
import com.albedo.java.util.StringUtil;
import com.albedo.java.vo.sys.query.AreaTreeQuery;
import com.albedo.java.modules.sys.service.AreaService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

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
	public ResponseEntity findTreeData(AreaTreeQuery areaTreeQuery) {
		List<Map<String, Object>> rs = areaService.findTreeData(areaTreeQuery, SecurityUtil.getAreaList());
		return ResultBuilder.buildOk(rs);
	}
	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String list() {
		return "modules/sys/areaList";
	}

	/**
	 *
	 * @param pm
	 * @return
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ResponseEntity getPage(PageModel<Area> pm) {
		areaService.findPage(pm, SecurityUtil.dataScopeFilter());
		JSON rs = JsonUtil.getInstance().setRecurrenceStr("creator_name").toJsonObject(pm);
		return ResultBuilder.buildObject(rs);
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String form(Area area) {
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
		
		return "modules/sys/areaForm";
	}

	/**
	 * 
	 * @param area
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public ResponseEntity save(Area area) {
		log.debug("REST request to save Area : {}", area);
		Area areaValidate = new Area(area.getId());
		areaValidate.setCode(area.getCode());
		if (PublicUtil.isNotEmpty(area.getCode()) && !checkByProperty(areaValidate)) {
			throw new RuntimeMsgException("保存区域管理'", area.getCode(),"'失败，区域编码已存在");
		}
		areaService.save(area);
		return ResultBuilder.buildOk("保存区域管理成功");
	}

	/**
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public ResponseEntity delete(@PathVariable String ids) {
		log.debug("REST request to delete Area: {}", ids);
		areaService.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)), SecurityUtil.getCurrentAuditor());
		return ResultBuilder.buildOk("删除区域管理成功");
	}

	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public ResponseEntity lockOrUnLock(@PathVariable String ids) {
		log.debug("REST request to lockOrUnLock Area: {}", ids);
		areaService.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)), SecurityUtil.getCurrentAuditor());
		return ResultBuilder.buildOk("操作区域管理成功");
	}

}