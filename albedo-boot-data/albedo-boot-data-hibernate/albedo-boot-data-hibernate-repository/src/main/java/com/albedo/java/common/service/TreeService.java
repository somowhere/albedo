package com.albedo.java.common.service;

import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.common.repository.TreeRepository;
import com.albedo.java.common.repository.service.BaseService;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.exception.RuntimeMsgException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class TreeService<Repository extends TreeRepository<T>, T extends TreeEntity<T>> extends BaseService<Repository, T> {

    public T save(T entity) {
        String oldParentIds = entity.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
        if(entity.getParentId()!=null){
            T parent = repository.findOne(entity.getParentId());
            if (parent == null || PublicUtil.isEmpty(parent.getId()))
                throw new RuntimeMsgException("无法获取模块的父节点，插入失败");
            if(parent!=null){
                parent.setLeaf(false);
                repository.save(parent);
            }
            entity.setParentIds(PublicUtil.toAppendStr(parent.getParentIds(), parent.getId(), ","));
        }

        if(PublicUtil.isNotEmpty(entity.getId())){
            T itemTemp = repository.findFirstByParentId(entity.getId());
            entity.setLeaf(itemTemp == null? true : false);
        }else{
            entity.setLeaf(true);
        }
        entity = repository.save(entity);
        // 更新子节点 parentIds
        List<T> list = repository.findAllByParentIdsLike(PublicUtil.toAppendStr("%,", entity.getId(), ",%"));
        for (T e : list) {
            e.setParentIds(e.getParentIds().replace(oldParentIds, entity.getParentIds()));
        }
        repository.save(list);
        log.debug("Save Information for T: {}", entity);
        return entity;
    }

}
