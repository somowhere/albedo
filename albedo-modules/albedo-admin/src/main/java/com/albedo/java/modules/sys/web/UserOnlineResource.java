package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.security.component.session.RedisSessionRegistry;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.UserOnline;
import com.albedo.java.modules.sys.domain.enums.OnlineStatus;
import com.albedo.java.modules.sys.service.UserOnlineService;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

/**
 * 在线用户监控
 *
 * @author somewhere
 */
@RestController
@RequestMapping("${application.admin-path}/sys/user-online")
@AllArgsConstructor
public class UserOnlineResource extends BaseResource {

	private final UserOnlineService userOnlineService;
	private final SessionRegistry sessionRegistry;
	private final RedisTemplate redisTemplate;

	/**
	 * 分页查询用户
	 *
	 * @param pm 参数集
	 * @return 用户集合
	 */
	@GetMapping("/")
	@PreAuthorize("@pms.hasPermission('sys_userOnline_view')")
	public R getUserPage(PageModel pm) {
		return R.buildOkData(userOnlineService.findPage(pm));
	}


	@PreAuthorize("@pms.hasPermission('sys_userOnline_logout')")
	@Log(value = "在线用户", businessType = BusinessType.FORCE)
	@PostMapping("/batchForceLogout" + CommonConstants.URL_IDS_REGEX)
	public R batchForceLogout(@PathVariable String ids, HttpServletRequest request) {
		ArrayList<String> idList = Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT));
		for (String id : idList) {
			UserOnline online = userOnlineService.findOneById(id);
			if (online == null) {
				return R.buildFail("用户已下线");
			}
			SessionInformation sessionInformation = sessionRegistry.getSessionInformation(online.getSessionId());
			if (sessionInformation != null) {
				if (sessionInformation.getSessionId().equals(request.getSession(false).getId())) {
					return R.buildFail("当前登陆用户无法强退");
				}
				sessionInformation.expireNow();
				redisTemplate.boundHashOps(RedisSessionRegistry.SESSIONIDS).put(online.getSessionId(), sessionInformation);
			}
			online.setStatus(OnlineStatus.off_line);
			userOnlineService.updateById(online);
		}
		return R.buildOk("操作成功");
	}

	@PreAuthorize("@pms.hasPermission('sys_userOnline_del')")
	@Log(value = "在线用户", businessType = BusinessType.DELETE)
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	public R remove(@PathVariable String ids, HttpServletRequest request) {
		ArrayList<String> idList = Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT));
		for (String id : idList) {
			UserOnline online = userOnlineService.findOneById(id);
			if (online == null) {
				return R.buildFail("用户已下线");
			}
			SessionInformation sessionInformation = sessionRegistry.getSessionInformation(online.getSessionId());
			if (sessionInformation != null) {
				if (sessionInformation.getSessionId().equals(request.getSession(false).getId())) {
					return R.buildFail("当前登陆用户无法删除");
				}
				sessionInformation.expireNow();
				redisTemplate.boundHashOps(RedisSessionRegistry.SESSIONIDS).put(online.getSessionId(), sessionInformation);
			}
			sessionRegistry.removeSessionInformation(online.getSessionId());
			userOnlineService.removeById(online);
		}
		return R.buildOk("操作成功");
	}

}
