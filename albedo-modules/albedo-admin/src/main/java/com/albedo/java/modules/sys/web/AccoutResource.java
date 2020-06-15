package com.albedo.java.modules.sys.web;

import cn.hutool.core.io.IoUtil;
import cn.hutool.crypto.asymmetric.KeyType;
import cn.hutool.crypto.asymmetric.RSA;
import com.albedo.java.common.core.annotation.AnonymousAccess;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.dto.UserEmailDto;
import com.albedo.java.modules.sys.domain.vo.account.PasswordChangeVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordRestVo;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.domain.vo.EmailVo;
import com.albedo.java.modules.tool.service.EmailService;
import com.google.code.kaptcha.Producer;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.awt.image.BufferedImage;
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
public class AccoutResource extends BaseResource {

	private final UserService userService;
	private final Producer producer;
	private final ApplicationProperties applicationProperties;
	private final EmailService emailService;


	/**
	 * {@code GET  /authenticate} : check if the user is authenticated, and return its login.
	 *
	 * @param request the HTTP request.
	 * @return the login if the user is authenticated.
	 */
	@AnonymousAccess
	@GetMapping(SecurityConstants.AUTHENTICATE_URL)
	public String isAuthenticated(HttpServletRequest request) {
		log.debug("REST request to check if the current user is authenticated");
		return request.getRemoteUser();
	}

	/**
	 * 修改密码
	 * POST  /account/changePassword : changes the current user's password
	 *
	 * @param passwordChangeVo the passwordVo
	 */
	@ApiOperation(value = "修改密码")
	@PostMapping(path = "/account/change-password")
	public Result changePassword(@Valid @RequestBody PasswordChangeVo passwordChangeVo) {
		// 密码解密
		RSA rsa = new RSA(applicationProperties.getRsa().getPrivateKey(), applicationProperties.getRsa().getPublicKey());
		String oldPass = new String(rsa.decrypt(passwordChangeVo.getOldPassword(), KeyType.PrivateKey));
		String newPass = new String(rsa.decrypt(passwordChangeVo.getNewPassword(), KeyType.PrivateKey));
		String confirmPass = new String(rsa.decrypt(passwordChangeVo.getConfirmPassword(), KeyType.PrivateKey));
		passwordChangeVo.setNewPassword(newPass);
		passwordChangeVo.setConfirmPassword(confirmPass);
		passwordChangeVo.setOldPassword(oldPass);
		userService.changePassword(SecurityUtil.getUser().getUsername(),
			passwordChangeVo);
		return Result.buildOk("密码修改成功，请重新登录");
	}

	@ApiOperation("修改头像")
	@PostMapping(value = "/account/change-avatar")
	public Result<Object> updateAvatar(@RequestParam String avatar) {
		userService.updateAvatar(SecurityUtil.getUser().getUsername(), avatar);
		return Result.buildOk("头像修改成功");
	}

	@Log("修改邮箱")
	@ApiOperation("修改邮箱")
	@PostMapping(value = "/account/change-email/{code}")
	public ResponseEntity<Object> updateEmail(@PathVariable String code, @RequestBody UserEmailDto userEmailDto) {
		// 密码解密
		RSA rsa = new RSA(applicationProperties.getRsa().getPrivateKey(), applicationProperties.getRsa().getPublicKey());
		String password = new String(rsa.decrypt(userEmailDto.getPassword(), KeyType.PrivateKey));
		userEmailDto.setPassword(password);
		emailService.validated(CommonConstants.EMAIL_RESET_EMAIL_CODE + userEmailDto.getEmail(), code);
		userService.updateEmail(SecurityUtil.getUser().getUsername(), userEmailDto);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@AnonymousAccess
	@GetMapping(path = "/code/{randomStr}")
	@ApiOperation(value = "获取验证码")
	public void valicode(@PathVariable String randomStr, HttpServletResponse response) throws IOException {
		Assert.isTrue(StringUtil.isNotEmpty(randomStr), "机器码不能为空");
		response.setHeader("Cache-Control", "no-store, no-cache");
		response.setHeader("Transfer-Encoding", "JPG");
		response.setContentType("image/jpeg");
		//生成文字验证码
		String text = producer.createText();
		//生成图片验证码
		BufferedImage image = producer.createImage(text);
		RedisUtil.setCacheString(CommonConstants.DEFAULT_CODE_KEY + randomStr, text, CommonConstants.DEFAULT_IMAGE_EXPIRE, TimeUnit.SECONDS);
		//创建输出流
		ServletOutputStream out = response.getOutputStream();
		//写入数据
		ImageIO.write(image, "jpeg", out);
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
