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

import com.albedo.java.common.core.domain.GeneralDo;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;

/**
 * Persistent tokens are used by Spring Security to automatically log in users.
 *
 * @author somewhere
 */
@TableName("sys_persistent_token")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PersistentTokenDo extends GeneralDo<PersistentTokenDo> {

	private static final long serialVersionUID = 1L;

	private static final int MAX_USER_AGENT_LEN = 255;

	@TableId(type = IdType.INPUT)
	private String series;

	@JsonIgnore
	@NotNull
	@TableField("token_value")
	private String tokenValue;

	@TableField("token_date")
	private LocalDateTime tokenDate;

	/**
	 * an IPV6 address max length is 39 characters
	 */
	@Size(max = 39)
	@TableField("ip_address")
	private String ipAddress;

	@TableField("user_agent")
	private String userAgent;

	@JsonIgnore
	@TableField("user_id")
	private Long userId;

	private String username;

	/**
	 * 登录地址
	 */
	private String loginLocation;

	/**
	 * 浏览器类型
	 */
	private String browser;

	/**
	 * 操作系统
	 */
	private String os;

}
