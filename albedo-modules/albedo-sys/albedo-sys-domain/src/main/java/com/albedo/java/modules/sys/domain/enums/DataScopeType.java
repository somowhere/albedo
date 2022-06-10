package com.albedo.java.modules.sys.domain.enums;

import com.albedo.java.common.core.enumeration.BaseEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.stream.Stream;

/**
 * <p>
 * 实体注释中生成的类型枚举
 * 角色
 * </p>
 *
 * @author somewhere
 * @date 2019-07-21
 */
@Getter
@AllArgsConstructor
@Schema(name = "DataScopeType", description = "数据权限类型-枚举")
public enum DataScopeType implements BaseEnum {

	/**
	 * ALL=5全部
	 */
	ALL("全部"),
	/**
	 * THIS_LEVEL_CHILDREN=2本级以及子级
	 */
	THIS_LEVEL_CHILDREN("本级以及子级"),
	/**
	 * THIS_LEVEL=3本级
	 */
	THIS_LEVEL("本级"),
	/**
	 * SELF=4个人
	 */
	SELF("个人"),
	/**
	 * CUSTOMIZE=5自定义
	 */
	CUSTOMIZE("自定义"),
	;

	@Schema(name = "描述")
	private final String text;


	public static DataScopeType match(String val, DataScopeType def) {
		return Stream.of(values()).parallel().filter((item) -> item.name().equalsIgnoreCase(val)).findAny().orElse(def);
	}

	public static DataScopeType get(String val) {
		return match(val, null);
	}


	public boolean eq(final DataScopeType val) {
		return val != null && eq(val.name());
	}

	@Override
	@Schema(name = "编码", allowableValues = "ALL,THIS_LEVEL,THIS_LEVEL_CHILDREN,CUSTOMIZE,SELF", example = "ALL")
	public String getCode() {
		return this.name();
	}

}
