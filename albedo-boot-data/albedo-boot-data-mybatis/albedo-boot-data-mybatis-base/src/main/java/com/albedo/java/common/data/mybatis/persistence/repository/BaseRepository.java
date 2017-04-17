/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.data.mybatis.persistence.repository;

import com.albedo.java.common.data.mybatis.persistence.BaseEntity;
import com.albedo.java.common.data.mybatis.persistence.GeneralEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mybatis.repository.support.MybatisRepository;
import org.springframework.data.mybatis.repository.support.QueryDslMybatisRepository;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * DAO支持类实现
 * @author ThinkGem
 * @version 2014-05-16
 */
public interface BaseRepository<T extends GeneralEntity, pk extends Serializable> extends
        MybatisRepository<T, pk>{
    T findOneById(String id);

}