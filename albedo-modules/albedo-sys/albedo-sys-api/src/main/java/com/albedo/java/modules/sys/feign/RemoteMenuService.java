package com.albedo.java.modules.sys.feign;

import com.albedo.java.modules.sys.domain.dto.GenSchemeDto;

/**
 * @author somewhere
 * @description
 * @date 2020/6/1 11:10
 */
public interface RemoteMenuService {

	/**
	 * saveByGenScheme
	 *
	 * @param schemeDto
	 * @return boolean
	 * @author somewhere
	 * @updateTime 2020/6/1 11:10
	 */
	boolean saveByGenScheme(GenSchemeDto schemeDto);

}
