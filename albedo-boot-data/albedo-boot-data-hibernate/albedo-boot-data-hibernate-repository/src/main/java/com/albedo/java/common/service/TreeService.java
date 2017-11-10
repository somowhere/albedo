package com.albedo.java.common.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.common.repository.TreeRepository;
import com.albedo.java.modules.sys.domain.Area;
import com.albedo.java.util.PublicUtil;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;


@Transactional
public class TreeService<Repository extends TreeRepository<T, PK>, T extends TreeEntity<T>, PK extends Serializable>
        extends DataService<Repository, T, PK> {

    /**
     * 逻辑删除
     *
     * @param id
     * @param likeParentIds
     * @return
     */
    public int deleteById(PK id, String likeParentIds, String lastModifiedBy) {
        return operateStatusById(id, likeParentIds, BaseEntity.FLAG_DELETE, lastModifiedBy);
    }

    public int operateStatusById(PK id, String likeParentIds, Integer status, String lastModifiedBy) {
        return baseRepository.createQuery(
                PublicUtil.toAppendStr("update ", getPersistentClass().getSimpleName(), " set status='", status,
                        "', lastModifiedBy=:p3, lastModifiedDate=:p4 where id = :p1 or parentIds like :p2"),
                id, likeParentIds, lastModifiedBy, PublicUtil.getCurrentDate()).executeUpdate();
    }

    @Override
    public T save(T entity) {
        String oldParentIds = entity.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
        if (entity.getParentId() != null) {
            T parent = repository.findOne((PK) entity.getParentId());
//            if (parent == null || PublicUtil.isEmpty(parent.getId()))
//                throw new RuntimeMsgException("无法获取模块的父节点，插入失败");
            if (parent != null) {
                parent.setLeaf(false);
                repository.save(parent);
                entity.setParentIds(PublicUtil.toAppendStr(parent.getParentIds(), parent.getId(), ","));
            }
        }

        if (PublicUtil.isNotEmpty(entity.getId())) {
            T itemTemp = repository.findFirstByParentId(entity.getId());
            entity.setLeaf(itemTemp == null ? true : false);
        } else {
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

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public T findTopByParentId(String parentId) {
        List<T> tempList = repository.findTop1ByParentIdAndStatusNotOrderBySortDesc(parentId, BaseEntity.FLAG_DELETE);
        return PublicUtil.isNotEmpty(tempList) ? tempList.get(0) : null;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Long countTopByParentId(String parentId) {
        return repository.countByParentIdAndStatusNot(parentId, Area.FLAG_DELETE);
    }
}
