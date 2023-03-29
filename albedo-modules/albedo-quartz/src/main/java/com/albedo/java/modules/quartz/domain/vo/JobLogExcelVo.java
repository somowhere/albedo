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

package com.albedo.java.modules.quartz.domain.vo;

import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.util.DateUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;

/**
 * 定时任务调度日志表 sys_job_log
 *
 * @author somewhere
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class JobLogExcelVo implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * ID
	 */
	@ExcelField(title = "日志序号")
	private String id;

	/**
	 * 任务名称
	 */
	@ExcelField(title = "任务名称")
	private String jobName;

	/**
	 * 任务组名
	 */
	@ExcelField(title = "任务组名")
	private String jobGroup;

	/**
	 * 调用目标字符串
	 */
	@ExcelField(title = "调用目标字符串")
	private String invokeTarget;

	/**
	 * 日志信息
	 */
	@ExcelField(title = "日志信息")
	private String jobMessage;

	/**
	 * 执行状态（0正常 1失败）
	 */
	@ExcelField(title = "执行状态", readConverterExp = "1=正常,0=失败")
	private String status;

	/**
	 * 开始时间
	 */
	@ExcelField(title = "开始时间", dateFormat = DateUtil.TIME_FORMAT)
	private Date startTime;

	/**
	 * 结束时间
	 */
	@ExcelField(title = "结束时间", dateFormat = DateUtil.TIME_FORMAT)
	private Date endTime;

	/**
	 * 异常信息
	 */
	@ExcelField(title = "异常信息")
	private String exceptionInfo;

}
