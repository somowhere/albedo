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

package com.albedo.java.modules.quartz.service.impl;

import com.albedo.java.modules.quartz.domain.JobLog;
import com.albedo.java.modules.quartz.domain.vo.JobLogExcelVo;
import com.albedo.java.modules.quartz.repository.JobLogRepository;
import com.albedo.java.modules.quartz.service.JobLogService;
import com.albedo.java.plugins.database.mybatis.service.impl.BaseServiceImpl;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 任务调度日志ServiceImpl 任务调度日志
 *
 * @author admin
 * @version 2019-08-14 11:25:03
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class JobLogServiceImpl extends BaseServiceImpl<JobLogRepository, JobLog> implements JobLogService {

	@Override
	public void cleanJobLog() {
		repository.cleanJobLog();
	}

	@Override
	public List<JobLogExcelVo> findExcelVo(QueryWrapper<JobLog> toEntityWrapper) {
		return repository.findExcelVo(toEntityWrapper);
	}

}
