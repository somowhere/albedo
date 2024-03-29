package com.albedo.java.modules.quartz.domain.enums;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.enumeration.BaseEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.stream.Stream;

/**
 * @author somewhere
 */
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "JobConcurrent", description = "任务是否并发执行-枚举")
public enum JobConcurrent implements BaseEnum {

	YES(CommonConstants.STR_YES, "是"),
	NO(CommonConstants.STR_NO, "否");

	@Schema(name = "值")
	private String value;
	@Schema(name = "描述")
	private String text;


	/**
	 * 根据当前枚举的name匹配
	 */
	public static JobConcurrent match(String val, JobConcurrent def) {
		return Stream.of(values()).parallel().filter(item -> item.getValue().equalsIgnoreCase(val)).findAny().orElse(def);
	}

	public static JobConcurrent get(String val) {
		return match(val, null);
	}

	public boolean eq(JobConcurrent val) {
		return val != null && eq(val.getValue());
	}

	@Override
	@Schema(name = "任务是否并发执行", allowableValues = "1,0", example = "1")
	public String getCode() {
		return this.getValue();
	}


}

