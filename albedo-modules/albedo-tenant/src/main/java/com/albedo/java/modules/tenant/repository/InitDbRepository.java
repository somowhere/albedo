package com.albedo.java.modules.tenant.repository;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 初始化数据库DAO
 *
 * @author somewhere
 * @date 2019/09/02
 */
@Mapper
@InterceptorIgnore(tenantLine = "true", dynamicTableName = "true")
public interface InitDbRepository {
	/**
	 * 创建数据库
	 *
	 * @param database 数据库
	 * @return 创建数量
	 */
	int createDatabase(@Param("database") String database);


	/**
	 * 删除数据库
	 *
	 * @param database 数据库
	 * @return 删除数量
	 */
	int dropDatabase(@Param("database") String database);

}
