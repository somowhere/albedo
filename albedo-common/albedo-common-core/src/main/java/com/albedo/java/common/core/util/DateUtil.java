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


import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
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
