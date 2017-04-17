package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Org;
import com.albedo.java.modules.sys.repository.OrgRepository;
import com.albedo.java.modules.sys.service.OrgService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.sys.query.OrgTreeQuery;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * REST controller for managing Station.
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/org")
public class OrgResource extends DataResource<OrgService, Org> {

	@Resource
	private OrgService orgService;

	@RequestMapping(value = "findTreeData", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity findTreeData(OrgTreeQuery orgTreeQuery) {
		List<Map<String, Object>> rs = orgService.findTreeData(orgTreeQuery, SecurityUtil.getOrgList());
		return ResultBuilder.buildOk(rs);
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
	 *
	 * @param pm
	 * @return
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ResponseEntity getPage(PageModel<Org> pm)  {

		pm.setSortDefaultName(Direction.DESC, DataEntity.F_LASTMODIFIEDDATE);
		orgService.findPage(pm);
		JSON rs = JsonUtil.getInstance().toJsonObject(pm);
		return ResultBuilder.buildObject(rs);
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String form(Org org)  {
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
	 *
	 * @param org
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public ResponseEntity save(Org org)
			 {
		log.debug("REST request to save Org : {}", org);
		// Lowercase the org login before comparing with database
		if (!checkByProperty(Reflections.createObj(Org.class, Lists.newArrayList(Org.F_ID, Org.F_NAME),
				org.getId(), org.getName()))) {
			throw new RuntimeMsgException("名称已存在");
		}
		orgService.save(org);
		SecurityUtil.clearUserJedisCache();
		return ResultBuilder.buildOk("保存", org.getName(), "成功");
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
		log.debug("REST request to delete Org: {}", ids);
		orgService.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)), SecurityUtil.getCurrentAuditor());
		SecurityUtil.clearUserJedisCache();
		return ResultBuilder.buildOk("删除成功");
	}

	/**
	 *
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public ResponseEntity lockOrUnLock(@PathVariable String ids) {
		log.debug("REST request to lockOrUnLock User: {}", ids);
		orgService.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)), SecurityUtil.getCurrentAuditor());
		SecurityUtil.clearUserJedisCache();
		return ResultBuilder.buildOk("操作成功");
	}
	
}
