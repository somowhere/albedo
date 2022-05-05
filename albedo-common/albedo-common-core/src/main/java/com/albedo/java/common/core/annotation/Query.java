/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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
 * @author somewhere
 * @date 2019-6-4 13:52:30
 */
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Query {

	String propName() default "";

	Operator operator() default Operator.eq;

	/**
	 * 多字段模糊搜索，仅支持String类型字段，多个用逗号隔开, 如@Query(blurry = "email,username")
	 */
	String blurry() default "";

	/**
	 * 运算符
	 */
	enum Operator {

		/**
		 * 等于
		 */
		eq("="),

		/**
		 * 不等于
		 */
		ne("!="),

		/**
		 * 大于
		 */
		gt(">"),

		/**
		 * 小于
		 */
		lt("<"),

		/**
		 * 大于等于
		 */
		ge(">="),

		/**
		 * 小于等于
		 */
		le("<="),

		/**
		 * 类似
		 */
		like("like"),
		/**
		 * 类似
		 */
		likeLeft("likeLeft"),
		/**
		 * 类似
		 */
		likeRight("likeRight"),
		/**
		 * 类似
		 */
		notLike("notLike"),
		/**
		 * 类似
		 */
		between("between"),

		/**
		 * 包含
		 */
		in("in"),

		/**
		 * 包含
		 */
		notIn("not in"),

		/**
		 * 为Null
		 */
		isNull("is Null"),

		/**
		 * 不为Null
		 */
		isNotNull("is Not Null");

		private String operator;

		Operator(String operator) {
			this.operator = operator;
		}

		public String getOperator() {
			return operator;
		}

		public void setOperator(String operator) {
			this.operator = operator;
		}

	}

}
