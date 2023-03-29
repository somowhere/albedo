/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.security.util;

import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.ValidateCodeException;
import com.albedo.java.common.core.util.AddressUtil;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.security.service.UserDetail;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.sys.domain.UserOnlineDo;
import com.albedo.java.modules.sys.domain.vo.account.LoginVo;
import com.google.common.collect.Maps;
import lombok.SneakyThrows;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.Authentication;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Map;
import java.util.Objects;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:25 下午
 */
public class LoginUtil {

	public final static String LOGIN_FAIL_MAP = "loginFailMap";

	@SneakyThrows
	public static void checkCode(@Valid LoginVo loginVo) {
		RedisTemplate redisTemplate = RedisUtil.getRedisTemplate();
		String code = loginVo.getCode();
		String randomStr = loginVo.getRandomStr();
		if (StrUtil.isBlank(code) || StrUtil.isBlank(randomStr)) {
			throw new ValidateCodeException("随机码不能为空");
		}

		String key = CommonConstants.DEFAULT_CODE_KEY + randomStr;
		if (!redisTemplate.hasKey(key)) {
			throw new ValidateCodeException("随机码不合法");
		}

		String saveCode = RedisUtil.getCacheString(key);
		RedisUtil.delete(key);
		if (StrUtil.isEmpty(saveCode) || !StrUtil.equals(saveCode, code)) {
			throw new ValidateCodeException("验证码不合法");
		}

	}

	/**
	 * 是否是验证码登录
	 *
	 * @param useruame 用户名
	 * @param isFail   计数加1
	 * @param clean    计数清零
	 * @return
	 */
	public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean) {
		@SuppressWarnings("unchecked")
		Map<String, Integer> loginFailMap = RedisUtil.getCacheMap(LOGIN_FAIL_MAP);
		if (loginFailMap == null) {
			loginFailMap = Maps.newHashMap();
			RedisUtil.setCacheMap(LOGIN_FAIL_MAP, loginFailMap);
		}
		Integer loginFailNum = loginFailMap.get(useruame);
		if (loginFailNum == null) {
			loginFailNum = 0;
		}
		if (isFail) {
			loginFailNum++;
			loginFailMap.put(useruame, loginFailNum);
		}
		if (clean) {
			loginFailMap.remove(useruame);
		}
		return !SpringContextHolder.isDevelopment() && loginFailNum >= 3;
	}

	public static UserOnlineDo getUserOnline(Authentication authentication) {
		UserOnlineDo online = new UserOnlineDo();
		HttpServletRequest request = ((ServletRequestAttributes) Objects
			.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();
		HttpSession session = request.getSession(false);
		UserDetail user = SecurityUtil.getUser(authentication);
		online.setSessionId(String.valueOf(session.getId()));
		online.setDeptId(user.getDeptId());
		online.setDeptName(user.getDeptName());
		online.setUserId(user.getId());
		online.setUsername(user.getUsername());
		online.setStartTimestamp(LocalDateTimeUtil.of(session.getCreationTime()));
		online.setLastAccessTime(LocalDateTimeUtil.of(session.getLastAccessedTime()));
		online.setExpireTime((long) session.getMaxInactiveInterval());
		online.setIpAddress(WebUtil.getIp(request));
		online.setIpLocation(AddressUtil.getRegion(online.getIpAddress()));
		online.setUserAgent(request.getHeader(HttpHeaders.USER_AGENT));
		UserAgent userAgent = UserAgentUtil.parse(online.getUserAgent());
		online.setBrowser(userAgent.getBrowser().getName());
		online.setOs(userAgent.getOs().getName());
		return online;
	}

}
