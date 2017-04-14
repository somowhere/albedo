package com.albedo.java.modules.sys.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.repository.service.BaseService;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;

/**
 * Service class for managing roles.
 */
@Service
@Transactional
public class RoleService extends BaseService<Role> {

    @Inject
    private RoleRepository roleRepository;


    public Role save(Role role) {
        role = roleRepository.save(role);
        log.debug("Save Information for Role: {}", role);
        SecurityUtil.clearUserJedisCache();
        return role;
    }


    public void delete(String ids) {
    	Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id ->{
    		roleRepository.findOneById(id).map(u -> {
    			deleteById(id,SecurityUtil.getCurrentAuditor());
                log.debug("Deleted Role: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("角色 " + id + " 信息为空，删除失败"));
    	});
    	SecurityUtil.clearUserJedisCache();
    }


	public void lockOrUnLock(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id ->{
			roleRepository.findOneById(id).map(u -> {
    			operateStatusById(id, BaseEntity.FLAG_NORMAL.equals(u.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL,SecurityUtil.getCurrentAuditor());
                log.debug("LockOrUnLock User: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("角色 " + id + " 信息为空，操作失败"));
    	});
		SecurityUtil.clearUserJedisCache();
	}

	@Transactional(readOnly=true)
	public Role findOne(String id) {
		return roleRepository.findOne(id);
	}

	@Transactional(readOnly=true)
	public Page<Role> findAll(SpecificationDetail<Role> spec, PageModel<Role> pm) {
		return roleRepository.findAll(spec, pm);
	}

}
