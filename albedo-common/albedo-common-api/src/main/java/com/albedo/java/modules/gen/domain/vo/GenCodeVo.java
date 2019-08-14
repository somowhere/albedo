package com.albedo.java.modules.gen.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;

/**
 * 生成方案Entity
 *
 * @version 2013-10-15
 */
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class GenCodeVo implements Serializable {

	private String id;
	/**
	 * 是否替换现有文件 true：替换文件 ；false：不替换；
	 */
	private Boolean replaceFile = false;

}
