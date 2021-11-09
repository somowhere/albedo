/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.common.core.util;

import cn.hutool.core.date.LocalDateTimeUtil;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:24 下午
 */
public class DateUtil extends cn.hutool.core.date.DateUtil {

	/**
	 * 时间格式：yyyy-MM-dd HH:mm:ss
	 */
	public static final String TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";

	/**
	 * 时间格式：yyyy-MM-dd
	 */
	public static final String DATE_FORMAT = "yyyy-MM-dd";

	public static final String DATE_FORMAT_SLASH = "yyyy/MM/dd";

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
		return format(now, DATE_FORMAT_SLASH);
	}

	/**
	 * 计算开始时间
	 *
	 * @param time 日期
	 * @return 计算开始时间
	 */
	public static LocalDateTime getStartTime(String time) {
		String startTime = time;
		if (time.matches("^\\d{4}-\\d{1,2}$")) {
			startTime = time + "-01 00:00:00";
		} else if (time.matches("^\\d{4}-\\d{1,2}-\\d{1,2}$")) {
			startTime = time + " 00:00:00";
		} else if (time.matches("^\\d{4}-\\d{1,2}-\\d{1,2} {1}\\d{1,2}:\\d{1,2}$")) {
			startTime = time + ":00";
		} else if (time.matches("^\\d{4}-\\d{1,2}-\\d{1,2}T{1}\\d{1,2}:\\d{1,2}:\\d{1,2}.\\d{3}Z$")) {
			startTime = time.replace("T", " ").substring(0, time.indexOf('.'));
		}
		return LocalDateTimeUtil.beginOfDay(LocalDateTime.parse(startTime, DateTimeFormatter.ofPattern(TIME_FORMAT)));
	}

	/**
	 * 计算结束时间
	 *
	 * @param time 日期
	 * @return 结束时间
	 */
	public static LocalDateTime getEndTime(String time) {
		String startTime = time;
		if (time.matches("^\\d{4}-\\d{1,2}$")) {
			Date date = DateUtil.parse(time, "yyyy-MM");
			date = DateUtil.getLastDateOfMonth(date);
			startTime = DateUtil.formatAsDate(date) + " 23:59:59";
		} else if (time.matches("^\\d{4}-\\d{1,2}-\\d{1,2}$")) {
			startTime = time + " 23:59:59";
		} else if (time.matches("^\\d{4}-\\d{1,2}-\\d{1,2} {1}\\d{1,2}:\\d{1,2}$")) {
			startTime = time + ":59";
		} else if (time.matches("^\\d{4}-\\d{1,2}-\\d{1,2}T{1}\\d{1,2}:\\d{1,2}:\\d{1,2}.\\d{3}Z$")) {
			time = time.replace("T", " ").substring(0, time.indexOf('.'));
			startTime = time;
		}
		return LocalDateTimeUtil.endOfDay(LocalDateTime.parse(startTime, DateTimeFormatter.ofPattern(TIME_FORMAT)));
	}


	/**
	 * 格式化日期,返回格式为 yyyy-MM-dd
	 *
	 * @param date 日期
	 * @return 格式化后的字符串
	 */
	public static String formatAsDate(Date date) {
		SimpleDateFormat df = new SimpleDateFormat(DATE_FORMAT);
		return df.format(date);
	}


	/**
	 * 获取当月最后一天
	 *
	 * @param date 日期
	 * @return 当月最后一天
	 */
	public static Date getLastDateOfMonth(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, 1);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		return calendar.getTime();
	}

}
