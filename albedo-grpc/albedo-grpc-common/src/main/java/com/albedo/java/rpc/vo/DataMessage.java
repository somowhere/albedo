package com.albedo.java.rpc.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * Created by lijie on 2017/5/16.
 *
 * @author 837158334@qq.com
 */
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class DataMessage {

	private int status;
	private String msg;
	private String data;

	public static DataMessage create(int status, String msg, String data) {
		return new DataMessage(status, msg, data);
	}

	public static DataMessage createMsg(int status, String msg) {
		return new DataMessage(status, msg, null);
	}

	public static DataMessage createData(int status, String data) {
		return new DataMessage(status, null, data);
	}
}
