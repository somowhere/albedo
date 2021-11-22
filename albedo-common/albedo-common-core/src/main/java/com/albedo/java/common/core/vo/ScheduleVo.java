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

package com.albedo.java.common.core.vo;

import com.albedo.java.common.core.constant.ScheduleConstants;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

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
public class ScheduleVo implements Serializable {

	private ScheduleConstants.MessageType messageType;

	private Long jobId;

	private String jobGroup;

	private String data;

	public ScheduleVo(ScheduleConstants.MessageType messageType, Long jobId, String jobGroup) {
		this.messageType = messageType;
		this.jobId = jobId;
		this.jobGroup = jobGroup;
	}

	public ScheduleVo(ScheduleConstants.MessageType messageType, Long jobId) {
		this.messageType = messageType;
		this.jobId = jobId;
	}

	public static ScheduleVo create(ScheduleConstants.MessageType messageType, Long jobId, String jobGroup) {
		return new ScheduleVo(messageType, jobId, jobGroup);
	}

	public static ScheduleVo create(ScheduleConstants.MessageType messageType, Long jobId) {
		return new ScheduleVo(messageType, jobId);
	}

	public static ScheduleVo createData(ScheduleConstants.MessageType messageType, String data) {
		return new ScheduleVo(messageType, null, null, data);
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

	public static Object createDataUpdate(String data, String jobGroup) {
		return new ScheduleVo(ScheduleConstants.MessageType.UPDATE, null, jobGroup, data);
	}

}
