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

import com.albedo.java.modules.sys.domain.Parameter;
import com.albedo.java.modules.sys.domain.dto.ParameterDto;
import com.albedo.java.plugins.database.mybatis.service.DataService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 应用接口
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
public interface ParameterService extends DataService<Parameter, ParameterDto> {

	/**
	 * 根据参数键查询参数值
	 *
	 * @param key    参数键
	 * @param defVal 参数值
	 * @return 参数值
	 */
	String getValue(String key, String defVal);

	/**
	 * 根据参数键查询参数值
	 *
	 * @param keys 参数键
	 * @return 参数值
	 */
	Map<String, String> findParams(List<String> keys);
}
