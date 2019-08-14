package com.albedo.java.common.persistence;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

public class Condition {
	public static <T> LambdaQueryWrapper<T> create() {
		return new QueryWrapper<T>().lambda();
	}
}
