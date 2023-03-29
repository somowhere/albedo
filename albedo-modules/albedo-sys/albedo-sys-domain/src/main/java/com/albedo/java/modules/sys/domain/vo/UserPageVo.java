
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

package com.albedo.java.modules.sys.domain.vo;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.DictNameConstants;
import com.albedo.java.common.core.domain.vo.DataVo;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.modules.sys.domain.RoleDo;
import com.albedo.java.modules.sys.domain.enums.Sex;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class UserPageVo extends DataVo<Long> {

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

	private String password;

	/**
	 * 是否启用
	 */
	@DictType(DictNameConstants.SYS_FLAG)
	@ExcelField(title = "是否启用", dictType = DictNameConstants.SYS_FLAG)
	private Integer available;

	/**
	 * 性别
	 */
	@ExcelField(title = "性别")
	private Sex sex;
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
	private Long deptId;

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
	private List<RoleDo> roleList;

	private List<Long> roleIdList;

	public List<Long> getRoleIdList() {
		if (CollUtil.isEmpty(roleIdList) && CollUtil.isNotEmpty(roleList)) {
			roleIdList = CollUtil.extractToList(roleList, RoleDo.F_ID);
		}
		return roleIdList;
	}

	public String getRoleNames() {
		if (ObjectUtil.isEmpty(roleNames) && CollUtil.isNotEmpty(roleList)) {
			roleNames = CollUtil.convertToString(roleList, RoleDo.F_NAME, StringUtil.COMMA);
		}
		return roleNames;
	}

	public boolean isAvailable() {
		return CommonConstants.YES.equals(available);
	}

}
