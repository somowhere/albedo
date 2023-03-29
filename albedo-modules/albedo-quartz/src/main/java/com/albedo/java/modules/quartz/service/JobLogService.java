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

package com.albedo.java.modules.quartz.service;

import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.modules.quartz.domain.JobLogDo;
import com.albedo.java.modules.quartz.domain.dto.JobLogQueryDto;
import com.albedo.java.modules.quartz.domain.vo.JobLogExcelVo;
import com.albedo.java.plugins.database.mybatis.service.BaseService;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;

/**
 * 任务调度日志Service 任务调度日志
 *
 * @author admin
 * @version 2019-08-14 11:25:03
 */
public interface JobLogService extends BaseService<JobLogDo> {

	/**
	 * 清空日志
	 */
	void cleanJobLog();

	/**
	 * 获取导出集合
	 *
	 * @param toEntityWrapper
	 * @return
	 */
	List<JobLogExcelVo> findExcelVo(JobLogQueryDto jobLogQueryDto);

	IPage<JobLogDo> findPage(PageModel<JobLogDo> pageModel, JobLogQueryDto jobLogQueryDto);
}
