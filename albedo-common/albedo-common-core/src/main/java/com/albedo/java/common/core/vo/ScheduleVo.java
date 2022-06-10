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

package com.albedo.java.common.core.vo;

import com.albedo.java.common.core.constant.ScheduleConstants;
import com.albedo.java.common.core.context.ContextUtil;
import lombok.*;

import java.io.Serializable;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:11
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScheduleVo implements Serializable {

	private ScheduleConstants.MessageType messageType;

	private Long jobId;

	private String jobGroup;

	private String data;

	private String tenantCode;


	public static ScheduleVo create(ScheduleConstants.MessageType messageType, Long jobId, String jobGroup) {
		return ScheduleVo.builder().messageType(messageType).jobId(jobId).jobGroup(jobGroup).tenantCode(ContextUtil.getTenant()).build();
	}

	public static ScheduleVo create(ScheduleConstants.MessageType messageType, Long jobId) {
		return ScheduleVo.builder().messageType(messageType).jobId(jobId).tenantCode(ContextUtil.getTenant()).build();
	}

	public static ScheduleVo createData(ScheduleConstants.MessageType messageType, String data) {
		return ScheduleVo.builder().messageType(messageType).data(data).tenantCode(ContextUtil.getTenant()).build();
	}

	public static Object createDataUpdate(String data, String jobGroup) {
		return ScheduleVo.builder().messageType(ScheduleConstants.MessageType.UPDATE)
			.jobGroup(jobGroup).data(data).tenantCode(ContextUtil.getTenant()).build();

	}

	public static ScheduleVo createPause(Long jobId, String jobGroup) {
		return create(ScheduleConstants.MessageType.PAUSE, jobId, jobGroup);
	}

	public static Object createResume(Long jobId, String jobGroup) {
		return create(ScheduleConstants.MessageType.RESUME, jobId, jobGroup);
	}

	public static Object createDelete(Long jobId, String jobGroup) {
		return create(ScheduleConstants.MessageType.DELETE, jobId, jobGroup);
	}

	public static Object createRun(Long jobId, String jobGroup) {
		return create(ScheduleConstants.MessageType.RUN, jobId, jobGroup);
	}

	public static Object createDataAdd(String data) {
		return createData(ScheduleConstants.MessageType.ADD, data);
	}


}
