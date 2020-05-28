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
import com.albedo.java.common.core.util.BeanUtil;
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
import com.albedo.java.modules.sys.domain.dto.UserInfoDto;
import com.albedo.java.modules.sys.domain.dto.UserQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.UserExcelVo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.service.UserService;
import com.baomidou.mybatisplus.core.metadata.IPage;
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
public class UserResource extends BaseResource {

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
	 * 分页查询用户
	 *
	 * @param pm 参数集
	 * @return 用户集合
	 */
	@GetMapping
	@Log(value = "用户管理查看")
	@PreAuthorize("@pms.hasPermission('sys_user_view')")
	public R<IPage<UserVo>> getUserPage(PageModel pm, UserQueryCriteria userQueryCriteria) {
		return R.buildOkData(userService.getUserPage(pm, userQueryCriteria, SecurityUtil.getDataScope()));
	}

	@Log(value = "用户管理导出")
	@GetMapping(value = "/download")
	@PreAuthorize("@pms.hasPermission('sys_user_view')")
	public void download(UserQueryCriteria userQueryCriteria, HttpServletResponse response) {
		ExcelUtil<UserVo> util = new ExcelUtil(UserVo.class);
		util.exportExcel(userService.getUserPage(userQueryCriteria,
			SecurityUtil.getDataScope()), "用户数据", response);
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
	@Log(value = "用户管理删除")
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('sys_user_del')")
	public R removeByIds(@RequestBody Set<String> ids) {
		return R.buildByFlag(userService.removeByIds(ids));
	}

	/**
	 * 添加/更新用户信息
	 *
	 * @param userDto 用户信息
	 * @return R
	 */
	@Log(value = "用户管理编辑")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_user_edit')")
	public R save(@Valid @RequestBody UserDto userDto) {
		log.debug("REST request to save userDto : {}", userDto);
		boolean add = StringUtil.isEmpty(userDto.getId());
		if (add) {
			userDto.setPassword("123456");
		}
		userService.saveOrUpdate(userDto);
		return R.buildOk(add ? "新增成功，默认密码：123456" : "修改成功");
	}

	/**
	 *个人中心更新信息
	 * @param userInfoDto 用户信息
	 * @return R
	 */
	@Log(value = "用户管理编辑")
	@PostMapping("/info")
	@PreAuthorize("@pms.hasPermission('sys_user_edit')")
	public R saveInfo(@Valid @RequestBody UserInfoDto userInfoDto) {
		log.debug("REST request to save userDto : {}", userInfoDto);
		UserDto userDto = BeanUtil.copyPropertiesByClass(userInfoDto, UserDto.class);
		userDto.setId(SecurityUtil.getUser().getId());
		userDto.setUsername(SecurityUtil.getUser().getUsername());
		userService.saveOrUpdate(userDto);
		return R.buildOk("更新成功");
	}

	/**
	 * @param username 用户名称
	 * @return 上级部门用户列表
	 */
	@GetMapping("/ancestor/{username}")
	public R listAncestorUsers(@PathVariable String username) {
		return R.buildOkData(userService.listAncestorUsersByUsername(username));
	}


	/**
	 * @param ids
	 * @return
	 */
	@PutMapping
	@Log(value = "用户管理锁定/解锁")
	@PreAuthorize("@pms.hasPermission('sys_user_lock')")
	public R lockOrUnLock(@RequestBody Set<String> ids) {
		userService.lockOrUnLock(ids);
		return R.buildOk("操作成功");
	}


	@PostMapping(value = "/upload")
	@PreAuthorize("@pms.hasPermission('sys_user_upload')")
	@Log(value = "用户管理导入")
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
	@Log(value = "用户导入模板导出")
	public void importTemplate(HttpServletResponse response) {
		ExcelUtil<UserExcelVo> util = new ExcelUtil(UserExcelVo.class);
		util.exportExcel(Lists.newArrayList(new UserExcelVo()), "操作日志", response);
	}

}
