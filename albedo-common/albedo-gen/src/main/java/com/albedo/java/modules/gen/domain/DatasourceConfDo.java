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

package com.albedo.java.modules.gen.domain;

import com.albedo.java.common.core.basic.domain.IdDo;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * 数据源Entity 数据源
 *
 * @author somewhere
 * @version 2020-09-20 09:36:15
 */
@TableName(value = "gen_datasource_conf")
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class DatasourceConfDo extends IdDo<DatasourceConfDo, String> {

	/**
	 * F_NAME name : 名称
	 */
	public static final String F_NAME = "name";

	/**
	 * F_URL url : url
	 */
	public static final String F_URL = "url";

	/**
	 * F_USERNAME username : 用户名
	 */
	public static final String F_USERNAME = "username";

	/**
	 * F_PASSWORD password : 密码
	 */
	public static final String F_PASSWORD = "password";

	private static final long serialVersionUID = 1L;

	/**
	 * name 名称
	 */
	@Size(max = 64)

	private String name;

	/**
	 * url url
	 */
	@NotBlank
	@Size(max = 255)

	private String url;

	/**
	 * username 用户名
	 */
	@NotBlank
	@Size(max = 64)

	private String username;

	/**
	 * password 密码
	 */
	@Size(max = 64)

	private String password;

	@Override
	public boolean equals(Object o) {
		return super.equals(o);
	}

	@Override
	public int hashCode() {
		return super.hashCode();
	}

}
