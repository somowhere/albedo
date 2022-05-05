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

package com.albedo.java.common.core.vo;

import cn.hutool.core.builder.EqualsBuilder;
import cn.hutool.core.builder.HashCodeBuilder;

import java.io.Serializable;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:09
 */
public class Order implements Serializable {

	/**
	 * 默认方向
	 */
	private static final Direction DEFAULT_DIRECTION = Direction.desc;

	/**
	 * 属性
	 */
	private String property;

	/**
	 * 方向
	 */
	private Direction direction = DEFAULT_DIRECTION;

	/**
	 * 构造方法
	 */
	public Order() {
	}

	/**
	 * 构造方法
	 *
	 * @param property  属性
	 * @param direction 方向
	 */
	public Order(String property, Direction direction) {
		this.property = property;
		this.direction = direction;
	}

	/**
	 * 返回递增排序
	 *
	 * @param property 属性
	 * @return 递增排序
	 */
	public static Order asc(String property) {
		return new Order(property, Direction.asc);
	}

	/**
	 * 返回递减排序
	 *
	 * @param property 属性
	 * @return 递减排序
	 */
	public static Order desc(String property) {
		return new Order(property, Direction.desc);
	}

	@Override
	public String toString() {
		return property + " " + direction.name();
	}

	/**
	 * 获取属性
	 *
	 * @return 属性
	 */
	public String getProperty() {
		return property;
	}

	/**
	 * 设置属性
	 *
	 * @param property 属性
	 */
	public void setProperty(String property) {
		this.property = property;
	}

	/**
	 * 获取方向
	 *
	 * @return 方向
	 */
	public Direction getDirection() {
		return direction;
	}

	/**
	 * 设置方向
	 *
	 * @param direction 方向
	 */
	public void setDirection(Direction direction) {
		this.direction = direction;
	}

	/**
	 * 重写equals方法
	 *
	 * @param obj 对象
	 * @return 是否相等
	 */
	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		if (this == obj) {
			return true;
		}
		Order other = (Order) obj;
		return new EqualsBuilder().append(getProperty(), other.getProperty())
			.append(getDirection(), other.getDirection()).isEquals();
	}

	/**
	 * 重写hashCode方法
	 *
	 * @return HashCode
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(17, 37).append(getProperty()).append(getDirection()).toHashCode();
	}

	/**
	 * 方向
	 */
	public enum Direction {

		/**
		 * 递增
		 */
		asc,

		/**
		 * 递减
		 */
		desc

	}

}
