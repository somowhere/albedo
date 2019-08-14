package com.albedo.java.modules.gen.domain.vo;

import com.albedo.java.common.core.vo.DataEntityVo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotEmpty;

/**
 * 生成方案Entity
 *
 * @version 2013-10-15
 */
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class SchemeVo extends DataEntityVo<String> {

	private static final long serialVersionUID = 1L;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 分类
	 */
	private String category;
	/**
	 * 视图类型 弹窗视图0 普通表格 1
	 */
	private Integer viewType;
	/**
	 * 生成包路径
	 */
	private String packageName;
	/**
	 * 生成模块名
	 */
	private String moduleName;
	/**
	 * 生成子模块名
	 */
	private String subModuleName;
	/**
	 * 生成功能名
	 */
	private String functionName;
	/**
	 * 生成功能名（简写）
	 */
	private String functionNameSimple;
	/**
	 * 生成功能作者
	 */
	private String functionAuthor;
	/**
	 * 业务表名
	 */
	@NotEmpty
	private String tableId;
	/**
	 * 业务表名
	 */
	private String tableName;
}
