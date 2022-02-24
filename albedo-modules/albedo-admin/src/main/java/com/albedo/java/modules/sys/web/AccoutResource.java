/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

import cn.hutool.core.io.IoUtil;
import cn.hutool.crypto.asymmetric.KeyType;
import cn.hutool.crypto.asymmetric.RSA;
import com.albedo.java.common.core.annotation.AnonymousAccess;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.dto.UserEmailDto;
import com.albedo.java.modules.sys.domain.vo.account.AvatarInfo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordChangeVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordRestVo;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.domain.vo.EmailVo;
import com.albedo.java.modules.tool.service.EmailService;
import com.pig4cloud.captcha.ArithmeticCaptcha;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

/**
 * 账户相关数据接口
 *
 * @author somewhere
 */
@RestController
@RequestMapping("${application.admin-path}")
@Slf4j
@AllArgsConstructor
@Api(tags = "账户相关")
public class AccoutResource extends BaseResource {

	private static final Integer DEFAULT_IMAGE_WIDTH = 100;

	private static final Integer DEFAULT_IMAGE_HEIGHT = 40;

	private final UserService userService;

	private final ApplicationProperties applicationProperties;

	private final EmailService emailService;

	/**
	 * {@code GET  /authenticate} : check if the user is authenticated, and return its
	 * login.
	 *
	 * @return the login if the user is authenticated.
	 */
	@AnonymousAccess
	@GetMapping(SecurityConstants.AUTHENTICATE_URL)
	public Result isAuthenticated() throws AccessDeniedException {
		log.debug("REST request to check if the current user is authenticated");
		return SecurityUtil.getUser() == null ? Result.buildFail("") : Result.buildOkData(SecurityUtil.getUser().getUsername());
	}

	/**
	 * 修改密码 POST /account/changePassword : changes the current user's password
	 *
	 * @param passwordChangeVo the passwordVo
	 */
	@ApiOperation(value = "修改密码")
	@PostMapping(path = "/account/change-password")
	public Result changePassword(@Valid @RequestBody PasswordChangeVo passwordChangeVo) {
		// 密码解密
		RSA rsa = new RSA(applicationProperties.getRsa().getPrivateKey(),
			applicationProperties.getRsa().getPublicKey());
		String oldPass = new String(rsa.decrypt(passwordChangeVo.getOldPassword(), KeyType.PrivateKey));
		String newPass = new String(rsa.decrypt(passwordChangeVo.getNewPassword(), KeyType.PrivateKey));
		String confirmPass = new String(rsa.decrypt(passwordChangeVo.getConfirmPassword(), KeyType.PrivateKey));
		passwordChangeVo.setNewPassword(newPass);
		passwordChangeVo.setConfirmPassword(confirmPass);
		passwordChangeVo.setOldPassword(oldPass);
		userService.changePassword(SecurityUtil.getUser().getUsername(), passwordChangeVo);
		return Result.buildOk("密码修改成功，请重新登录");
	}

	@ApiOperation("修改头像")
	@PostMapping(value = "/account/change-avatar")
	public Result<String> updateAvatar(@RequestBody AvatarInfo avatarInfo) {
		userService.updateAvatar(SecurityUtil.getUser().getUsername(), avatarInfo.getAvatar());
		return Result.buildOk("头像修改成功");
	}

	@LogOperate("修改邮箱")
	@ApiOperation("修改邮箱")
	@PostMapping(value = "/account/change-email/{code}")
	public Result<String> updateEmail(@PathVariable String code, @RequestBody UserEmailDto userEmailDto) {
		// 密码解密
		RSA rsa = new RSA(applicationProperties.getRsa().getPrivateKey(),
			applicationProperties.getRsa().getPublicKey());
		String password = new String(rsa.decrypt(userEmailDto.getPassword(), KeyType.PrivateKey));
		userEmailDto.setPassword(password);
		emailService.validated(CommonConstants.EMAIL_RESET_EMAIL_CODE + userEmailDto.getEmail(), code);
		userService.updateEmail(SecurityUtil.getUser().getUsername(), userEmailDto);
		return Result.buildOk("修改邮箱成功");
	}

	@AnonymousAccess
	@GetMapping(path = "/code/{randomStr}", produces = MediaType.IMAGE_JPEG_VALUE)
	@ApiOperation(value = "获取验证码")
	public void valicode(@PathVariable String randomStr, HttpServletResponse response) throws IOException {
		ArgumentAssert.notEmpty(randomStr, "机器码不能为空");
		response.setHeader("Cache-Control", "no-store, no-cache");
		response.setHeader("Transfer-Encoding", "JPG");
		response.setContentType("image/jpeg");

		ArithmeticCaptcha captcha = new ArithmeticCaptcha(DEFAULT_IMAGE_WIDTH, DEFAULT_IMAGE_HEIGHT);

		String result = captcha.text();
		RedisUtil.setCacheString(ContextUtil.getTenant() + CommonConstants.DEFAULT_CODE_KEY + randomStr, result,
			CommonConstants.DEFAULT_IMAGE_EXPIRE, TimeUnit.SECONDS);
		// 创建输出流
		ServletOutputStream out = response.getOutputStream();
		captcha.out(out);
		IoUtil.close(out);

	}

	/**
	 * 重置密码
	 *
	 * @param passwordRestVo
	 * @return
	 */
	@PostMapping("/reset/password")
	@ApiOperation(value = "重置密码")
	public Result resetPassword(@RequestBody @Valid PasswordRestVo passwordRestVo) {
		userService.resetPassword(passwordRestVo);
		return Result.buildOk("发送成功");
	}

	@PostMapping(value = "/reset/email-send")
	@ApiOperation("重置邮箱，发送验证码")
	public Result<Object> resetEmail(@RequestParam String email) {
		EmailVo emailVo = emailService.sendEmail(email, CommonConstants.EMAIL_RESET_EMAIL_CODE);
		emailService.send(emailVo, emailService.find());
		return Result.buildOk("发送成功");
	}

	@PostMapping(value = "/reset/pass-send")
	@ApiOperation("重置密码，发送验证码")
	public Result<Object> resetPass(@RequestParam String email) {
		EmailVo emailVo = emailService.sendEmail(email, CommonConstants.EMAIL_RESET_PWD_CODE);
		emailService.send(emailVo, emailService.find());
		return Result.buildOk("发送成功");
	}

	@GetMapping(value = "/validate-pass")
	@ApiOperation("验证码验证重置密码")
	public Result<Object> validatedByPass(@RequestParam String email, @RequestParam String code) {
		emailService.validated(CommonConstants.EMAIL_RESET_PWD_CODE + email, code);
		return Result.buildOk("验证成功");
	}

	@GetMapping(value = "/validate-email")
	@ApiOperation("验证码验证重置邮箱")
	public Result<Object> validatedByEmail(@RequestParam String email, @RequestParam String code) {
		emailService.validated(CommonConstants.EMAIL_RESET_EMAIL_CODE + email, code);
		return Result.buildOk("验证成功");
	}

}
