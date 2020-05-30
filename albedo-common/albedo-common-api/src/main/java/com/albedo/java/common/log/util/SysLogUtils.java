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

package com.albedo.java.common.log.util;

import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.URLUtil;
import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import com.albedo.java.common.core.util.AddressUtil;
import com.albedo.java.common.core.util.RequestHolder;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.modules.sys.domain.LogOperate;
import lombok.experimental.UtilityClass;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;

/**
 * 系统日志工具类
 *
 * @author L.cm
 */
@UtilityClass
public class SysLogUtils {
	public LogOperate getSysLog() {
		HttpServletRequest request = RequestHolder.getHttpServletRequest();
		LogOperate logOperate = new LogOperate();
		logOperate.setCreatedBy(getUserId());
		logOperate.setCreatedDate(LocalDateTime.now());
		logOperate.setUsername(getUsername());
		logOperate.setIpAddress(WebUtil.getIP(request));
		logOperate.setIpLocation(AddressUtil.getRealAddressByIp(logOperate.getIpAddress()));
		logOperate.setUserAgent(request.getHeader("User-Agent"));
		UserAgent userAgent = UserAgentUtil.parse(logOperate.getUserAgent());
		logOperate.setBrowser(userAgent.getBrowser().getName());
		logOperate.setOs(userAgent.getOs().getName());
		logOperate.setRequestUri(URLUtil.getPath(request.getRequestURI()));
//		logOperate.setMethod(request.getMethod());
//		if (request instanceof BodyRequestWrapper) {
//			String body = ((BodyRequestWrapper) request).getRequestBody();
//			logOperate.setParams(StringUtil.isEmpty(body) ? HttpUtil.toParams(request.getParameterMap()) : body);
//		} else {
//			logOperate.setParams(HttpUtil.toParams(request.getParameterMap()));
//		}
//		log.setServiceId(getClientId());
		return logOperate;
	}

	/**
	 * 获取客户端
	 *
	 * @return clientId
	 */
//	private String getClientId() {
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		if (authentication instanceof OAuth2Authentication) {
//			OAuth2Authentication auth2Authentication = (OAuth2Authentication) authentication;
//			return auth2Authentication.getOAuth2Request().getClientId();
//		}
//		return null;
//	}

	/**
	 * 获取用户名称
	 *
	 * @return username
	 */
	private String getUsername() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null) {
			return null;
		}
		return authentication.getName();
	}

	/**
	 * 获取用户Id
	 *
	 * @return username
	 */
	private String getUserId() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null || authentication.getPrincipal() == null) {
			return null;
		}
		return (String) ReflectUtil.getFieldValue(authentication.getPrincipal(), "id");
	}
}
