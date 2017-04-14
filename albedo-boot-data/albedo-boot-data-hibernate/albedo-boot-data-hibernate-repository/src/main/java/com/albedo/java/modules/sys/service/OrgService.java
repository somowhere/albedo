package com.albedo.java.modules.sys.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.repository.service.BaseService;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Org;
import com.albedo.java.vo.sys.query.OrgTreeQuery;
import com.albedo.java.modules.sys.repository.OrgRepository;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.alibaba.fastjson.JSON;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;

/**
 * Service class for managing orgs.
 */
@Service
@Transactional
public class OrgService extends BaseService<Org> {

	@Inject
	private OrgRepository orgRepository;

	public Org save(Org org) {
		String oldParentIds = org.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
		if(org.getParentId()!=null){
			Org parent = orgRepository.findOne(org.getParentId());
			if (parent == null || PublicUtil.isEmpty(parent.getId()))
				throw new RuntimeMsgException("无法获取模块的父节点，插入失败");
			if(parent!=null){
				parent.setLeaf(false);
				orgRepository.save(parent);
			}
			org.setParentIds(PublicUtil.toAppendStr(parent.getParentIds(), parent.getId(), ","));
		}
		
		if(PublicUtil.isNotEmpty(org.getId())){
			Org itemTemp = orgRepository.findFirstByParentId(org.getId());
			org.setLeaf(itemTemp == null? true : false);
		}else{
			org.setLeaf(true);
		}
		org = orgRepository.save(org);
		// 更新子节点 parentIds
		List<Org> list = orgRepository.findFirstByParentIdsLike(PublicUtil.toAppendStr("%,", org.getId(), ",%"));
		for (Org e : list) {
			e.setParentIds(e.getParentIds().replace(oldParentIds, org.getParentIds()));
		}
		orgRepository.save(list);
		// 清除缓存
		SecurityUtil.clearUserJedisCache();
		
		log.debug("Save Information for Org: {}", org);
		return org;
	}

	public void delete(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id -> {
			orgRepository.findOneById(id).map(u -> {
				deleteById(id, PublicUtil.toAppendStr("%,", id, ",%"));
				log.debug("Deleted Org: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("组织 " + id + " 信息为空，删除失败"));
		});
		SecurityUtil.clearUserJedisCache();
	}

	public void lockOrUnLock(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id ->{
			orgRepository.findOneById(id).map(u -> {
    			operateStatusById(id, PublicUtil.toAppendStr("%,", id, ",%"), BaseEntity.FLAG_NORMAL.equals(u.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL,SecurityUtil.getCurrentAuditor());
                log.debug("LockOrUnLock Org: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("组织 " + id + " 信息为空，操作失败"));
    	});
		SecurityUtil.clearUserJedisCache();
	}
	
	@Transactional(readOnly = true)
	public JSON findTreeData(OrgTreeQuery orgTreeQuery) {
		String extId = orgTreeQuery !=null ? orgTreeQuery.getExtId() : null,
                showType= orgTreeQuery !=null ? orgTreeQuery.getShowType() : null,
                all = orgTreeQuery !=null ?  orgTreeQuery.getAll() : null;
		Long grade = orgTreeQuery !=null ?  orgTreeQuery.getGrade() : null;
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Org> list = SecurityUtil.getOrgList();
		for (Org e : list) {
			if ((PublicUtil.isEmpty(extId)
					|| PublicUtil.isEmpty(e.getParentIds()) || (PublicUtil.isNotEmpty(extId) && !extId.equals(e.getId()) && e.getParentIds() != null && e.getParentIds().indexOf("," + extId + ",") == -1))
					&& (PublicUtil.isEmpty(showType)
							|| (PublicUtil.isNotEmpty(showType) && (showType.equals("1") ? showType.equals(e.getType()) : true)))
					&& (PublicUtil.isEmpty(grade) || (PublicUtil.isNotEmpty(grade) && Integer.parseInt(e.getGrade()) <= grade.intValue()))
					&& (all != null || (all == null && BaseEntity.FLAG_NORMAL.equals(e.getStatus())))) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				map.put("pIds", e.getParentIds());
				map.put("org", e);
				if ("3".equals(showType)) {
					map.put("isParent", true);
					e.getUsers().forEach(user -> {
						Map<String, Object> userMap = Maps.newHashMap();
						userMap.put("id", user.getId());
						userMap.put("pId", e.getId());
						userMap.put("name", user.getName());
						userMap.put("iconCls", "fa fa-user");
						mapList.add(userMap);
					});
				}
				mapList.add(map);
			}
		}
		return JsonUtil.getInstance().setRecurrenceStr("parent_name").toJsonObject(mapList);
	}
	
	@Transactional(readOnly = true)
	public Org findOne(String id) {
		return orgRepository.findOne(id);
	}
	@Transactional(readOnly = true)
	public Page<Org> findAll(SpecificationDetail<Org> spec, PageModel<Org> pm) {
		return orgRepository.findAll(spec, pm);
	}
	@Transactional(readOnly = true)
	public List<Org> findAllByParentId(String parentId) {
		return orgRepository.findAllByParentIdAndStatusNot(parentId, Org.FLAG_DELETE);
	}

}
