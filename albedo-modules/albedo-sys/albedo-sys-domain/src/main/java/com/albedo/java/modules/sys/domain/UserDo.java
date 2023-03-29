
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

package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.core.domain.IdDo;
import com.albedo.java.modules.sys.domain.enums.Sex;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;
import lombok.experimental.Accessors;

/**
 * <p>
 * 用户表
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Getter
@Setter
@ToString
@Accessors(chain = true)
@TableName("sys_user")
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDo extends IdDo<UserDo, Long> {

	public static final String F_USERNAME = "username";

	private static final long serialVersionUID = 1L;

	/**
	 * 用户名
	 */
	private String username;

	private String nickname;

	private String password;

	/**
	 * 锁定标记
	 */
	private Integer available;

	/**
	 * 邮箱
	 */
	private String email;

	/**
	 * 电话
	 */
	private String phone;

	/**
	 * 头像
	 */
	private String avatar;

	private Sex sex;

	/**
	 * 部门ID
	 */
	private String deptId;

	/**
	 * 微信openId
	 */
	private String wxOpenId;

	/**
	 * QQ openId
	 */
	private String qqOpenId;

}
