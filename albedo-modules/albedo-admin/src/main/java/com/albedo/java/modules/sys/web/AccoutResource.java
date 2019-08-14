package com.albedo.java.modules.sys.web;

import cn.hutool.core.io.IoUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.ResultBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.sys.util.RedisUtil;
import com.albedo.java.modules.sys.vo.UserDataVo;
import com.albedo.java.modules.sys.vo.account.PasswordChangeVo;
import com.albedo.java.modules.sys.vo.account.PasswordRestVo;
import com.google.code.kaptcha.Producer;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
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
@Controller
@RequestMapping("${application.admin-path}")
@Slf4j
@AllArgsConstructor
public class AccoutResource extends BaseResource {

	private final UserService userService;
	private final Producer producer;
	private final PasswordEncoder passwordEncoder;

	/**
	 * {@code GET  /authenticate} : check if the user is authenticated, and return its login.
	 *
	 * @param request the HTTP request.
	 * @return the login if the user is authenticated.
	 */
	@GetMapping("/authenticate")
	public String isAuthenticated(HttpServletRequest request) {
		log.debug("REST request to check if the current user is authenticated");
		return request.getRemoteUser();
	}

	/**
	 * 功能描述: 检查密码长度
	 *
	 * @param: [password]
	 * @return: boolean
	 */
	private static boolean checkPasswordLength(String password) {
		return !StringUtil.isEmpty(password) &&
			password.length() >= UserDataVo.PASSWORD_MIN_LENGTH &&
			password.length() <= UserDataVo.PASSWORD_MAX_LENGTH;
	}

	/**
	 * 修改密码
	 * POST  /account/changePassword : changes the current user's password
	 *
	 * @param passwordChangeVo the passwordVo
	 */
	@ApiOperation(value = "修改密码")
	@PostMapping(path = "/account/change-password")
	public R changePassword(@Valid @RequestBody PasswordChangeVo passwordChangeVo) {
		Assert.isTrue(passwordChangeVo != null &&
			checkPasswordLength(passwordChangeVo.getNewPassword()), "密码格式有误");
		Assert.isTrue(!passwordChangeVo.getNewPassword().equals(passwordChangeVo.getOldPassword()),
			"新旧密码不能相同");
		Assert.isTrue(passwordChangeVo.getNewPassword().equals(passwordChangeVo.getConfirmPassword()),
			"两次输入密码不一致");
		Assert.isTrue(passwordEncoder.matches(passwordChangeVo.getOldPassword(),
			SecurityUtil.getUser().getPassword()),
			"输入原密码有误");

		passwordChangeVo.setNewPassword(passwordEncoder.encode(passwordChangeVo.getNewPassword()));
		userService.changePassword(SecurityUtil.getUser().getUsername(),
			passwordChangeVo);
		return R.buildOk("修改成功");
	}


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


//    /**
//     * 发送手机验证码
//     * 后期要加接口限制
//     *
//     * @param mobile 手机号
//     * @return R
//     */
//    @GetMapping("/rest/smsCode/{mobile}")
//    @ApiOperation(value = "发送手机验证码")
//    public ResponseEntity createCode(@PathVariable String mobile) {
//        Assert.isTrue(StringUtil.isNotEmpty(mobile), "手机号不能为空");
//        userService.sendSmsCode(mobile);
//        return ResultBuilder.buildOk("发送成功");
//    }

	/**
	 * 重置密码
	 *
	 * @param passwordRestVo
	 * @return
	 */
	@PostMapping("/rest/password")
	@ApiOperation(value = "重置密码")
	public ResponseEntity resetPassword(@RequestBody @Valid PasswordRestVo passwordRestVo) {

		Assert.isTrue(passwordRestVo.getNewPassword().equals(passwordRestVo.getConfirmPassword()),
			"两次输入密码不一致");
		passwordRestVo.setPasswordPlaintext(passwordRestVo.getNewPassword());
		passwordRestVo.setNewPassword(passwordEncoder.encode(passwordRestVo.getNewPassword()));
		userService.resetPassword(passwordRestVo);
		return ResultBuilder.buildOk("发送成功");
	}

}
