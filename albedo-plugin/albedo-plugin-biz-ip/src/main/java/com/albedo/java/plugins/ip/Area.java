package com.albedo.java.plugins.ip;

import com.albedo.java.plugins.ip.enums.AreaTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Area {

	/**
	 * 编号 - 全球，即根目录
	 */
	public static final Integer ID_GLOBAL = 0;
	/**
	 * 编号 - 中国
	 */
	public static final Integer ID_CHINA = 1;

	/**
	 * 编号
	 */
	private Integer id;
	/**
	 * 名字
	 */
	private String name;
	/**
	 * 类型
	 * <p>
	 * 枚举 {@link AreaTypeEnum}
	 */
	private Integer type;

	/**
	 * 父节点
	 */
	private Area parent;
	/**
	 * 子节点
	 */
	private List<Area> children;

}
