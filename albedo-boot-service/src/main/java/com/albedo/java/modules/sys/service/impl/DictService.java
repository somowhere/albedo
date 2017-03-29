package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.repository.service.BaseService;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.vo.sys.query.DictTreeQuery;
import com.albedo.java.modules.sys.repository.DictRepository;
import com.albedo.java.util.DictUtil;
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
 * Service class for managing dicts.
 */
@Service
@Transactional
public class DictService extends BaseService<Dict> {

	@Inject
	private DictRepository dictRepository;

	public Dict save(Dict dict) {
		String oldParentIds = dict.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
		if(dict.getParentId()!=null){
			Dict parent = dictRepository.findOne(dict.getParentId());
			if (parent == null || PublicUtil.isEmpty(parent.getId()))
				throw new RuntimeMsgException("无法获取模块的父节点，插入失败");
			if(parent!=null){
				parent.setLeaf(false);
				dictRepository.save(parent);
			}
			dict.setParentIds(PublicUtil.toAppendStr(parent.getParentIds(), parent.getId(), ","));
		}
		
		if(PublicUtil.isNotEmpty(dict.getId())){
			Dict itemTemp = dictRepository.findFirstByParentId(dict.getId());
			dict.setLeaf(itemTemp == null? true : false);
		}else{
			dict.setLeaf(true);
		}
		dict = dictRepository.save(dict);
		// 更新子节点 parentIds
		List<Dict> list = dictRepository.findAllByParentIdsLike(PublicUtil.toAppendStr("%,", dict.getId(), ",%"));
		for (Dict e : list) {
			e.setParentIds(e.getParentIds().replace(oldParentIds, dict.getParentIds()));
		}
		dictRepository.save(list);
		DictUtil.clearCache();		
		log.debug("Save Information for Dict: {}", dict);
		return dict;
	}

	public void delete(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id -> {
			dictRepository.findOneById(id).map(u -> {
				deleteById(id, PublicUtil.toAppendStr("%,", id, ",%"));
				log.debug("Deleted Dict: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("字典 " + id + " 信息为空，删除失败"));
		});
		DictUtil.clearCache();	
	}

	public void lockOrUnLock(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id ->{
			dictRepository.findOneById(id).map(u -> {
    			operateStatusById(id, PublicUtil.toAppendStr("%,", id, ",%"), BaseEntity.FLAG_NORMAL.equals(u.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL, SecurityUtil.getCurrentAuditor());
                log.debug("LockOrUnLock User: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("字典 " + id + " 信息为空，操作失败"));
    	});
		DictUtil.clearCache();	
	}

	@Transactional(readOnly = true)
	public JSON findTreeData(DictTreeQuery dictTreeQuery) {
		String type = dictTreeQuery!=null?dictTreeQuery.getType(): null,  all = dictTreeQuery !=null ?dictTreeQuery.getAll() : null;
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Dict> dictList = DictUtil.getDictList();
		for (Dict e : dictList) {
			if ((all != null || (all == null && BaseEntity.FLAG_NORMAL.equals(e.getStatus())))) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", PublicUtil.isEmpty(e.getParentId()) ? "0" : e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return JsonUtil.getInstance().toJsonObject(mapList);
	}
	@Transactional(readOnly = true)
	public Dict findOne(String id) {
		return dictRepository.findOne(id);
	}
	@Transactional(readOnly = true)
	public Page<Dict> findAll(SpecificationDetail<Dict> spec, PageModel<Dict> pm) {
		return dictRepository.findAll(spec, pm);
	}
	@Transactional(readOnly = true)
	public Dict findFristByParentId(String parentId) {
		return dictRepository.findTopByParentIdAndStatusNotOrderBySortDesc(parentId, Dict.FLAG_DELETE);
	}

}
