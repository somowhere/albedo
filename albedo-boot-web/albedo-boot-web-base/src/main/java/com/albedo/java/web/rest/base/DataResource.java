package com.albedo.java.web.rest.base;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.repository.data.JpaCustomeRepository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/** 基础控制器支持类 copyright 2014 albedo all right reserved author MrLi created on 2014年10月15日 下午4:04:00 */
public class DataResource<T extends BaseEntity> extends BaseResource {

	@Resource
	protected JpaCustomeRepository<T> jpaCustomeRepository;

	@ResponseBody
	@RequestMapping(value = "checkByProperty", method= RequestMethod.GET)
	public synchronized boolean checkByProperty(T entity) {
		return jpaCustomeRepository.doCheckByProperty(entity);
	}
	@ResponseBody
	@RequestMapping(value = "checkByPK", method= RequestMethod.GET)
	public synchronized boolean checkByPK(T entity) {
		return jpaCustomeRepository.doCheckByPK(entity);
	}

//	@RequestMapping(value = "findJson")
//	public void findJson(Combo combo, HttpServletResponse response) {
//		
//		List<ComboData> comboDataList = jpaCustomeRepository.findJson(combo);
//		writeJsonHttpResponse(comboDataList, response);
//	}

}
