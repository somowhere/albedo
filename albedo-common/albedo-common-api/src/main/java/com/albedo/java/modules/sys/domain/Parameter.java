package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.basic.domain.IdEntity;
import com.albedo.java.modules.sys.domain.enums.ApplicationAppTypeEnum;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;

import static com.baomidou.mybatisplus.annotation.SqlCondition.LIKE;

/**
 * <p>
 * 实体类
 * 应用
 * </p>
 *
 * @author zuihou
 * @since 2020-11-20
 */
@Data
@NoArgsConstructor
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("sys_parameter")
@ApiModel(value = "Parameter", description = "参数")
@AllArgsConstructor
public class Parameter extends IdEntity<Parameter, Long> {

    private static final long serialVersionUID = 1L;

	/**
	 * 参数键
	 */
	@ApiModelProperty(value = "参数键")
	@NotEmpty(message = "参数键不能为空")
	@Size(max = 255, message = "参数键长度不能超过255")
	@TableField(value = "key_", condition = LIKE)
	@ExcelField(title = "参数键")
	private String key;

	/**
	 * 参数值
	 */
	@ApiModelProperty(value = "参数值")
	@NotEmpty(message = "参数值不能为空")
	@Size(max = 255, message = "参数值长度不能超过255")
	@TableField(value = "value", condition = LIKE)
	@ExcelField(title = "参数值")
	private String value;

	/**
	 * 参数名称
	 */
	@ApiModelProperty(value = "参数名称")
	@NotEmpty(message = "参数名称不能为空")
	@Size(max = 255, message = "参数名称长度不能超过255")
	@TableField(value = "name", condition = LIKE)
	@ExcelField(title = "参数名称")
	private String name;

	/**
	 * 描述
	 */
	@ApiModelProperty(value = "描述")
	@Size(max = 255, message = "描述长度不能超过255")
	@TableField(value = "describe_", condition = LIKE)
	@ExcelField(title = "描述")
	private String describe;

	/**
	 * 状态
	 */
	@ApiModelProperty(value = "状态")
	@TableField("state")
	@ExcelField(title = "状态", readConverterExp = "true=是,false=否")
	private Boolean state;

	/**
	 * 内置
	 */
	@ApiModelProperty(value = "内置")
	@TableField("readonly_")
	@ExcelField(title = "内置", readConverterExp = "true=是,false=否")
	private Boolean readonly;


	@Builder
	public Parameter(Long id, Long createdBy, LocalDateTime createdDate, Long lastModifiedBy, LocalDateTime lastModifiedDate,
					 String key, String value, String name, String describe, Boolean state, Boolean readonly) {
		this.id = id;
		this.createdBy = createdBy;
		this.createdDate = createdDate;
		this.lastModifiedBy = lastModifiedBy;
		this.lastModifiedDate = lastModifiedDate;
		this.key = key;
		this.value = value;
		this.name = name;
		this.describe = describe;
		this.state = state;
		this.readonly = readonly;
	}

}
