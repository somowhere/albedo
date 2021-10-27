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

package com.albedo.java.common.security.util;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.annotation.AnonymousAccess;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.plugins.mybatis.datascope.DataScope;
import com.albedo.java.common.security.enums.RequestMethodEnum;
import com.albedo.java.common.security.service.UserDetail;
import lombok.experimental.UtilityClass;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;

import java.util.*;

/**
 * 安全工具类
 *
 * @author somewhere
 */
@UtilityClass
public class SecurityUtil {

	private UserDetailsService userDetailsService;

	public UserDetailsService getUserDetailsService() {
		if (userDetailsService == null) {
			userDetailsService = SpringContextHolder.getBean(UserDetailsService.class);
		}
		return userDetailsService;
	}

	/**
	 * 获取Authentication
	 */
	public Authentication getAuthentication() {
		return SecurityContextHolder.getContext().getAuthentication();
	}

	/**
	 * 获取用户
	 */
	public UserDetail getUser(Authentication authentication) {
		Object principal = authentication.getPrincipal();
		if (principal instanceof UserDetail) {
			return (UserDetail) principal;
		} else if (principal instanceof User) {
			return (UserDetail) getUserDetailsService().loadUserByUsername(((User) principal).getUsername());
		}
		return null;
	}

	/**
	 * 获取用户
	 */
	public UserDetail getUser() {
		Authentication authentication = getAuthentication();
		if (authentication == null) {
			return null;
		}
		return getUser(authentication);
	}

	public DataScope getDataScope() {
		return getUser() != null ? getUser().getDataScope() : null;
	}

	/**
	 * 获取用户角色信息
	 *
	 * @return 角色集合
	 */
	public List<String> getRoles() {
		Authentication authentication = getAuthentication();
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

		List<String> roleIds = new ArrayList<>();
		authorities.stream().filter(granted -> StrUtil.startWith(granted.getAuthority(), SecurityConstants.ROLE))
			.forEach(granted -> {
				String id = StrUtil.removePrefix(granted.getAuthority(), SecurityConstants.ROLE);
				roleIds.add(id);
			});
		return roleIds;
	}

	public static Map<String, Set<String>> getAnonymousUrl(Map<RequestMappingInfo, HandlerMethod> handlerMethodMap) {
		Map<String, Set<String>> anonymousUrls = new HashMap<>(6);
		Set<String> get = new HashSet<>();
		Set<String> post = new HashSet<>();
		Set<String> put = new HashSet<>();
		Set<String> patch = new HashSet<>();
		Set<String> delete = new HashSet<>();
		Set<String> all = new HashSet<>();
		for (Map.Entry<RequestMappingInfo, HandlerMethod> infoEntry : handlerMethodMap.entrySet()) {
			HandlerMethod handlerMethod = infoEntry.getValue();
			AnonymousAccess anonymousAccess = handlerMethod.getMethodAnnotation(AnonymousAccess.class);
			if (null != anonymousAccess) {
				List<RequestMethod> requestMethods = new ArrayList<>(
					infoEntry.getKey().getMethodsCondition().getMethods());
				RequestMethodEnum request = RequestMethodEnum.find(
					requestMethods.size() == 0 ? RequestMethodEnum.ALL.getType() : requestMethods.get(0).name());
				switch (Objects.requireNonNull(request)) {
					case GET:
						get.addAll(infoEntry.getKey().getPatternsCondition().getPatterns());
						break;
					case POST:
						post.addAll(infoEntry.getKey().getPatternsCondition().getPatterns());
						break;
					case PUT:
						put.addAll(infoEntry.getKey().getPatternsCondition().getPatterns());
						break;
					case PATCH:
						patch.addAll(infoEntry.getKey().getPatternsCondition().getPatterns());
						break;
					case DELETE:
						delete.addAll(infoEntry.getKey().getPatternsCondition().getPatterns());
						break;
					default:
						all.addAll(infoEntry.getKey().getPatternsCondition().getPatterns());
						break;
				}
			}
		}
		anonymousUrls.put(RequestMethodEnum.GET.getType(), get);
		anonymousUrls.put(RequestMethodEnum.POST.getType(), post);
		anonymousUrls.put(RequestMethodEnum.PUT.getType(), put);
		anonymousUrls.put(RequestMethodEnum.PATCH.getType(), patch);
		anonymousUrls.put(RequestMethodEnum.DELETE.getType(), delete);
		anonymousUrls.put(RequestMethodEnum.ALL.getType(), all);
		return anonymousUrls;
	}

}
