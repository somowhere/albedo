package com.albedo.java.modules.sys.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.repository.service.BaseService;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Module;
import com.albedo.java.modules.sys.repository.ModuleRepository;
import com.albedo.java.util.JedisUtil;
import com.albedo.java.util.Json;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.domain.RequestMethod;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;

/**
 * Service class for managing modules.
 */
@Service
@Transactional
public class ModuleService extends BaseService<Module> {

	@Inject
	private ModuleRepository moduleRepository;

	public Module save(Module module) {
		String oldParentIds = module.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
		Module parent = moduleRepository.findOne(module.getParentId());
		if (parent == null || PublicUtil.isEmpty(parent.getId()))
			throw new RuntimeMsgException("无法获取模块的父节点，插入失败");
		if(parent!=null){
			parent.setLeaf(false);
			moduleRepository.save(parent);
		}
		if(PublicUtil.isNotEmpty(module.getId())){
			Module itemTemp = moduleRepository.findOne(module.getId());
			module.setLeaf(itemTemp == null? true : false);
		}else{
			module.setLeaf(true);
		}
		module.setParentIds(PublicUtil.toAppendStr(parent.getParentIds(), parent.getId(), ","));
		module = moduleRepository.save(module);
		// 更新子节点 parentIds
		List<Module> list = moduleRepository.findFirstByParentIdsLike(PublicUtil.toAppendStr("%,", module.getId(), ",%"));
		for (Module e : list) {
			e.setParentIds(e.getParentIds().replace(oldParentIds, module.getParentIds()));
		}
		moduleRepository.save(list);
		// 清除模块缓存
		SecurityUtil.clearUserJedisCache();
		JedisUtil.removeSys(Globals.RESOURCE_MODULE_DATA_MAP);
		log.debug("Save Information for Module: {}", module);
		return module;
	}

	public void delete(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id -> {
			moduleRepository.findOneById(id).map(u -> {
				deleteById(id, PublicUtil.toAppendStr("%,", id, ",%"));
				log.debug("Deleted Module: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("模块 " + id + " 信息为空，删除失败"));
		});
		SecurityUtil.clearUserJedisCache();
		JedisUtil.removeSys(Globals.RESOURCE_MODULE_DATA_MAP);
	}

	public void lockOrUnLock(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id ->{
			moduleRepository.findOneById(id).map(u -> {
    			operateStatusById(id, PublicUtil.toAppendStr("%,", id, ",%"), BaseEntity.FLAG_NORMAL.equals(u.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL);
                log.debug("LockOrUnLock User: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("模块 " + id + " 信息为空，操作失败"));
    	});
		SecurityUtil.clearUserJedisCache();
		JedisUtil.removeSys(Globals.RESOURCE_MODULE_DATA_MAP);
	}

	@Transactional(readOnly = true)
	public String findTreeData(String type, String all) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Module> moduleList = SecurityUtil.getModuleList();
		for (Module e : moduleList) {
			if ((all != null || (all == null && BaseEntity.FLAG_NORMAL.equals(e.getStatus())))) {
				Map<String, Object> map = Maps.newHashMap();
				if ("menu".equals(type) && !Module.TYPE_MENU.equals(e.getType())) {
					continue;
				}
				map.put("id", e.getId());
				map.put("pId", e.getParent() != null ? e.getParent().getId() : 0);
				map.put("name", e.getName());
				map.put("iconCls", PublicUtil.toAppendStr("fa ", e.getIconCls()));
				mapList.add(map);
			}
		}
		return Json.toJsonString(mapList);
	}
	@Transactional(readOnly = true)
	public Module findOne(String id) {
		return moduleRepository.findOne(id);
	}
	@Transactional(readOnly = true)
	public Page<Module> findAll(SpecificationDetail<Module> spec, PageModel<Module> pm) {
		return moduleRepository.findAll(spec, pm);
	}
	@Transactional(readOnly = true)
	public List<Module> findAllByParentId(String parentId) {
		return moduleRepository.findAllByParentIdAndStatusNot(parentId, Module.FLAG_DELETE);
	}
	public void generatorModuleData(String moduleName, String parentModuleId, String url){
		Module currentModule = moduleRepository.findOne(DynamicSpecifications.bySearchQueryCondition(QueryCondition.eq(Module.F_NAME, moduleName)));
		if (currentModule != null)
			baseRepository.execute("delete Module where id=:p1 or parentId=:p1", currentModule.getId());
		Module parentModule = moduleRepository.findOne(parentModuleId);
		if (parentModule == null)
			new Exception(PublicUtil.toAppendStr("根据模块id[", parentModuleId, "无法查询到模块信息]"));
		String permission = url.replace("/", "_").substring(1);
		Module module = new Module();
		module.setPermission(permission.substring(0, permission.length()-1));
		module.setName(moduleName);
		module.setParentId(parentModule.getId());
		module.setType(Module.TYPE_MENU);
		module.setRequestMethod(RequestMethod.GET);
		module.setIconCls("fa-file");
		module.setUrl(url);
		save(module);

		Module moduleView = new Module();
		moduleView.setParent(module);
		moduleView.setName("查看");
		moduleView.setIconCls("fa-info-circle");
		moduleView.setPermission(permission + "view");
		moduleView.setParentId(module.getId());
		moduleView.setType(Module.TYPE_OPERATE);
		moduleView.setRequestMethod(RequestMethod.GET);
		moduleView.setSort(20);
		moduleView.setUrl(url + "page");
		save(moduleView);
		Module moduleEdit = new Module();
		moduleEdit.setParent(module);
		moduleEdit.setName("编辑");
		moduleEdit.setIconCls("fa-pencil");
		moduleEdit.setPermission(permission + "edit");
		moduleEdit.setParentId(module.getId());
		moduleEdit.setType(Module.TYPE_OPERATE);
		moduleEdit.setSort(40);
		moduleEdit.setUrl(url + "edit");
		moduleEdit.setRequestMethod(PublicUtil.toAppendStr(RequestMethod.GET, StringUtil.SPLIT_DEFAULT, RequestMethod.POST));
		save(moduleEdit);
		Module moduleLock = new Module();
		moduleLock.setParent(module);
		moduleLock.setName("锁定");
		moduleLock.setIconCls("fa-lock");
		moduleLock.setPermission(permission + "lock");
		moduleLock.setParentId(module.getId());
		moduleLock.setType(Module.TYPE_OPERATE);
		moduleLock.setSort(60);
		moduleLock.setUrl(url + "lock");
		moduleLock.setRequestMethod(RequestMethod.POST);
		save(moduleLock);
		Module moduleDelete = new Module();
		moduleDelete.setParent(module);
		moduleDelete.setName("删除");
		moduleDelete.setIconCls("fa-trash-o");
		moduleDelete.setPermission(permission + "delete");
		moduleDelete.setParentId(module.getId());
		moduleDelete.setType(Module.TYPE_OPERATE);
		moduleDelete.setSort(80);
		moduleDelete.setUrl(url + "delete");
		moduleDelete.setRequestMethod(RequestMethod.DELETE);
		save(moduleDelete);
		SecurityUtil.clearUserJedisCache();
	}

}
