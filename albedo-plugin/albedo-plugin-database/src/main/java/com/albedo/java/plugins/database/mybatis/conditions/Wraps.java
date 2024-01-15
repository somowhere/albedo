package com.albedo.java.plugins.database.mybatis.conditions;


import com.albedo.java.plugins.database.mybatis.query.LambdaQueryWrapperX;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;


/**
 * Wrappers 工具类， 该方法的主要目的是为了 缩短代码长度
 *
 * @author somewhere
 * @date 2019/06/14
 */
public final class Wraps {

	private Wraps() {
		// ignore
	}

	/**
	 * 获取 QueryWrap&lt;T&gt;
	 *
	 * @param <T> 实体类泛型
	 * @return QueryWrapper&lt;T&gt;
	 */
	public static <T> LambdaQueryWrapperX<T> lambdaQueryWrapperX() {
		return new LambdaQueryWrapperX<>();
	}


	/**
	 * 获取 QueryWrap&lt;T&gt;
	 *
	 * @param <T> 实体类泛型
	 * @return QueryWrapper&lt;T&gt;
	 */
	public static <T> LambdaUpdateWrapper<T> lambdaUpdateWrapper() {
		return new LambdaUpdateWrapper<>();
	}
}
