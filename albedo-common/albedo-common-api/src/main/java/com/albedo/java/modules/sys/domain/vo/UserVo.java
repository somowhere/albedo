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

package com.albedo.java.modules.sys.domain.vo;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.DictNameConstants;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.DataVo;
import com.albedo.java.modules.sys.domain.Role;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class UserVo extends DataVo<String> {

	public static final String F_USERNAME = "username";

	public static final String F_EMAIL = "email";

	public static final String F_PHONE = "phone";

	/**
	 * 用户名
	 */
	@ExcelField(title = "用户名")
	private String username;

	@ExcelField(title = "昵称")
	private String nickname;

	@JsonIgnore
	private String password;

	/**
	 * 是否启用
	 */
	@DictType(DictNameConstants.SYS_FLAG)
	@ExcelField(title = "是否启用", dictType = DictNameConstants.SYS_FLAG)
	private Integer available;

	/**
	 * 邮箱
	 */
	@ExcelField(title = "邮箱")
	private String email;

	/**
	 * 电话
	 */
	@ExcelField(title = "电话")
	private String phone;

	/**
	 * 头像
	 */
	private String avatar;

	/**
	 * 部门ID
	 */
	private String deptId;

	/**
	 * 部门名称
	 */
	@ExcelField(title = "部门名称")
	private String deptName;

	/**
	 * 微信openId
	 */
	private String wxOpenId;

	/**
	 * QQ openId
	 */
	private String qqOpenId;

	@ExcelField(title = "角色名称")
	private String roleNames;

	/**
	 * 角色ID
	 */
	@JsonIgnore
	private List<Role> roleList;

	@JsonIgnore
	private List<String> roleIdList;

	public List<String> getRoleIdList() {
		if (CollUtil.isEmpty(roleIdList) && CollUtil.isNotEmpty(roleList)) {
			roleIdList = CollUtil.extractToList(roleList, Role.F_ID);
		}
		return roleIdList;
	}

	public String getRoleNames() {
		if (ObjectUtil.isEmpty(roleNames) && CollUtil.isNotEmpty(roleList)) {
			roleNames = CollUtil.convertToString(roleList, Role.F_NAME, StringUtil.COMMA);
		}
		return roleNames;
	}

	public boolean isAvailable() {
		return CommonConstants.YES.equals(available);
	}

}
