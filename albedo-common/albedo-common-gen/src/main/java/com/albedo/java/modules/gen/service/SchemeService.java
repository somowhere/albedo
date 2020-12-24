package com.albedo.java.modules.gen.service;

import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.gen.domain.Scheme;
import com.albedo.java.modules.gen.domain.dto.SchemeDto;
import com.albedo.java.modules.gen.domain.dto.SchemeQueryCriteria;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;
import java.util.Map;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:25 下午
 */
public interface SchemeService extends DataService<Scheme, SchemeDto, String> {
	/**
	 * findAllListIdNot
	 *
	 * @param id
	 * @return java.util.List<com.albedo.java.modules.gen.domain.Scheme>
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	List<Scheme> findAllListIdNot(String id);

	/**
	 * generateCode
	 *
	 * @param schemeDto
	 * @return java.lang.String
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	String generateCode(SchemeDto schemeDto);

	/**
	 * findFormData
	 *
	 * @param schemeDto
	 * @param loginId
	 * @return java.util.Map<java.lang.String, java.lang.Object>
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	Map<String, Object> findFormData(SchemeDto schemeDto, String loginId);

	/**
	 * getSchemeVoPage  分页查询用户信息（含有角色信息）
	 *
	 * @param pageModel
	 * @param schemeQueryCriteria
	 * @return com.baomidou.mybatisplus.core.metadata.IPage
	 * @author somewhere
	 * @updateTime 2020/5/31 17:38
	 */
	IPage getSchemeVoPage(PageModel pageModel, SchemeQueryCriteria schemeQueryCriteria);

	/**
	 * previewCode
	 *
	 * @param id
	 * @param username
	 * @return java.util.Map<java.lang.String, java.lang.Object>
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	Map<String, Object> previewCode(String id, String username);
}
