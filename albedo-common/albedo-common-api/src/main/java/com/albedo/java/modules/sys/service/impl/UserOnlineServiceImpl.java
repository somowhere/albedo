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

package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.modules.sys.domain.UserOnline;
import com.albedo.java.modules.sys.domain.enums.OnlineStatus;
import com.albedo.java.modules.sys.repository.UserOnlineRepository;
import com.albedo.java.modules.sys.service.UserOnlineService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * <p>
 * token 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@Slf4j
public class UserOnlineServiceImpl extends
	BaseServiceImpl<UserOnlineRepository, UserOnline> implements UserOnlineService {


	@Override
	public void deleteBySessionId(String sessionId) {
		repository.deleteById(sessionId);
	}

	@Override
	public void offlineBySessionId(String sessionId) {
		UserOnline userOnline = getById(sessionId);
		if (userOnline != null) {
			userOnline.setStatus(OnlineStatus.off_line);
			repository.updateById(userOnline);
		}
	}

	@Override
	public void saveByEvent(UserOnline userOnline) {
		this.remove(Wrappers.<UserOnline>lambdaQuery().eq(UserOnline::getUserId, userOnline.getUserId())
			.or().eq(UserOnline::getSessionId, userOnline.getSessionId()));
		saveOrUpdate(userOnline);
	}

}
