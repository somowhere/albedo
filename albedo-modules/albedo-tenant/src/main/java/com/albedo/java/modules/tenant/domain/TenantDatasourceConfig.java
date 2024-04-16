package com.albedo.java.modules.tenant.domain;

import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.domain.BaseDo;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;

import static com.baomidou.mybatisplus.annotation.SqlCondition.LIKE;

/**
 * <p>
 * 实体类
 * 租户数据源关系
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
@TableName("sys_tenant_datasource_config")
@Schema(name = "TenantDatasourceConfig", description = "租户数据源关系")
@AllArgsConstructor
public class TenantDatasourceConfig extends BaseDo<TenantDatasourceConfig> {

	private static final long serialVersionUID = 1L;
	protected Long createdBy;
	/**
	 * 创建时间
	 */
	@ExcelField(title = "创建时间")
	protected LocalDateTime createdDate;
	/*** 备注 */
	@ExcelField(title = "描述")
	protected String description;
	/**
	 * 编号
	 */
	@TableId(value = "id", type = IdType.ASSIGN_ID)
	private Long id;
	/**
	 * 租户id
	 */
	@Schema(name = "租户id")
	@NotNull(message = "租户id不能为空")
	@TableField("tenant_id")
	@ExcelField(title = "租户id")
	private Long tenantId;
	/**
	 * 数据源id
	 */
	@Schema(name = "数据源id")
	@NotNull(message = "数据源id不能为空")
	@TableField("datasource_config_id")
	@ExcelField(title = "数据源id")
	private Long datasourceConfigId;
	/**
	 * 服务
	 */
	@Schema(name = "服务")
	@NotEmpty(message = "服务不能为空")
	@Size(max = 100, message = "服务长度不能超过100")
	@TableField(value = "application", condition = LIKE)
	@ExcelField(title = "服务")
	private String application;

	@Builder
	public TenantDatasourceConfig(Long id, LocalDateTime createdDate, Long createdBy,
								  Long tenantId, Long datasourceConfigId, String application) {
		this.id = id;
		this.createdDate = createdDate;
		this.createdBy = createdBy;
		this.tenantId = tenantId;
		this.datasourceConfigId = datasourceConfigId;
		this.application = application;
	}

}
