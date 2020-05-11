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

package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.ResultBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.util.ExcelUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.domain.dto.UserQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.UserExcelVo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.service.UserService;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.math.BigDecimal;
import java.util.List;
import java.util.Set;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@RestController
@RequestMapping("${application.admin-path}/sys/user")
@AllArgsConstructor
public class UserResource  extends BaseResource {

	private final UserService userService;
	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_user_view')")
	public R get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return R.buildOkData(userService.getUserDtoById(id));
	}

	/**
	 * 获取当前用户全部信息
	 *
	 * @return 用户信息
	 */
	@GetMapping(value = {"/info"})
	public R info() {
		String username = SecurityUtil.getUser().getUsername();
		UserVo userVo = userService.getOneVoByUserName(username);
		if (userVo == null) {
			return R.buildFail("获取当前用户信息失败");
		}
		return R.buildOkData(userService.getUserInfo(userVo));
	}

	/**
	 * 获取指定用户全部信息
	 *
	 * @return 用户信息
	 */
	@GetMapping("/info/{username}")
	public R info(@PathVariable String username) {
		UserVo userVo = userService.getOneVoByUserName(username);
		if (userVo == null) {
			return R.buildFail(String.format("用户信息为空 %s", username));
		}
		return R.buildOkData(userService.getUserInfo(userVo));
	}

	/**
	 * 删除用户
	 *
	 * @param ids
	 * @return
	 */
	@Log(value = "用户管理", businessType = BusinessType.DELETE)
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('sys_user_del')")
	public R removeByIds(@RequestBody Set<String> ids) {
		userService.removeByIds(ids);
		return R.buildOk("操作成功");
	}

	/**
	 * 添加/更新用户信息
	 *
	 * @param userDto 用户信息
	 * @return R
	 */
	@Log(value = "用户管理", businessType = BusinessType.EDIT)
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_user_edit')")
	public R saveUser(@Valid @RequestBody UserDto userDto) {
		log.debug("REST request to save userDataVo : {}", userDto);
		// beanValidatorAjax(user);
		if (StringUtil.isNotEmpty(userDto.getPassword()) &&
			!userDto.getPassword().equals(userDto.getConfirmPassword())) {
			throw new RuntimeMsgException("两次输入密码不一致");
		}

		userService.saveOrUpdate(userDto);
		return R.buildOk("操作成功");
	}

	/**
	 * 分页查询用户
	 *
	 * @param pm 参数集
	 * @return 用户集合
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('sys_user_view')")
	public R getUserPage(PageModel pm, UserQueryCriteria userQueryCriteria) {
		return R.buildOkData(userService.getUserPage(pm, userQueryCriteria, SecurityUtil.getUser().getDataScope()));
	}

	/**
	 * @param username 用户名称
	 * @return 上级部门用户列表
	 */
	@GetMapping("/ancestor/{username}")
	public R listAncestorUsers(@PathVariable String username) {
		return new R<>(userService.listAncestorUsersByUsername(username));
	}


	/**
	 * @param ids
	 * @return
	 */
	@PutMapping
	@Log(value = "用户管理", businessType = BusinessType.LOCK)
	@PreAuthorize("@pms.hasPermission('sys_user_lock')")
	public R lockOrUnLock(@RequestBody Set<String> ids) {
		userService.lockOrUnLock(ids);
		return R.buildOk("操作成功");
	}


	@PostMapping(value = "/upload")
	@PreAuthorize("@pms.hasPermission('sys_user_upload')")
	@Log(value = "用户管理", businessType = BusinessType.IMPORT)
	public ResponseEntity uploadData(@RequestParam("uploadFile") MultipartFile dataFile, HttpServletResponse response) throws Exception {
		if (dataFile.isEmpty()) {
			return ResultBuilder.buildFail("上传文件为空");
		}
		ExcelUtil<UserExcelVo> util = new ExcelUtil(UserExcelVo.class);
		List<UserExcelVo> dataList = util.importExcel(dataFile.getInputStream());
		for (UserExcelVo userExcelVo : dataList) {
			if (userExcelVo.getPhone().length() != 11) {
				BigDecimal bd = new BigDecimal(userExcelVo.getPhone());
				userExcelVo.setPhone(bd.toPlainString());
			}
			userService.save(userExcelVo);
		}
		return ResultBuilder.buildOk("操作成功");

	}

	@GetMapping(value = "/importTemplate")
	@PreAuthorize("@pms.hasPermission('sys_user_view')")
	public R importTemplate() {
		ExcelUtil<UserExcelVo> util = new ExcelUtil(UserExcelVo.class);
		return util.exportExcel(Lists.newArrayList(new UserExcelVo()), "操作日志");
	}

}
