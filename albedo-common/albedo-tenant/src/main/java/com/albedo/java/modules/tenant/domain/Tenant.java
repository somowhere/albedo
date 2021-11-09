package com.albedo.java.modules.tenant.domain;

import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.basic.domain.IdEntity;
import com.albedo.java.common.core.util.DateUtil;
import com.albedo.java.modules.tenant.enumeration.TenantConnectTypeEnum;
import com.albedo.java.modules.tenant.enumeration.TenantStatusEnum;
import com.albedo.java.modules.tenant.enumeration.TenantTypeEnum;
import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.SqlCondition;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;

/**
 * <p>
 * 实体类
 * 企业
 * </p>
 *
 * @author somewhere
 * @since 2020-11-19
 */
@Data
@NoArgsConstructor
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("sys_tenant")
@AllArgsConstructor
public class Tenant extends IdEntity<Tenant, Long> {

	private static final long serialVersionUID = 1L;

	/**
	 * 企业编码
	 */
	@ApiModelProperty(value = "企业编码")
	@NotEmpty(message = "企业编码不能为空")
	@Size(max = 20, message = "企业编码长度不能超过20")
	@TableField(value = "code", condition = SqlCondition.LIKE)
	@ExcelField(title = "企业编码", width = 20)
	private String code;

	/**
	 * 企业名称
	 */
	@ApiModelProperty(value = "企业名称")
	@Size(max = 255, message = "企业名称长度不能超过255")
	@TableField(value = "name", condition = SqlCondition.LIKE)
	@ExcelField(title = "企业名称", width = 20)
	private String name;

	/**
	 * 类型
	 * #{CREATE:创建;REGISTER:注册} 0=男,1=女,2=未知
	 */
	@ApiModelProperty(value = "类型")
	@TableField("type")
	@ExcelField(title = "类型", width = 20, readConverterExp = "CREATE=创建,REGISTER=注册")
	private TenantTypeEnum type;

	/**
	 * 连接类型
	 * #TenantConnectTypeEnum{LOCAL:本地;REMOTE:远程}
	 */
	@ApiModelProperty(value = "连接类型")
	@TableField("connect_type")
	@ExcelField(title = "连接类型", width = 20, readConverterExp = "LOCAL=本地,REMOTE=远程")
	private TenantConnectTypeEnum connectType;

	/**
	 * 状态
	 * #{NORMAL:正常;WAIT_INIT:待初始化;FORBIDDEN:禁用;WAITING:待审核;REFUSE:拒绝;DELETE:已删除}
	 */
	@ApiModelProperty(value = "状态")
	@TableField("status")
	@ExcelField(title = "状态", width = 20, readConverterExp = "NORMAL=正常,WAIT_INIT=待初始化,FORBIDDEN=禁用,WAITING=待审核,REFUSE=拒绝,DELETE=已删除")
	private TenantStatusEnum status;

	/**
	 * 内置
	 */
	@ApiModelProperty(value = "内置")
	@TableField("readonly_")
	@ExcelField(title = "内置", readConverterExp = "true=是,false=否")
	private Boolean readonly;

	/**
	 * 责任人
	 */
	@ApiModelProperty(value = "责任人")
	@Size(max = 50, message = "责任人长度不能超过50")
	@TableField(value = "duty", condition = SqlCondition.LIKE)
	@ExcelField(title = "责任人")
	private String duty;

	/**
	 * 有效期
	 * 为空表示永久
	 */
	@ApiModelProperty(value = "有效期")
	@TableField(value = "expiration_time", updateStrategy = FieldStrategy.IGNORED)
	@ExcelField(title = "有效期", dateFormat = DateUtil.TIME_FORMAT, width = 20)
	private LocalDateTime expirationTime;

	/**
	 * logo地址
	 */
	@ApiModelProperty(value = "logo地址")
	@Size(max = 255, message = "logo地址长度不能超过255")
	@TableField(value = "logo", condition = SqlCondition.LIKE)
	private String logo;

	/**
	 * 企业简介
	 */
	@ApiModelProperty(value = "企业简介")
	@Size(max = 255, message = "企业简介长度不能超过255")
	@TableField(value = "describe_", condition = SqlCondition.LIKE)
	@ExcelField(title = "企业简介", width = 20)
	private String describe;


	@Builder
	public Tenant(Long id, LocalDateTime createdDate, Long createdBy, LocalDateTime lastModifiedDate, Long lastModifiedBy,
				  String code, String name, TenantTypeEnum type, TenantConnectTypeEnum connectType, TenantStatusEnum status,
				  Boolean readonly, String duty, LocalDateTime expirationTime, String logo, String describe) {
		this.id = id;
		this.createdDate = createdDate;
		this.createdBy = createdBy;
		this.lastModifiedDate = lastModifiedDate;
		this.lastModifiedBy = lastModifiedBy;
		this.code = code;
		this.name = name;
		this.type = type;
		this.connectType = connectType;
		this.status = status;
		this.readonly = readonly;
		this.duty = duty;
		this.expirationTime = expirationTime;
		this.logo = logo;
		this.describe = describe;
	}

}
