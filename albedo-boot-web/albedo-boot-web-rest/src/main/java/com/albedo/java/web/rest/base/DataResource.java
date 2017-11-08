package com.albedo.java.web.rest.base;

import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.common.service.DataService;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.Globals;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 基础控制器支持类 copyright 2014 albedo all right reserved author MrLi created on 2014年10月15日 下午4:04:00
 */
public class DataResource<Service extends DataService, T extends DataEntity> extends BaseResource {

    @Autowired
    protected Service service;

    @ModelAttribute
    public T get(@RequestParam(required = false) String id) throws Exception {
        String path = request.getRequestURI();
        if (path != null && !path.contains(Globals.URL_CHECKBY) && !path.contains(Globals.URL_FIND) &&
                PublicUtil.isNotEmpty(id)) {
            return (T) service.findOne(id);
        } else {
            return (T) service.getPersistentClass().newInstance();
        }
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

//	@RequestMapping(value = "findJson")
//	public void findJson(Combo combo, HttpServletResponse response) {
//		
//		List<ComboData> comboDataList = jpaCustomeRepository.findJson(combo);
//		writeJsonHttpResponse(comboDataList, response);
//	}

}
