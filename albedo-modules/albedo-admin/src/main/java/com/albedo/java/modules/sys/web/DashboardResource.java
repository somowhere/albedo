package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.sys.service.LogLoginService;
import com.albedo.java.modules.sys.service.UserService;
import com.baidu.fsg.uid.UidGenerator;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 前端控制器
 * 首页
 * </p>
 *
 * @author somewhere
 * @date 2019-10-20
 */
@Slf4j
@Validated
@RestController
@RequestMapping("${application.admin-path}")
@Tag(name = "dashboard", description = "首页")
@RequiredArgsConstructor
public class DashboardResource {

	private final LogLoginService logLoginService;
	private final UserService userService;
	private final UidGenerator uidGenerator;

	@PostMapping("/dashboard/pvIncr")
	public Result<Boolean> pvIncr() {
		logLoginService.pvIncr();
		return Result.buildOk();
	}


	@GetMapping("/dashboard/item")
	public Result<Map<String, Object>> item() {
		Map<String, Object> data = new HashMap<>(11);
		// 用户数
		data.put("totalUserCount", userService.count());
		data.put("todayUserCount", userService.todayUserCount());
		// 页面 访问量
		data.put("totalPv", logLoginService.getTotalPv());
		data.put("todayPv", logLoginService.getTodayPv());
		// 独立 登录IV数
		data.put("totalLoginIv", logLoginService.getTotalLoginIv());
		data.put("todayLoginIv", logLoginService.getTodayLoginIv());
		// 独立 登录PV数
		data.put("totalLoginPv", logLoginService.getTotalLoginPv());
		data.put("todayLoginPv", logLoginService.getTodayLoginPv());

		return Result.buildOkData(data);
	}

	@GetMapping("/dashboard/chart")
	public Result<Map<String, Object>> chart() {
		Map<String, Object> data = new HashMap<>(11);
		data.put("lastTenVisitCount", logLoginService.findLastTenDaysVisitCount(null));
		data.put("lastTenUserVisitCount", logLoginService.findLastTenDaysVisitCount(SecurityUtil.getUser().getUsername()));

		data.put("browserCount", logLoginService.findByBrowser());
		data.put("operatingSystemCount", logLoginService.findByOperatingSystem());
		return Result.buildOkData(data);
	}

	@GetMapping("/common/generateId")
	public Result<Object> generate() {
		long uid = uidGenerator.getUid();
		return Result.buildOkData(uid + "length" + String.valueOf(uid).length());
	}
}
