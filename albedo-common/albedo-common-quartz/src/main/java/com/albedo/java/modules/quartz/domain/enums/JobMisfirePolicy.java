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

package com.albedo.java.modules.quartz.domain.enums;

import com.albedo.java.common.core.enumeration.BaseEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
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
@ApiModel(value = "JobMisfirePolicy", description = "计划执行错误策略-枚举")
public enum JobMisfirePolicy implements BaseEnum {

	EXECUTE_DEFAULT("默认"),
	IGNORE_MISFIRES("立即执行"),
	FIRE_PROCEED("执行一次"),
	EXECUTE_STOP("放弃执行");

	@ApiModelProperty(value = "描述")
	private String text;


	/**
	 * 根据当前枚举的name匹配
	 */
	public static JobMisfirePolicy match(String val, JobMisfirePolicy def) {
		return Stream.of(values()).parallel().filter(item -> item.name().equalsIgnoreCase(val)).findAny().orElse(def);
	}

	public static JobMisfirePolicy get(String val) {
		return match(val, null);
	}

	public boolean eq(JobMisfirePolicy val) {
		return val != null && eq(val.name());
	}

	@Override
	@ApiModelProperty(value = "计划执行错误策略", allowableValues = "EXECUTE_NOW,EXECUTE_ONCE,EXECUTE_STOP", example = "EXECUTE_NOW")
	public String getCode() {
		return this.name();
	}


}
