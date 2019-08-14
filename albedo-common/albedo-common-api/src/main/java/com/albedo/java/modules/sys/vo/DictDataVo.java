/*
 *  Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.vo;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.vo.TreeEntityVo;
import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

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
public class DictDataVo extends TreeEntityVo {

	private static final long serialVersionUID = 1L;

	public static final String F_VAL = "val";
	public static final String F_CODE = "code";
	public static final String F_SHOW = "show";
	public static final String F_SQL_SHOW = "show";
	public static final String CACHE_GET_DICT_ALL = "getDictAll";
	public static final String CACHE_DICT_DETAILS = "dict_details";
	/**
	 * 数据值
	 */
//	@NotBlank(message = "字典项数据值不能为空")
	private String val;
	/**
	 * 类型
	 */
	@NotBlank(message = "字典项数据类型不能为空")
	private String code;
	@NotNull
	@TableField(F_SQL_SHOW)
	@DictType("sys_flag")
	private Integer show = 1;
	/**
	 * 备注信息
	 */
	private String remark;


}
