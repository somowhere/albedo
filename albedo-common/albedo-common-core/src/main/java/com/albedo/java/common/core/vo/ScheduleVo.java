package com.albedo.java.common.core.vo;

import com.albedo.java.common.core.constant.ScheduleConstants;
import lombok.*;

import java.io.Serializable;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleVo implements Serializable {

	private ScheduleConstants.MessageType messageType;
	private String jobId;
	private String jobGroup;
	private String data;

	public ScheduleVo(ScheduleConstants.MessageType messageType, String jobId, String jobGroup) {
		this.messageType = messageType;
		this.jobId = jobId;
		this.jobGroup = jobGroup;
	}
	public ScheduleVo(ScheduleConstants.MessageType messageType, String jobId) {
		this.messageType = messageType;
		this.jobId = jobId;
	}

	public static ScheduleVo create(ScheduleConstants.MessageType messageType, String jobId, String jobGroup){
		return new ScheduleVo(messageType, jobId, jobGroup);
	}

	public static ScheduleVo create(ScheduleConstants.MessageType messageType, String jobId){
		return new ScheduleVo(messageType, jobId);
	}
	public static ScheduleVo createData(ScheduleConstants.MessageType messageType, String data){
		return new ScheduleVo(messageType, null,null, data);
	}
	public static ScheduleVo createPause(String jobId, String jobGroup){
		return create(ScheduleConstants.MessageType.PAUSE, jobId, jobGroup);
	}

	public static Object createResume(String jobId, String jobGroup) {
		return create(ScheduleConstants.MessageType.RESUME, jobId, jobGroup);
	}

	public static Object createDelete(String jobId, String jobGroup) {
		return create(ScheduleConstants.MessageType.DELETE, jobId, jobGroup);
	}

	public static Object createRun(String jobId, String jobGroup) {
		return create(ScheduleConstants.MessageType.RUN, jobId, jobGroup);
	}
	public static Object createDataAdd(String data) {
		return createData(ScheduleConstants.MessageType.ADD, data);
	}
	public static Object createDataUpdate(String data, String jobGroup) {
		return new ScheduleVo(ScheduleConstants.MessageType.UPDATE, null, jobGroup, data);
	}
}
