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

package com.albedo.java.common.core.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 自定义导出Excel数据注解
 *
 * @author somewhere
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface ExcelField {
	/**
	 * 导出到Excel中的名字.
	 */
	String title() default "";

	/**
	 * 日期格式, 如: yyyy-MM-dd
	 */
	String dateFormat() default "";

	/**
	 * 读取内容转表达式 (如: 0=男,1=女,2=未知)
	 */
	String readConverterExp() default "";

	/**
	 * 如果是字典类型，请设置字典的type值
	 */
	String dictType() default "";

	/**
	 * 导出类型（0数字 1字符串）
	 */
	ColumnType cellType() default ColumnType.STRING;

	/**
	 * 导出时在excel中每个列的高度 单位为字符
	 */
	double height() default 14;

	/**
	 * 导出时在excel中每个列的宽 单位为字符
	 */
	double width() default 16;

	/**
	 * 文字后缀,如% 90 变成90%
	 */
	String suffix() default "";

	/**
	 * 当值为空时,字段的默认值
	 */
	String defaultValue() default "";

	/**
	 * 提示信息
	 */
	String prompt() default "";

	/**
	 * 设置只能选择不能输入的列内容.
	 */
	String[] combo() default {};

	/**
	 * 是否导出数据,应对需求:有时我们需要导出一份模板,这是标题需要但内容需要用户手工填写.
	 */
	boolean isExport() default true;

	/**
	 * 另一个类中的属性名称,支持多级获取,以小数点隔开
	 */
	String targetAttr() default "";

	/**
	 * 字段类型（0：导出导入；1：仅导出；2：仅导入）
	 */
	Type type() default Type.ALL;

	/**
	 * 支持类型，全部，导出，导入
	 */
	enum Type {

		/**
		 * 全部
		 */
		ALL(0),
		/**
		 * 导出
		 */
		EXPORT(1),
		/**
		 * 导入
		 */
		IMPORT(2);
		private final int value;

		Type(int value) {
			this.value = value;
		}

		public int value() {
			return this.value;
		}
	}

	/**
	 * 列类型
	 */
	enum ColumnType {
		/**
		 * 数字
		 */
		NUMERIC(0),
		/**
		 * 字符串
		 */
		STRING(1);
		private final int value;

		ColumnType(int value) {
			this.value = value;
		}

		public int value() {
			return this.value;
		}
	}
}
