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
@ApiModel(value = "JobLogStatus", description = "任务日志状态-枚举")
public enum JobLogStatus implements BaseEnum {

	SUCCESS("T", "正常"),
	FAILURE("F", "失败");

	@ApiModelProperty(value = "值")
	private String val;
	@ApiModelProperty(value = "描述")
	private String desc;


	/**
	 * 根据当前枚举的name匹配
	 */
	public static JobLogStatus match(String val, JobLogStatus def) {
		return Stream.of(values()).parallel().filter(item -> item.getVal().equalsIgnoreCase(val)).findAny().orElse(def);
	}

	public static JobLogStatus get(String val) {
		return match(val, null);
	}

	public boolean eq(JobLogStatus val) {
		return val != null && eq(val.getVal());
	}

	@Override
	@ApiModelProperty(value = "任务日志状态", allowableValues = "T,F", example = "T")
	public String getCode() {
		return this.getVal();
	}


}
