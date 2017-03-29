package com.albedo.java.modules.gen.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.repository.service.BaseService;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.gen.domain.GenTableColumn;
import com.albedo.java.modules.gen.repository.GenTableColumnRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.google.common.collect.Lists;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;

/**
 * Service class for managing genTables.
 */
@Service
@Transactional
public class GenTableColumnService extends BaseService<GenTableColumn> {

	@Inject
	private GenTableColumnRepository genTableColumnRepository;

	public GenTableColumn save(GenTableColumn genTableColumn) {
		genTableColumn = genTableColumnRepository.save(genTableColumn);
		log.debug("Save Information for GenTableColumn: {}", genTableColumn);
		SecurityUtil.clearUserJedisCache();
		return genTableColumn;
	}

	public void delete(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id -> {
			genTableColumnRepository.findOneById(id).map(u -> {
				deleteById(id,SecurityUtil.getCurrentAuditor());
				log.debug("Deleted GenTableColumn: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("用户 " + id + " 信息为空，删除失败"));
		});
		SecurityUtil.clearUserJedisCache();
	}

	public void lockOrUnLock(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id -> {
			genTableColumnRepository.findOneById(id).map(u -> {
				operateStatusById(id,
						BaseEntity.FLAG_NORMAL.equals(u.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL,SecurityUtil.getCurrentAuditor());
				log.debug("LockOrUnLock GenTableColumn: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("用户 " + id + " 信息为空，操作失败"));
		});
		SecurityUtil.clearUserJedisCache();
	}

	public void deleteByTableId(String id) {
		baseRepository.createQuery(
				PublicUtil.toAppendStr("update GenTableColumn set status='", BaseEntity.FLAG_DELETE,
						"', lastModifiedBy=:p2, lastModifiedDate=:p3 where genTable.id = :p1"),
				id, SecurityUtil.getCurrentAuditor(), PublicUtil.getCurrentDate()).executeUpdate();
	}


}
