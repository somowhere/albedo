/*
 *  Copyright (c) 2019-2020, somowhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.feign;

import com.albedo.java.modules.sys.domain.UserOnlineDo;

/**
 * @author somowhere
 * @date 2019/2/1
 */
public interface RemoteUserOnlineService {

	UserOnlineDo getById(String sessionId);

	void deleteBySessionId(String sessionId);

	void saveByEvent(UserOnlineDo userOnlineDo);

	boolean updateById(UserOnlineDo userOnlineDo);
}
