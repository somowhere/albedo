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

package com.albedo.java.modules.sys.domain.vo;

import com.albedo.java.common.core.annotation.ExcelField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * @author somewhere
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UserExcelVo implements Serializable {

	@NotBlank
	@ExcelField(title = "部门名称")
	private String deptName;

	@NotBlank
	@ExcelField(title = "登录名称")
	private String username;

	private String password;

	@NotBlank
	@ExcelField(title = "姓名")
	private String name;

	@NotBlank
	@ExcelField(title = "电话")
	private String phone;

	@ExcelField(title = "邮箱")
	private String email;

	@NotBlank
	@ExcelField(title = "角色名称（多个，隔开）")
	private String roleName;

}
