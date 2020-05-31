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
	private Integer jobId;
	private String jobGroup;
	private String data;

	public ScheduleVo(ScheduleConstants.MessageType messageType, Integer jobId, String jobGroup) {
		this.messageType = messageType;
		this.jobId = jobId;
		this.jobGroup = jobGroup;
	}

	public ScheduleVo(ScheduleConstants.MessageType messageType, Integer jobId) {
		this.messageType = messageType;
		this.jobId = jobId;
	}

	public static ScheduleVo create(ScheduleConstants.MessageType messageType, Integer jobId, String jobGroup) {
		return new ScheduleVo(messageType, jobId, jobGroup);
	}

	public static ScheduleVo create(ScheduleConstants.MessageType messageType, Integer jobId) {
		return new ScheduleVo(messageType, jobId);
	}

	public static ScheduleVo createData(ScheduleConstants.MessageType messageType, String data) {
		return new ScheduleVo(messageType, null, null, data);
	}

	public static ScheduleVo createPause(Integer jobId, String jobGroup) {
		return create(ScheduleConstants.MessageType.PAUSE, jobId, jobGroup);
	}

	public static Object createResume(Integer jobId, String jobGroup) {
		return create(ScheduleConstants.MessageType.RESUME, jobId, jobGroup);
	}

	public static Object createDelete(Integer jobId, String jobGroup) {
		return create(ScheduleConstants.MessageType.DELETE, jobId, jobGroup);
	}

	public static Object createRun(Integer jobId, String jobGroup) {
		return create(ScheduleConstants.MessageType.RUN, jobId, jobGroup);
	}

	public static Object createDataAdd(String data) {
		return createData(ScheduleConstants.MessageType.ADD, data);
	}

	public static Object createDataUpdate(String data, String jobGroup) {
		return new ScheduleVo(ScheduleConstants.MessageType.UPDATE, null, jobGroup, data);
	}
}
