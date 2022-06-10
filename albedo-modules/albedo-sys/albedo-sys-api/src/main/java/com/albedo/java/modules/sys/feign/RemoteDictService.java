package com.albedo.java.modules.sys.feign;

import com.albedo.java.modules.sys.domain.DictDo;

import java.util.List;

/**
 * @author somewhere
 * @description
 * @date 2020/6/1 11:10
 */
public interface RemoteDictService {

	/**
	 * findAllOrderBySort
	 *
	 * @return java.lang.String
	 * @author somewhere
	 * @updateTime 2020/6/1 11:09
	 */
	List<DictDo> findAllOrderBySort();

}
