
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

package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.BeanUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.ResponseEntityBuilder;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.util.ExcelUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.UserDo;
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.domain.dto.UserInfoDto;
import com.albedo.java.modules.sys.domain.dto.UserQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.UserExcelVo;
import com.albedo.java.modules.sys.domain.vo.UserInfo;
import com.albedo.java.modules.sys.domain.vo.UserPageVo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.service.UserService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.google.common.collect.Lists;
import io.swagger.v3.oas.annotations.tags.Tag;
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
@Tag(name = "用户管理")
public class UserResource extends BaseResource {

	private final UserService userService;

	/**
	 * @param id &allowPublicKeyRetrieval=true * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_user_view')")
	public Result<UserDto> get(@PathVariable Long id) {
		log.debug("REST request to get Entity : {}", id);
		return Result.buildOkData(userService.findDtoById(id));
	}

	/**
	 * 分页查询用户
	 *
	 * @param pageModel 参数集
	 * @return 用户集合
	 */
	@GetMapping
	@LogOperate(value = "用户管理查看")
	@PreAuthorize("@pms.hasPermission('sys_user_view')")
	public Result<IPage<UserPageVo>> findPage(PageModel pageModel, UserQueryCriteria userQueryCriteria) {
		return Result.buildOkData(userService.findPage(pageModel, userQueryCriteria, SecurityUtil.getDataScope()));
	}

	/**
	 * @param userQueryCriteria
	 * @param response
	 */
	@LogOperate(value = "用户管理导出")
	@GetMapping(value = "/download")
	@PreAuthorize("@pms.hasPermission('sys_user_view')")
	public void download(UserQueryCriteria userQueryCriteria, HttpServletResponse response) {
		ExcelUtil<UserVo> util = new ExcelUtil(UserVo.class);
		util.exportExcel(userService.findList(userQueryCriteria, SecurityUtil.getDataScope()), "用户数据", response);
	}

	/**
	 * 获取当前用户全部信息
	 *
	 * @return 用户信息
	 */
	@GetMapping(value = {"/info"})
	public Result<UserInfo> info() {
		String username = SecurityUtil.getUser().getUsername();
		UserVo userVo = userService.findVoByUsername(username);
		if (userVo == null) {
			return Result.buildFail("获取当前用户信息失败");
		}
		return Result.buildOkData(userService.getInfo(userVo));
	}

	/**
	 * 个人中心更新信息
	 *
	 * @param userInfoDto 用户信息
	 * @return R
	 */
	@LogOperate(value = "用户管理编辑")
	@PostMapping("/info")
	public Result<String> saveInfo(@Valid @RequestBody UserInfoDto userInfoDto) {
		log.debug("REST request to save userDto : {}", userInfoDto);
		UserDto userDto = BeanUtil.copyPropertiesByClass(userInfoDto, UserDto.class);
		userDto.setId(SecurityUtil.getUser().getId());
		userDto.setUsername(SecurityUtil.getUser().getUsername());
		userService.saveOrUpdate(userDto);
		return Result.buildOk("更新成功");
	}

	/**
	 * 获取指定用户全部信息
	 *
	 * @return 用户信息
	 */
	@GetMapping("/info/{username}")
	public Result<UserInfo> info(@PathVariable String username) {
		UserVo userVo = userService.findVoByUsername(username);
		if (userVo == null) {
			return Result.buildFail(String.format("用户信息为空 %s", username));
		}
		return Result.buildOkData(userService.getInfo(userVo));
	}

	/**
	 * 删除用户
	 *
	 * @param ids
	 * @return
	 */
	@LogOperate(value = "用户管理删除")
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('sys_user_del')")
	public Result<Boolean> removeByIds(@RequestBody Set<Long> ids) {
		return Result.buildByFlag(userService.removeByIds(ids));
	}

	/**
	 * 添加/更新用户信息
	 *
	 * @param userDto 用户信息
	 * @return R
	 */
	@LogOperate(value = "用户管理编辑")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_user_edit')")
	public Result<String> save(@Valid @RequestBody UserDto userDto) {
		log.debug("REST request to save userDto : {}", userDto);
		boolean add = ObjectUtil.isEmpty(userDto.getId());
		if (add) {
			userDto.setPassword("123456");
		}
		userService.saveOrUpdate(userDto);
		return Result.buildOk(add ? "新增成功，默认密码：123456" : "修改成功");
	}

	/**
	 * @param username 用户名称
	 * @return 上级部门用户列表
	 */
	@GetMapping("/ancestor/{username}")
	public Result<List<UserDo>> listAncestorUsers(@PathVariable String username) {
		return Result.buildOkData(userService.listAncestorUsersByUsername(username));
	}

	/**
	 * @param ids
	 * @return
	 */
	@PutMapping
	@LogOperate(value = "用户管理锁定/解锁")
	@PreAuthorize("@pms.hasPermission('sys_user_lock')")
	public Result<String> lockOrUnLock(@RequestBody Set<Long> ids) {
		userService.lockOrUnLock(ids);
		return Result.buildOk("操作成功");
	}

	/**
	 * @param dataFile
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/upload")
	@PreAuthorize("@pms.hasPermission('sys_user_upload')")
	@LogOperate(value = "用户管理导入")
	public ResponseEntity<Result> uploadData(@RequestParam("uploadFile") MultipartFile dataFile, HttpServletResponse response)
		throws Exception {
		if (dataFile.isEmpty()) {
			return ResponseEntityBuilder.buildFail("上传文件为空");
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
		return ResponseEntityBuilder.buildOk("操作成功");

	}

	/**
	 * @param response
	 */
	@GetMapping(value = "/importTemplate")
	@PreAuthorize("@pms.hasPermission('sys_user_view')")
	@LogOperate(value = "用户导入模板导出")
	public void importTemplate(HttpServletResponse response) {
		ExcelUtil<UserExcelVo> util = new ExcelUtil(UserExcelVo.class);
		util.exportExcel(Lists.newArrayList(new UserExcelVo()), "操作日志", response);
	}

}
