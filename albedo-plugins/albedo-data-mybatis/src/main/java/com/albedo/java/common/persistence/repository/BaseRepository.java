/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.persistence.repository;

import com.albedo.java.common.persistence.domain.GeneralEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * DAO支持类实现
 *
 * @author somewhere
 * @version 2018-03-07
 */
public interface BaseRepository<T extends GeneralEntity> extends BaseMapper<T> {

}
