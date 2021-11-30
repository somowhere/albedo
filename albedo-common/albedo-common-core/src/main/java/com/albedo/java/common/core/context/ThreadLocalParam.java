package com.albedo.java.common.core.context;

import lombok.Builder;
import lombok.Data;

import java.io.Serializable;

/**
 * 线程变量封装的参数
 *
 * @author somewhere
 * @date 2020/11/1 2:10 下午
 */
@Data
@Builder
public class ThreadLocalParam implements Serializable {
	private Boolean boot;
	private String tenant;
	private Long userId;
	private String username;
}
