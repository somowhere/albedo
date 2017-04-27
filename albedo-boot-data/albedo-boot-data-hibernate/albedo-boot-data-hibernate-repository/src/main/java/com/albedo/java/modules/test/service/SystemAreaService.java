/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.test.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.service.DataService;
import com.albedo.java.modules.test.domain.SystemArea;
import com.albedo.java.modules.test.repository.SystemAreaRepository;
import com.albedo.java.util.PublicUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 区域管理Service 区域管理
 * @author admin
 * @version 2017-04-24
 */
@Service
@Transactional
public class SystemAreaService extends DataService<SystemAreaRepository, SystemArea, Long>{
    @Autowired
    public  SystemAreaRepository repository;
    @Transactional(readOnly = true)
    public SystemArea findTopByParentId(Long parentId) {
        List<SystemArea> tempList = repository.findTop1ByParentIdAndStatusNotOrderBySortDesc(parentId, BaseEntity.FLAG_DELETE);
        return PublicUtil.isNotEmpty(tempList) ? tempList.get(0) : null;
    }
    @Override
    public SystemArea save(SystemArea entity) {
        String oldParentIds = entity.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
        if(entity.getParentId()!=null){
            SystemArea parent = repository.findOne(entity.getParentId());
//            if (parent == null || PublicUtil.isEmpty(parent.getId()))
//                throw new RuntimeMsgException("无法获取模块的父节点，插入失败");
            if(parent!=null){
                parent.setLeaf(false);
//                checkSave(parent);
                repository.save(parent);
                entity.setParentIds(PublicUtil.toAppendStr(parent.getParentIds(), parent.getId(), ","));
                SystemArea item = findTopByParentId(parent.getParentId());
                if (item!=null){
                    entity.setSort(parent.getSort() + item.getSort());
                }else entity.setSort(10l);
            }

        }

        if(PublicUtil.isNotEmpty(entity.getId())){
            Long count = repository.countByParentId(entity.getId());
            entity.setLeaf(count == null || count== 0 ? true : false);
        }else{
            entity.setLeaf(true);
        }
//        checkSave(entity);
        entity = repository.save(entity);
        // 更新子节点 parentIds
        List<SystemArea> list = repository.findAllByParentIdsLike(PublicUtil.toAppendStr("%,", entity.getId(), ",%"));
        for (SystemArea e : list) {
            e.setParentIds(e.getParentIds().replace(oldParentIds, entity.getParentIds()));
        }
        repository.save(list);
        log.debug("Save Information for SystemArea: {}", entity);
        return entity;
    }
}