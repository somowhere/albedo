package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.component.session.RedisSessionRegistry;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.UserOnline;
import com.albedo.java.modules.sys.domain.dto.UserOnlineQueryCriteria;
import com.albedo.java.modules.sys.domain.enums.OnlineStatus;
import com.albedo.java.modules.sys.service.UserOnlineService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import lombok.AllArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Set;

/**
 * 在线用户监控
 *
 * @author somewhere
 */
@RestController
@RequestMapping("${application.admin-path}/sys/user-online")
@AllArgsConstructor
@Api(tags = "在线用户")
public class UserOnlineResource extends BaseResource {

	private final UserOnlineService userOnlineService;

	private final SessionRegistry sessionRegistry;

	private final RedisTemplate redisTemplate;

	/**
	 * 分页查询用户
	 *
	 * @param pageModel 参数集
	 * @return 用户集合
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('sys_userOnline_view')")
	@LogOperate(value = "在线用户查看")
	public Result findPage(PageModel pageModel, UserOnlineQueryCriteria userOnlineQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pageModel, userOnlineQueryCriteria);
		return Result.buildOkData(userOnlineService.page(pageModel, wrapper));
	}

	@PreAuthorize("@pms.hasPermission('sys_userOnline_logout')")
	@LogOperate(value = "在线用户强退")
	@PutMapping("/batch-force-logout")
	public Result batchForceLogout(@RequestBody Set<String> ids, HttpServletRequest request) {
		for (String id : ids) {
			UserOnline online = userOnlineService.getById(id);
			if (online == null) {
				return Result.buildFail("用户已下线");
			}
			SessionInformation sessionInformation = sessionRegistry.getSessionInformation(online.getSessionId());
			if (sessionInformation != null) {
				if (sessionInformation.getSessionId().equals(request.getSession(false).getId())) {
					return Result.buildFail("当前登陆用户无法强退");
				}
				sessionInformation.expireNow();
				redisTemplate.boundHashOps(RedisSessionRegistry.SESSIONIDS).put(online.getSessionId(),
					sessionInformation);
			}
			online.setStatus(OnlineStatus.off_line);
			userOnlineService.updateById(online);
		}
		return Result.buildOk("操作成功");
	}

	@PreAuthorize("@pms.hasPermission('sys_userOnline_del')")
	@LogOperate(value = "在线用户删除")
	@DeleteMapping
	public Result remove(@RequestBody Set<String> ids, HttpServletRequest request) {
		for (String id : ids) {
			UserOnline online = userOnlineService.getById(id);
			if (online == null) {
				return Result.buildFail("用户已下线");
			}
			try {
				SessionInformation sessionInformation = sessionRegistry.getSessionInformation(online.getSessionId());
				if (sessionInformation != null) {
					if (sessionInformation.getSessionId().equals(request.getSession(false).getId())) {
						return Result.buildFail("当前登陆用户无法删除");
					}
					sessionInformation.expireNow();
					redisTemplate.boundHashOps(RedisSessionRegistry.SESSIONIDS).put(online.getSessionId(),
						sessionInformation);
				}
			} catch (Exception e) {
			}
			sessionRegistry.removeSessionInformation(online.getSessionId());
			userOnlineService.removeById(online);
		}
		return Result.buildOk("操作成功");
	}

}
