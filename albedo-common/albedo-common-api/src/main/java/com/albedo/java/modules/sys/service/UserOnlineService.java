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

package com.albedo.java.modules.sys.service;

import com.albedo.java.modules.sys.domain.UserOnline;
import com.albedo.java.plugins.mybatis.service.BaseService;

/**
 * <p>
 * token 服务类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
public interface UserOnlineService extends BaseService<UserOnline> {

	/**
	 * deleteBySessionId
	 *
	 * @param sessionId
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	void deleteBySessionId(String sessionId);

	/**
	 * offlineBySessionId
	 *
	 * @param sessionId
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	void offlineBySessionId(String sessionId);

	/**
	 * saveByEvent
	 *
	 * @param userOnline
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	void saveByEvent(UserOnline userOnline);

	/**
	 * 重置用户登录
	 *
	 * @return 是否成功
	 */
	void reset();
}
