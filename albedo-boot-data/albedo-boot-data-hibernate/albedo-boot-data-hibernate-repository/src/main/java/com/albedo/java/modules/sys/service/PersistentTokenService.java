/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.service;

import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.modules.sys.domain.PersistentToken;
import com.albedo.java.modules.sys.repository.PersistentTokenRepository;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.google.common.collect.Lists;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * sessions Service
 * 
 * @author admin
 * @version 2017-01-03
 */
@Service
@Transactional
public class PersistentTokenService {
	public final Logger log = LoggerFactory.getLogger(getClass());
	@Resource
	private PersistentTokenRepository persistentTokenRepository;

	@Transactional(readOnly = true)
	public PersistentToken findOne(String id) {
		return persistentTokenRepository.findOne(id);
	}

	@Transactional(readOnly = true)
	public Page<PersistentToken> findAll(SpecificationDetail<PersistentToken> spec, PageModel<PersistentToken> pm) {
		return persistentTokenRepository.findAll(spec, pm);
	}

	public void delete(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id -> {
			persistentTokenRepository.findOneById(id).map(u -> {
				log.debug("Deleted Persistent: {}", u);
				persistentTokenRepository.delete(u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("回话  信息为空，删除失败"));
		});
	}
}