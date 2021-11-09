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
 * @author somewhere
 * @since 2020-11-20
 */
@Data
@NoArgsConstructor
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("sys_application")
@ApiModel(value = "Application", description = "应用")
@AllArgsConstructor
public class Application extends IdEntity<Application, Long> {

	private static final long serialVersionUID = 1L;

	/**
	 * 客户端ID
	 */
	@ApiModelProperty(value = "客户端ID")
	@Size(max = 24, message = "客户端ID长度不能超过24")
	@TableField(value = "client_id", condition = LIKE)
	@ExcelField(title = "客户端ID")
	private String clientId;

	/**
	 * 客户端密码
	 */
	@ApiModelProperty(value = "客户端密码")
	@Size(max = 32, message = "客户端密码长度不能超过32")
	@TableField(value = "client_secret", condition = LIKE)
	@ExcelField(title = "客户端密码")
	private String clientSecret;

	/**
	 * 官网
	 */
	@ApiModelProperty(value = "官网")
	@Size(max = 100, message = "官网长度不能超过100")
	@TableField(value = "website", condition = LIKE)
	@ExcelField(title = "官网")
	private String website;

	/**
	 * 应用名称
	 */
	@ApiModelProperty(value = "应用名称")
	@NotEmpty(message = "应用名称不能为空")
	@Size(max = 255, message = "应用名称长度不能超过255")
	@TableField(value = "name", condition = LIKE)
	@ExcelField(title = "应用名称")
	private String name;

	/**
	 * 应用图标
	 */
	@ApiModelProperty(value = "应用图标")
	@Size(max = 255, message = "应用图标长度不能超过255")
	@TableField(value = "icon", condition = LIKE)
	@ExcelField(title = "应用图标")
	private String icon;

	/**
	 * 类型
	 * #{SERVER:服务应用;APP:手机应用;PC:PC网页应用;WAP:手机网页应用}
	 */
	@ApiModelProperty(value = "类型")
	@TableField("app_type")
	@ExcelField(title = "类型", readConverterExp = "SERVER-服务应用,APP-手机应用,PC-PC网页应用,WAP-手机网页应用")
	private ApplicationAppTypeEnum appType;

	/**
	 * 备注
	 */
	@ApiModelProperty(value = "备注")
	@Size(max = 200, message = "备注长度不能超过200")
	@TableField(value = "describe_", condition = LIKE)
	@ExcelField(title = "备注")
	private String describe;

	/**
	 * 状态
	 */
	@ApiModelProperty(value = "状态")
	@TableField("state")
	@ExcelField(title = "状态", readConverterExp = "true=是,false=否")
	private Boolean state;


	@Builder
	public Application(Long id, Long createdBy, LocalDateTime createdDate, Long lastModifiedBy, LocalDateTime lastModifiedDate,
					   String clientId, String clientSecret, String website, String name, String icon,
					   ApplicationAppTypeEnum appType, String describe, Boolean state) {
		this.id = id;
		this.createdBy = createdBy;
		this.createdDate = createdDate;
		this.lastModifiedBy = lastModifiedBy;
		this.lastModifiedDate = lastModifiedDate;
		this.clientId = clientId;
		this.clientSecret = clientSecret;
		this.website = website;
		this.name = name;
		this.icon = icon;
		this.appType = appType;
		this.describe = describe;
		this.state = state;
	}

}
