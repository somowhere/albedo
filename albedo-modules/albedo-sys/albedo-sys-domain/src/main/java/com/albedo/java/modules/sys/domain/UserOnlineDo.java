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

package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.core.domain.BaseDo;
import com.albedo.java.modules.sys.domain.enums.OnlineStatus;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * 当前在线会话 sys_user_online
 *
 * @author somewhere
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_user_online")
public class UserOnlineDo extends BaseDo<UserOnlineDo> {

	private static final long serialVersionUID = 1L;

	/**
	 * 用户会话id
	 */
	@TableId(type = IdType.ASSIGN_ID)
	private String sessionId;

	/**
	 * 部门ID
	 */
	private Long deptId;

	/**
	 * 部门名称
	 */
	private String deptName;

	/**
	 * 登录userId
	 */
	private Long userId;

	/**
	 * 登录名称
	 */
	private String username;

	/**
	 * 登录IP地址
	 */
	private String ipAddress;

	/**
	 * 登录地址
	 */
	private String ipLocation;

	/**
	 * 操作系统
	 */
	private String userAgent;

	/**
	 * 浏览器类型
	 */
	private String browser;

	/**
	 * 操作系统
	 */
	private String os;

	/**
	 * session创建时间
	 */
	private LocalDateTime startTimestamp;

	/**
	 * session最后访问时间
	 */
	private LocalDateTime lastAccessTime;

	/**
	 * 超时时间，单位为分钟
	 */
	private Long expireTime;

	/**
	 * 在线状态
	 */
	private OnlineStatus status = OnlineStatus.ONLINE;

}
