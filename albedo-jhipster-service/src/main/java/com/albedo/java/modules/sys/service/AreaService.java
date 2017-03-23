/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.repository.service.BaseService;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Area;
import com.albedo.java.modules.sys.domain.vo.AreaTreeQuery;
import com.albedo.java.modules.sys.repository.AreaRepository;
import com.albedo.java.modules.sys.service.util.JsonUtil;
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

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 区域管理Service 区域管理
 * @author admin
 * @version 2017-01-01
 */
@Service
@Transactional
public class AreaService extends BaseService<Area>{

	@Resource
	private AreaRepository areaRepository;
	/** 保存区域管理
	 * 
	 * @param area 实体区域管理
	 * @return */
	public Area save(Area area) {
		String oldParentIds = area.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
		if(area.getParentId()!=null){
			Area parent = areaRepository.findOne(area.getParentId());
			if (parent == null || PublicUtil.isEmpty(parent.getId()))
				throw new RuntimeMsgException("无法获取模块的父节点，插入失败");
			if(parent!=null){
				parent.setLeaf(false);
				areaRepository.save(parent);
			}
			area.setParentIds(PublicUtil.toAppendStr(parent.getParentIds(), parent.getId(), ","));
		}
		
		if(PublicUtil.isNotEmpty(area.getId())){
			Area itemTemp = areaRepository.findFirstByParentId(area.getId());
			area.setLeaf(itemTemp == null? true : false);
		}else{
			area.setLeaf(true);
		}
		area = areaRepository.save(area);
		// 更新子节点 parentIds
		List<Area> list = areaRepository.findAllByParentIdsLike(PublicUtil.toAppendStr("%,", area.getId(), ",%"));
		for (Area e : list) {
			e.setParentIds(e.getParentIds().replace(oldParentIds, area.getParentIds()));
		}
		areaRepository.save(list);
		SecurityUtil.clearUserJedisCache();
		log.debug("Save Information for Area: {}", area);
		return area;
	}

	public void delete(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id -> {
			areaRepository.findOneById(id).map(u -> {
				deleteById(id, PublicUtil.toAppendStr("%,", id, ",%"));
				log.debug("Deleted Area: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("区域管理信息为空，删除失败"));
		});
		SecurityUtil.clearUserJedisCache();
	}

	public void lockOrUnLock(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id ->{
			areaRepository.findOneById(id).map(u -> {
    			operateStatusById(id, PublicUtil.toAppendStr("%,", id, ",%"), BaseEntity.FLAG_NORMAL.equals(u.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL);
                log.debug("LockOrUnLock Area: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("区域管理信息为空，操作失败"));
    	});
		SecurityUtil.clearUserJedisCache();
	}
	
	@Transactional(readOnly = true)
	public JSON findTreeData(AreaTreeQuery areaTreeQuery) {

		String extId = areaTreeQuery!=null ? areaTreeQuery.getExtId() : null,
		 all =  areaTreeQuery!=null ? areaTreeQuery.getAll() : null,
		parentId =  areaTreeQuery!=null ? areaTreeQuery.getParentId() : null;
		Integer ltLevel =  areaTreeQuery!=null ? areaTreeQuery.getLtLevel() : null,
		level =  areaTreeQuery!=null ? areaTreeQuery.getLevel() : null;

		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Area> list = SecurityUtil.getAreaList();
		for (int i=0; i<list.size(); i++){
			Area e = list.get(i);
			if ((StringUtil.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1))
					&&(all != null || BaseEntity.FLAG_NORMAL.equals(e.getStatus()))
					&&(ltLevel == null || ltLevel >= e.getLevel())
					&&(level == null || level.equals(e.getLevel()))
					&&(PublicUtil.isEmpty(parentId) || e.getParentId().equals(parentId))){
					Map<String, Object> map = Maps.newHashMap();
					map.put("id", e.getId());
					map.put("pId", e.getParentId());
					map.put("name", e.getName());
					map.put("iconCls", "fa fa-th-large");
					map.put("pIds", e.getParentIds());
					mapList.add(map);
			}
		}
		return JsonUtil.getInstance().toJsonObject(mapList);
	}
	
	@Transactional(readOnly = true)
	public Area findOne(String id) {
		return areaRepository.findOne(id);
	}
	@Transactional(readOnly = true)
	public Page<Area> findAll(SpecificationDetail<Area> spec, PageModel<Area> pm) {
		return areaRepository.findAll(spec, pm);
	}
	@Transactional(readOnly = true)
	public Area findTopByParentId(String parentId) {
		return areaRepository.findTopByParentIdAndStatusNotOrderBySortDesc(parentId, Area.FLAG_DELETE);
	}

}