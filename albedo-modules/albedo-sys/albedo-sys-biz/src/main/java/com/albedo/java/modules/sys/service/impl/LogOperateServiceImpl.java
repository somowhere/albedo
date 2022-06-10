
/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.modules.sys.domain.LogOperateDo;
import com.albedo.java.modules.sys.feign.RemoteLogOperateService;
import com.albedo.java.modules.sys.repository.LogOperateRepository;
import com.albedo.java.modules.sys.service.LogOperateService;
import com.albedo.java.plugins.database.mybatis.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 日志表 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
public class LogOperateServiceImpl extends BaseServiceImpl<LogOperateRepository, LogOperateDo>
	implements LogOperateService, RemoteLogOperateService {

	@Override
	public boolean save(LogOperateDo entity) {
		return super.save(entity);
	}
}
