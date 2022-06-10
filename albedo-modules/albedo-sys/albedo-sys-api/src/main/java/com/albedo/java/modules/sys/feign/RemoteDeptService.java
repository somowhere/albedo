package com.albedo.java.modules.sys.feign;

import java.util.List;

/**
 * @author somewhere
 * @description
 * @date 2020/6/1 11:10
 */
public interface RemoteDeptService {
	/**
	 * findDescendantIdList
	 *
	 * @param deptId
	 * @return List<java.lang.String>
	 * @author somewhere
	 * @updateTime 2020/6/1 11:09
	 */
	List<Long> findDescendantIdList(Long deptId);
}
