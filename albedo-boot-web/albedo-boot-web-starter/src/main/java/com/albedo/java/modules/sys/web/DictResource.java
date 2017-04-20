package com.albedo.java.modules.sys.web;

import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.util.DictUtil;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.sys.query.DictTreeQuery;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Map;

/**
 * REST controller for managing Station.
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/dict")
public class DictResource extends DataResource<DictService, Dict> {

	@Resource
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
	public ResponseEntity findTreeData(DictTreeQuery dictTreeQuery) {
		List<Map<String, Object>> rs = dictService.findTreeData(dictTreeQuery,DictUtil.getDictList());
		return ResultBuilder.buildOk(rs);
	}
	

	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String list() {
		return "modules/sys/dictList";
	}

	/**
	 *
	 * @param pm
	 * @return
	 * @throws URISyntaxException
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ResponseEntity getPage(PageModel<Dict> pm) {

		pm.setSortDefaultName(Direction.DESC, Dict.F_SORT, Dict.F_LASTMODIFIEDDATE);
		dictService.findPage(pm);
		JSON rs = JsonUtil.getInstance().setRecurrenceStr("parent_name").toJsonObject(pm);
		return ResultBuilder.buildObject(rs);
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String form(Dict dict) {
		if(dict==null){
			throw new RuntimeMsgException("无法获取字典数据");
		}
		if (StringUtil.isBlank(dict.getId())){
			Dict item = dictService.findTopByParentId(dict.getParentId());
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
		return "modules/sys/dictForm";
	}

	/**
	 * 
	 * @param dict
	 * @return
	 * @throws URISyntaxException
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public ResponseEntity save(Dict dict)
			throws URISyntaxException {
		log.debug("REST request to save Dict : {}", dict);
		// Lowercase the dict login before comparing with database
		if (!checkByProperty(Reflections.createObj(Dict.class, Lists.newArrayList(Dict.F_ID, Dict.F_CODE),
				dict.getId(), dict.getName()))) {
			throw new RuntimeMsgException("编码已存在");
		}
		dictService.save(dict);
		DictUtil.clearCache();
		return ResultBuilder.buildOk("保存", dict.getName(), "成功");
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
		log.debug("REST request to delete Dict: {}", ids);
		dictService.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		DictUtil.clearCache();
		return ResultBuilder.buildOk("删除成功");
	}
	
	
	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	@Secured(AuthoritiesConstants.ADMIN)
	public ResponseEntity lockOrUnLock(@PathVariable String ids) {
		log.debug("REST request to lockOrUnLock User: {}", ids);
		dictService.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		DictUtil.clearCache();
		return ResultBuilder.buildOk("操作成功");
	}
	
}
