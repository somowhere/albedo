package com.albedo.java.modules.tenant.enumeration;

import com.albedo.java.common.core.enumeration.BaseEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.stream.Stream;

/**
 * <p>
 * 实体注释中生成的类型枚举
 * 企业
 * </p>
 *
 * @author somewhere
 * @date 2020-11-19
 */
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "TenantTypeEnum", description = "类型-枚举")
public enum TenantTypeEnum implements BaseEnum {

	/**
	 * CREATE="创建"
	 */
	CREATE("创建"),
	/**
	 * REGISTER="注册"
	 */
	REGISTER("注册"),
	;

	@Schema(name = "描述")
	private String text;


	/**
	 * 根据当前枚举的name匹配
	 */
	public static TenantTypeEnum match(String val, TenantTypeEnum def) {
		return Stream.of(values()).parallel().filter(item -> item.name().equalsIgnoreCase(val)).findAny().orElse(def);
	}

	public static TenantTypeEnum get(String val) {
		return match(val, null);
	}

	public boolean eq(TenantTypeEnum val) {
		return val != null && eq(val.name());
	}

	@Override
	@Schema(name = "编码", allowableValues = "CREATE,REGISTER", example = "CREATE")
	public String getCode() {
		return this.name();
	}

}
