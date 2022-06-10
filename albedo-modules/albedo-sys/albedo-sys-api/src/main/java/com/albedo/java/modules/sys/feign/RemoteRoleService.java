package com.albedo.java.modules.sys.feign;

import java.io.Serializable;
import java.util.List;

/**
 * @author somewhere
 * @description
 * @date 2020/6/1 11:18
 */
public interface RemoteRoleService {
	/**
	 * findDescendantIdList
	 *
	 * @param roleId
	 * @return List<java.lang.String>
	 * @author somewhere
	 * @updateTime 2020/6/1 11:09
	 */
	List<Long> findDeptIdsByRoleId(Serializable roleId);

}
