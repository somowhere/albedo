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
import com.albedo.java.common.core.util.*;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.util.ExcelUtil;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.sys.domain.vo.UserDataVo;
import com.albedo.java.modules.sys.domain.vo.UserExcelVo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.google.common.collect.Lists;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.math.BigDecimal;
import java.util.List;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@RestController
@RequestMapping("${application.admin-path}/sys/user")
@Log4j2
public class UserResource extends DataVoResource<UserService, UserDataVo> {


	public UserResource(UserService service) {
		super(service);
	}

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_user_view')")
	public R get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return R.buildOkData(service.getUserVoById(id));
	}

	/**
	 * 获取当前用户全部信息
	 *
	 * @return 用户信息
	 */
	@GetMapping(value = {"/info"})
	public R info() {
		String username = SecurityUtil.getUser().getUsername();
		UserVo userVo = service.findOneVoByUserName(username);
		if (userVo == null) {
			return R.buildFail("获取当前用户信息失败");
		}
		return R.buildOkData(service.getUserInfo(userVo));
	}

	/**
	 * 获取指定用户全部信息
	 *
	 * @return 用户信息
	 */
	@GetMapping("/info/{username}")
	public R info(@PathVariable String username) {
		UserVo userVo = service.findOneVoByUserName(username);
		if (userVo == null) {
			return R.buildFail(String.format("用户信息为空 %s", username));
		}
		return R.buildOkData(service.getUserInfo(userVo));
	}

	/**
	 * 删除用户
	 *
	 * @param ids
	 * @return
	 */
	@Log(value = "用户管理", businessType = BusinessType.DELETE)
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_user_del')")
	public R removeByIds(@PathVariable String ids) {
		service.removeByIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.buildOk("操作成功");
	}

	/**
	 * 添加/更新用户信息
	 *
	 * @param userDataVo 用户信息
	 * @return R
	 */
	@Log(value = "用户管理", businessType = BusinessType.EDIT)
	@PostMapping("/")
	@PreAuthorize("@pms.hasPermission('sys_user_edit')")
	public R saveUser(@Valid @RequestBody UserDataVo userDataVo) {
		log.debug("REST request to save userDataVo : {}", userDataVo);
		// beanValidatorAjax(user);
		if (StringUtil.isNotEmpty(userDataVo.getPassword()) &&
			!userDataVo.getPassword().equals(userDataVo.getConfirmPassword())) {
			throw new RuntimeMsgException("两次输入密码不一致");
		}
		// username before comparing with database
		if (!checkByProperty(ClassUtil.createObj(UserDataVo.class,
			Lists.newArrayList(UserDataVo.F_ID, UserDataVo.F_USERNAME),
			userDataVo.getId(), userDataVo.getUsername()))) {
			throw new RuntimeMsgException("登录Id已存在");
		}
		// email before comparing with database
		if (StringUtil.isNotEmpty(userDataVo.getEmail()) &&
			!checkByProperty(ClassUtil.createObj(UserDataVo.class,
				Lists.newArrayList(UserDataVo.F_ID, UserDataVo.F_EMAIL), userDataVo.getId(), userDataVo.getEmail()))) {
			throw new RuntimeMsgException("邮箱已存在");
		}
		service.save(userDataVo);
		return R.buildOk("操作成功");
	}

	/**
	 * 分页查询用户
	 *
	 * @param pm 参数集
	 * @return 用户集合
	 */
	@GetMapping("/")
	@PreAuthorize("@pms.hasPermission('sys_user_view')")
	public R getUserPage(PageModel pm) {
		return R.buildOkData(service.getUserPage(pm));
	}

	/**
	 * @param username 用户名称
	 * @return 上级部门用户列表
	 */
	@GetMapping("/ancestor/{username}")
	public R listAncestorUsers(@PathVariable String username) {
		return new R<>(service.listAncestorUsersByUsername(username));
	}


	/**
	 * @param ids
	 * @return
	 */
	@PutMapping(CommonConstants.URL_IDS_REGEX)
	@Log(value = "用户管理", businessType = BusinessType.LOCK)
	@PreAuthorize("@pms.hasPermission('sys_user_lock')")
	public R lockOrUnLock(@PathVariable String ids) {
		service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
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
		;
		for (UserExcelVo userExcelVo : dataList) {
			if (userExcelVo.getPhone().length() != 11) {
				BigDecimal bd = new BigDecimal(userExcelVo.getPhone());
				userExcelVo.setPhone(bd.toPlainString());
			}
			if (!checkByProperty(ClassUtil.createObj(UserDataVo.class, Lists.newArrayList(UserVo.F_USERNAME),
				userExcelVo.getUsername()))) {
				throw new RuntimeMsgException("登录Id" + userExcelVo.getUsername() + "已存在");
			}
			if (ObjectUtil.isNotEmpty(userExcelVo.getPhone()) && !checkByProperty(ClassUtil.createObj(UserDataVo.class,
				Lists.newArrayList(UserVo.F_PHONE), userExcelVo.getPhone()))) {
				throw new RuntimeMsgException("手机" + userExcelVo.getPhone() + "已存在");
			}
			if (ObjectUtil.isNotEmpty(userExcelVo.getEmail()) && !checkByProperty(ClassUtil.createObj(UserDataVo.class,
				Lists.newArrayList(UserVo.F_EMAIL), userExcelVo.getEmail()))) {
				throw new RuntimeMsgException("邮箱" + userExcelVo.getEmail() + "已存在");
			}
			service.save(userExcelVo);
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
