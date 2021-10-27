package com.albedo.java.plugins.mybatis.service;

import com.albedo.java.common.core.cache.model.CacheKey;
import org.springframework.lang.NonNull;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.function.Function;

/**
 * 基于MP的 IService 新增了3个方法： getByIdCache
 * 其中：
 * 1，getByIdCache 方法 会先从缓存查询，后从DB查询 （取决于实现类）
 * 2、SuperService 上的方法
 *
 * @param <T> 实体
 * @author somewhere
 * @date 2020年03月03日20:49:03
 */
public interface CacheService<T> extends BaseService<T> {

	/**
	 * 根据id 先查缓存，再查db
	 *
	 * @param id 主键
	 * @return 对象
	 */
	T getByIdCache(Serializable id);

	/**
	 * 根据 key 查询缓存中存放的id，缓存不存在根据loader加载并写入数据，然后根据查询出来的id查询 实体
	 *
	 * @param key    缓存key
	 * @param loader 加载器
	 * @return 对象
	 */
	T getByKey(CacheKey key, Function<CacheKey, Object> loader);

	/**
	 * 可能会缓存穿透
	 *
	 * @param ids    主键id
	 * @param loader 回调
	 * @return 对象集合
	 */
	List<T> findByIds(@NonNull Collection<? extends Serializable> ids, Function<Collection<? extends Serializable>, Collection<T>> loader);

	/**
	 * 刷新缓存
	 */
	void refreshCache();

	/**
	 * 清理缓存
	 */
	void clearCache();

}
