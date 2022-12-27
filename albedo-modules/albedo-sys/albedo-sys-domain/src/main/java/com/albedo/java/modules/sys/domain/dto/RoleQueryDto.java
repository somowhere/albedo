/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.domain.dto;

import com.albedo.java.common.core.util.DateUtil;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * @author somewhere
 * @date 2020-05-10
 */
@Data
public class RoleQueryDto implements Serializable {

	private String blurry;

	private Integer available;

	@Schema(name = "创建时间", example = "[2022-07-01 00:00:00,2022-07-01 23:59:59]")
	@DateTimeFormat(pattern = DateUtil.TIME_FORMAT)
	private LocalDateTime[] createdDate;

}
