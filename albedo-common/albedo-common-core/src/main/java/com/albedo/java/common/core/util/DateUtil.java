package com.albedo.java.common.core.util;


import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class DateUtil extends cn.hutool.core.date.DateUtil {

	/**
	 * 时间格式：yyyy-MM-dd HH:mm:ss
	 */
	public static final String TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
	/**
	 * 时间格式：yyyy-MM-dd
	 */
	public static final String DATE_FORMAT = "yyyy-MM-dd";

	public static String format(ZonedDateTime val, String format) {
		return val == null ? null : val.format(DateTimeFormatter.ofPattern(format));
	}

	public static String format(ZonedDateTime val) {
		return format(val, TIME_FORMAT);
	}

	public static String format(Date val) {
		return format(val, TIME_FORMAT);
	}

	/**
	 * 日期路径 即年/月/日 如2018/08/08
	 */
	public static final String datePath() {
		Date now = new Date();
		return format(now, "yyyy/MM/dd");
	}
}
