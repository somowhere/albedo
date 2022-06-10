
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

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.vo.TreeDto;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;

/**
 * <p>
 * 字典表
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class DictDto extends TreeDto {

	public static final String F_VAL = "val";

	public static final String F_CODE = "code";

	public static final String F_AVAILABLE = "available";

	public static final String F_SQL_AVAILABLE = "available";

	public static final String CACHE_GET_DICT_ALL = "getDictAll";

	public static final String CACHE_DICT_DETAILS = "dict_details";

	private static final long serialVersionUID = 1L;

	/**
	 * 数据值
	 */
	private String val;

	private Integer available = CommonConstants.YES;

	/**
	 * 类型
	 */
	@NotBlank(message = "字典项数据类型不能为空")
	private String code;


}
