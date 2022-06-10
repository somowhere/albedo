package com.albedo.java.modules.tenant.domain.dto;

import com.albedo.java.modules.tenant.enumeration.TenantConnectTypeEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

/**
 * 租户连接
 *
 * @author somewhere
 * @date 2020/8/25 上午8:56
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Builder
@Schema(name = "TenantConnectDto", description = "租户连接")
public class TenantConnectDto {
	@Schema(name = "企业ID")
	@NotNull(message = "ID不能为空")
	private Long id;
	@NotEmpty(message = "企业编码不能为空")
	private String tenant;
	/**
	 * LOCAL： 同一个数据库(物理)，链接不同的数据库实例. 从mysql.yml中读取master数据源来自动新增其他数据库
	 * REMOTE： 不同的数据库(物理)，需要先在DatasourceConfig表配置链接源信息，然后指定以下字段（xxxDatasource）
	 */
	@Schema(name = "连接类型", example = "LOCAL,REMOTE")
	@NotNull(message = "连接类型不能为空")
	private TenantConnectTypeEnum connectType;

	@Schema(name = "权限服务连接源")
	private Long authorityDatasource;
	@Schema(name = "文件服务连接源")
	private Long fileDatasource;
	@Schema(name = "消息服务连接源")
	private Long msgDatasource;
	@Schema(name = "认证服务连接源")
	private Long oauthDatasource;
	@Schema(name = "网关服务连接源")
	private Long gateDatasource;
}
