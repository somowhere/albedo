package com.albedo.java.common.web.resource;

import com.albedo.java.common.persistence.domain.DataEntity;
import com.albedo.java.common.persistence.service.DataService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 基础控制器支持类 copyright 2014 albedo all right reserved author MrLi created on 2014年10月15日 下午4:04:00
 */
public class DataResource<Service extends DataService, T extends DataEntity> extends BaseResource {

	protected final Service service;

	public DataResource(Service service) {
		this.service = service;
	}


	@ResponseBody
	@GetMapping(value = "checkByProperty")
	public boolean checkByProperty(T entity) {
		return service.doCheckByProperty(entity);
	}

	@ResponseBody
	@GetMapping(value = "checkByPK")
	public boolean checkByPK(T entity) {
		return service.doCheckByPK(entity);
	}


}
