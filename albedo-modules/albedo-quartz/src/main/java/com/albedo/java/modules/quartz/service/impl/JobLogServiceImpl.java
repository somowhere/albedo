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

package com.albedo.java.modules.quartz.service.impl;

import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.modules.quartz.domain.JobLogDo;
import com.albedo.java.modules.quartz.domain.dto.JobLogQueryDto;
import com.albedo.java.modules.quartz.domain.vo.JobLogExcelVo;
import com.albedo.java.modules.quartz.repository.JobLogRepository;
import com.albedo.java.modules.quartz.service.JobLogService;
import com.albedo.java.plugins.database.mybatis.conditions.Wraps;
import com.albedo.java.plugins.database.mybatis.service.impl.BaseServiceImpl;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
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
public class JobLogServiceImpl extends BaseServiceImpl<JobLogRepository, JobLogDo> implements JobLogService {

	@Override
	public void cleanJobLog() {
		repository.cleanJobLog();
	}

	@Override
	public List<JobLogExcelVo> findExcelVo(JobLogQueryDto jobLogQueryDto) {
		return repository.findExcelVo(getWrapperByJobLogQueryDto(jobLogQueryDto));
	}

	@Override
	public IPage<JobLogDo> findPage(PageModel<JobLogDo> pageModel, JobLogQueryDto jobLogQueryDto) {
		return this.page(pageModel, getWrapperByJobLogQueryDto(jobLogQueryDto));
	}

	private Wrapper<JobLogDo> getWrapperByJobLogQueryDto(JobLogQueryDto jobLogQueryDto) {
		return Wraps.<JobLogDo>lambdaQueryWrapperX()
			.eqIfPresent(JobLogDo::getStatus, jobLogQueryDto.getStatus())
			.betweenIfPresent(JobLogDo::getCreatedDate, jobLogQueryDto.getCreatedDate())
			.or(jobLogQueryDto.getBlurry() != null, jobLogDoLambdaQueryWrapper -> jobLogDoLambdaQueryWrapper
				.like(JobLogDo::getJobName, jobLogQueryDto.getBlurry())
				.like(JobLogDo::getJobGroup, jobLogQueryDto.getBlurry())
				.like(JobLogDo::getDescription, jobLogQueryDto.getBlurry())
			);
	}

}
