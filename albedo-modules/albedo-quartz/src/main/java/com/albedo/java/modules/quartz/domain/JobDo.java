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

package com.albedo.java.modules.quartz.domain;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.constant.DictNameConstants;
import com.albedo.java.common.core.domain.BaseDataDo;
import com.albedo.java.common.core.domain.GeneralDo;
import com.albedo.java.modules.quartz.domain.enums.JobConcurrent;
import com.albedo.java.modules.quartz.domain.enums.JobMisfirePolicy;
import com.albedo.java.modules.quartz.domain.enums.JobStatus;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Objects;

/**
 * 任务调度Entity 任务调度
 *
 * @author admin
 * @version 2019-08-14 11:24:16
 */
@TableName(value = "sys_job")
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class JobDo extends BaseDataDo<JobDo, Long> {

	/**
	 * F_NAME name : 任务名称
	 */
	public static final String F_NAME = "name";

	/**
	 * F_SQL_NAME name : 任务名称
	 */
	public static final String F_SQL_NAME = "name";

	/**
	 * F_GROUP group : 任务组名
	 */
	public static final String F_GROUP = "group";

	/**
	 * F_SQL_GROUP group : 任务组名
	 */
	public static final String F_SQL_GROUP = "group";

	/**
	 * F_INVOKETARGET invoke_target : 调用目标字符串
	 */
	public static final String F_INVOKETARGET = "invokeTarget";

	/**
	 * F_SQL_INVOKETARGET invoke_target : 调用目标字符串
	 */
	public static final String F_SQL_INVOKETARGET = "invoke_target";

	/**
	 * F_CRONEXPRESSION cron_expression : cron执行表达式
	 */
	public static final String F_CRONEXPRESSION = "cronExpression";

	/**
	 * F_SQL_CRONEXPRESSION cron_expression : cron执行表达式
	 */
	public static final String F_SQL_CRONEXPRESSION = "cron_expression";

	/**
	 * F_MISFIREPOLICY misfire_policy : 计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	public static final String F_MISFIREPOLICY = "misfirePolicy";

	/**
	 * F_SQL_MISFIREPOLICY misfire_policy : 计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	public static final String F_SQL_MISFIREPOLICY = "misfire_policy";

	/**
	 * F_CONCURRENT concurrent : 是否并发执行（1允许 0禁止）
	 */
	public static final String F_CONCURRENT = "concurrent";

	/**
	 * F_SQL_CONCURRENT concurrent : 是否并发执行（1允许 0禁止）
	 */
	public static final String F_SQL_CONCURRENT = "concurrent";

	/**
	 * F_AVAILABLE available : 状态(1-正常，0-锁定)
	 */
	public static final String F_STATUS = "status";

	/**
	 * F_SQL_AVAILABLE available : 状态(1-正常，0-锁定)
	 */
	public static final String F_SQL_STATUS = "status";

	private static final long serialVersionUID = 1L;

	@TableId(value = GeneralDo.F_SQL_ID, type = IdType.AUTO)
	protected Long id;

	/**
	 * name 任务名称
	 */
	@NotBlank
	@Size(max = 64)
	@TableField("name")
	private String name;

	/**
	 * group 任务组名
	 */
	@NotBlank
	@Size(max = 64)
	@TableField("`group`")
	@DictType(DictNameConstants.QUARTZ_JOB_GROUP)
	private String group;

	/**
	 * invokeTarget 调用目标字符串
	 */
	@NotBlank
	@Size(max = 500)
	@TableField("invoke_target")
	private String invokeTarget;

	/**
	 * cronExpression cron执行表达式
	 */
	@Size(max = 255)
	@TableField("cron_expression")
	private String cronExpression;

	/**
	 * misfirePolicy 计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	@Size(max = 20)
	@TableField("misfire_policy")
	private JobMisfirePolicy misfirePolicy;

	/**
	 * concurrent 是否并发执行（1允许 0禁止）
	 */
	@Size(max = 1)
	@TableField("concurrent")
	private JobConcurrent concurrent;

	/**
	 * status 状态(1-运行中，0-暂停)
	 */
	@Size(max = 20)
	private JobStatus status;

	/**
	 * 报警邮箱
	 */
	private String email;

	private String tenantCode;

	@Override
	public Serializable pkVal() {
		return this.getId();
	}

	@Override
	public void setPk(Long pk) {
		this.setId(pk);
	}

	@Override
	public boolean equals(Object o) {

		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		JobDo jobDo = (JobDo) o;
		if (jobDo.getId() == null || getId() == null) {
			return false;
		}
		return Objects.equals(getId(), jobDo.getId());
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(getId());
	}

}
