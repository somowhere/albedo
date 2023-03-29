/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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
@Schema(name = "JobStatus", description = "任务状态-枚举")
public enum JobStatus implements BaseEnum {

	RUNNING("运行中"),
	PAUSE("暂停");

	@Schema(name = "描述")
	private String text;


	/**
	 * 根据当前枚举的name匹配
	 */
	public static JobStatus match(String val, JobStatus def) {
		return Stream.of(values()).parallel().filter(item -> item.name().equalsIgnoreCase(val)).findAny().orElse(def);
	}

	public static JobStatus get(String val) {
		return match(val, null);
	}

	public boolean eq(JobStatus val) {
		return val != null && eq(val.name());
	}

	@Override
	@Schema(name = "任务状态", allowableValues = "RUNNING,PAUSE", example = "RUNNING")
	public String getCode() {
		return this.name();
	}


}
