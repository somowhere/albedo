package com.albedo.java.modules.file.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.BeanUtil;
import com.albedo.java.common.core.util.MapHelper;
import com.albedo.java.common.core.vo.AppendixDto;
import com.albedo.java.common.core.vo.AppendixVo;
import com.albedo.java.common.core.vo.EchoVo;
import com.albedo.java.plugins.database.mybatis.conditions.Wraps;
import com.albedo.java.plugins.database.mybatis.conditions.query.LbqWrapper;
import com.albedo.java.common.core.basic.domain.IdEntity;
import com.albedo.java.plugins.mybatis.service.impl.DataServiceImpl;
import com.albedo.java.modules.file.domain.Appendix;
import com.albedo.java.modules.file.repository.AppendixRepository;
import com.albedo.java.modules.file.service.AppendixService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.google.common.collect.Multimap;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p>
 * 业务实现类
 * 业务附件
 * </p>
 *
 * @author tangyh
 * @date 2021-06-30
 * @create [2021-06-30] [tangyh] [初始创建]
 */
@Slf4j
@Service

@Transactional(readOnly = true)
public class AppendixServiceImpl extends DataServiceImpl<AppendixRepository, Appendix, AppendixDto> implements AppendixService {


    @Override
    @Transactional(readOnly = true)
    public <T extends IdEntity<T, Long> & EchoVo> void echoAppendix(IPage<T> page, String... bizTypes) {
        if (page == null) {
            return;
        }
        echoAppendix(page.getRecords(), bizTypes);
    }

    @Override
    public <T extends IdEntity<T, Long> & EchoVo> void echoAppendix(List<T> list, String... bizTypes) {
        if (CollUtil.isEmpty(list)) {
            return;
        }
        List<Long> ids = list.stream().map(IdEntity::getId).collect(Collectors.toList());

        Multimap<AppendixService.AppendixBizKey, AppendixVo> map = listByBizIds(ids, bizTypes);

        Set<String> bizTypeSet = CollUtil.newHashSet();
        map.forEach((biz, item) -> bizTypeSet.add(biz.getBizType()));

        list.forEach(item -> {
            bizTypeSet.forEach(bizType -> {
                Collection<AppendixVo> colls = map.get(buildBiz(item.getId(), bizType));
                item.getEchoMap().put(bizType, colls);
            });
        });
    }

    @Override
    @Transactional(readOnly = true)
    public Multimap<AppendixBizKey, AppendixVo> listByBizId(Long bizId, String... bizType) {
        ArgumentAssert.notNull(bizId, "请传入业务id");
        LbqWrapper<Appendix> wrap = Wraps.<Appendix>lbQ().eq(Appendix::getBizId, bizId).in(Appendix::getBizType, bizType);
        List<Appendix> list = list(wrap);
        return MapHelper.iterableToMultiMap(list,
                item -> AppendixBizKey.builder().bizId(item.getBizId()).bizType(item.getBizType()).build(),
                item -> BeanUtil.toBean(item, AppendixVo.class));
    }

    @Override
    @Transactional(readOnly = true)
    public Multimap<AppendixBizKey, AppendixVo> listByBizIds(List<Long> bizIds, String... bizType) {
        ArgumentAssert.notEmpty(bizIds, "请传入业务id");
        LbqWrapper<Appendix> wrap = Wraps.<Appendix>lbQ().in(Appendix::getBizId, bizIds).in(Appendix::getBizType, bizType);
        List<Appendix> list = list(wrap);
        return MapHelper.iterableToMultiMap(list,
                item -> AppendixBizKey.builder().bizId(item.getBizId()).bizType(item.getBizType()).build(),
                item -> BeanUtil.toBean(item, AppendixVo.class));
    }

    @Override
    @Transactional(readOnly = true)
    public List<AppendixVo> listByBizIdAndBizType(Long bizId, String bizType) {
        ArgumentAssert.notNull(bizId, "请传入业务id");
        LbqWrapper<Appendix> wrap = Wraps.<Appendix>lbQ().eq(Appendix::getBizId, bizId)
                .eq(Appendix::getBizType, bizType);
        return BeanUtil.toBeanList(list(wrap), AppendixVo.class);
    }

    @Override
    @Transactional(readOnly = true)
    public AppendixVo getByBiz(Long bizId, String bizType) {
        ArgumentAssert.notNull(bizId, "请传入业务id");
        ArgumentAssert.notEmpty(bizType, "请传入功能点");
        LbqWrapper<Appendix> wrap = Wraps.<Appendix>lbQ().eq(Appendix::getBizId, bizId)
                .eq(Appendix::getBizType, bizType);
        List<Appendix> list = list(wrap);
        if (CollUtil.isEmpty(list)) {
            return null;
        }
        return BeanUtil.toBean(list.get(0), AppendixVo.class);
    }


    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean save(Long bizId, AppendixDto saveVo) {
        if (bizId != null) {
            remove(Wraps.<Appendix>lbQ().eq(Appendix::getBizId, bizId));
        }
        if (saveVo == null) {
            return true;
        }
        Appendix commonFile = BeanUtil.toBean(saveVo, Appendix.class);
        commonFile.setBizId(bizId);
        save(commonFile);
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean save(Long bizId, List<AppendixDto> list) {
        if (bizId != null) {
            remove(Wraps.<Appendix>lbQ().eq(Appendix::getBizId, bizId));
        }
        if (CollUtil.isEmpty(list)) {
            return false;
        }
        List<Appendix> commonFiles = BeanUtil.toBeanList(list, Appendix.class);
        commonFiles.forEach(item -> item.setBizId(bizId));
        saveBatch(commonFiles);
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean save(Long bizId, String bizType, List<AppendixDto> list) {
        removeByBizId(bizId, bizType);
        if (CollUtil.isEmpty(list)) {
            return false;
        }
        List<Appendix> commonFiles = BeanUtil.toBeanList(list, Appendix.class);
        commonFiles.forEach(item -> {
            item.setBizId(bizId);
            item.setBizType(bizType);
        });
        saveBatch(commonFiles);
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeByBizId(List<Long> objectIds) {
        if (CollUtil.isEmpty(objectIds)) {
            return false;
        }
        return remove(Wraps.<Appendix>lbQ().in(Appendix::getBizId, objectIds));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeByBizId(Long... objectIds) {
        if (ArrayUtil.isEmpty(objectIds)) {
            return false;
        }
        return remove(Wraps.<Appendix>lbQ().in(Appendix::getBizId, objectIds));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeByBizId(Long bizId, String bizType) {
        ArgumentAssert.isFalse(bizId == null && StrUtil.isEmpty(bizType), "请传入对象id或功能点");
        return remove(Wraps.<Appendix>lbQ().eq(Appendix::getBizId, bizId).eq(Appendix::getBizType, bizType));
    }

}
