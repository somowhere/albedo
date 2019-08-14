package com.albedo.java.common.web.resource;

import com.albedo.java.common.core.vo.TreeEntityVo;
import com.albedo.java.common.persistence.service.TreeVoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 基础控制器支持类 copyright 2014 albedo all right reserved author MrLi created on 2014年10月15日 下午4:04:00
 */
public class TreeVoResource<Service extends TreeVoService, V extends TreeEntityVo>
	extends BaseResource {

	protected final Service service;

	public TreeVoResource(Service service) {
		this.service = service;
	}

	@ResponseBody
	@GetMapping(value = "checkByProperty")
	public boolean checkByProperty(V entityForm) {
		return service.doCheckByProperty(entityForm);
	}

}
