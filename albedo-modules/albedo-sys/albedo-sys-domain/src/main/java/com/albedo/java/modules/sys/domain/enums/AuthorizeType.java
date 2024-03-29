package com.albedo.java.modules.sys.domain.enums;

import com.albedo.java.common.core.enumeration.BaseEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.stream.Stream;

/**
 * <p>
 * 实体注释中生成的类型枚举
 * 角色的资源
 * </p>
 *
 * @author somewhere
 * @date 2020-11-20
 */
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "AuthorizeType", description = "权限类型-枚举")
public enum AuthorizeType implements BaseEnum {

	/**
	 * MENU="菜单"
	 */
	MENU("菜单"),
	/**
	 * RESOURCE="资源"
	 */
	RESOURCE("资源"),
	;

	@Schema(name = "描述")
	private String text;


	/**
	 * 根据当前枚举的name匹配
	 */
	public static AuthorizeType match(String val, AuthorizeType def) {
		return Stream.of(values()).parallel().filter(item -> item.name().equalsIgnoreCase(val)).findAny().orElse(def);
	}

	public static AuthorizeType get(String val) {
		return match(val, null);
	}

	public boolean eq(AuthorizeType val) {
		return val != null && eq(val.name());
	}

	@Override
	@Schema(name = "编码", allowableValues = "MENU,RESOURCE", example = "MENU")
	public String getCode() {
		return this.name();
	}

}
