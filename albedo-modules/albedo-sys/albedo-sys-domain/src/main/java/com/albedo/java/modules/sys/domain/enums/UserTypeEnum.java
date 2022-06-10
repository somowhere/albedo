package com.albedo.java.modules.sys.domain.enums;

import com.albedo.java.common.core.enumeration.BaseEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.stream.Stream;

/**
 * 全局用户类型枚举
 */
@AllArgsConstructor
@Getter
public enum UserTypeEnum implements BaseEnum {

	MEMBER("会员"), // 面向 c 端，普通用户
	ADMIN("管理员"); // 面向 b 端，管理后台

	/**
	 * 类型名
	 */
	private final String text;

	public static UserTypeEnum match(String val, UserTypeEnum def) {
		return Stream.of(values()).parallel().filter((item) -> item.name().equalsIgnoreCase(val)).findAny().orElse(def);
	}

	public static UserTypeEnum get(String val) {
		return match(val, null);
	}


	public boolean eq(final UserTypeEnum val) {
		return val != null && eq(val.name());
	}

	@Override
	@Schema(name = "编码", allowableValues = "MEMBER,ADMIN")
	public String getCode() {
		return this.name();
	}
}
