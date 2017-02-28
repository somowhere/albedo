package com.albedo.java.util;

import com.albedo.java.util.config.SystemConfig;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

/**
 * @ClassName: SMSUtil
 * @Description: 聚合数据短信推送
 * @author lijie
 * @date 2015年10月22日 下午4:54:10
 */
public class SMSUtil {
	protected static Logger logger = LoggerFactory.getLogger(SMSUtil.class);

	static String url = "http://v.juhe.cn/sms/send?mobile=";
	static String key = "f7118b8b6e40b635dcc16d76b3b73f63";// 申请的对应key

	static boolean isSend = SystemConfig.getBoolean("sms.is.send");

	/**
	 * @Title: send @Description: TODO(这里用一句话描述这个方法的作用) @param @param paramStr 内容参数 "&#code#=" + value @param @param moduleId 模版编号 @param @param mobile 手机号 @param @return 设定参数 @return JSONObject 返回类型 @throws
	 */
	public static JSONObject send(String paramStr, int moduleId, String mobile) {
		if (isSend) {
			String str = "#company#=创信学车" + paramStr;
			String tvalue;
			try {
				tvalue = URLEncoder.encode(str, "utf-8");
			} catch (UnsupportedEncodingException e) {
				tvalue = "";
				e.printStackTrace();
			}
			String urlAll = new StringBuffer(SMSUtil.url).append(mobile).append("&key=").append(SMSUtil.key).append("&dtype=json").append("&tpl_id=").append(moduleId).append("&tpl_value=").append(tvalue).toString();
			String charset = "UTF-8";
			String jsonResult = get(urlAll, charset);// 得到JSON字符串
			logger.info("rs:" + jsonResult);
			JSONObject object = JSONObject.parseObject(jsonResult);// 转化为JSON类
			if (object == null)
				object = new JSONObject();
			return object;
		} else {
			logger.warn("并未设置sms.is.send为true,短信发送失败");
		}
		return new JSONObject();
	}

	/**
	 * @Title: send @Description: TODO(这里用一句话描述这个方法的作用) @param @param paramStr 内容参数 "&#code#=" + value @param @param moduleId 模版编号 @param @param mobile 手机号 @param @param sleepTime 休眠时间 @param @return 设定参数 @return JSONObject 返回类型 @throws
	 */
	public static void send(String paramStr, int moduleId, String mobile, long sleepTime) {
		SMSSendThread sendThread = new SMSSendThread(paramStr, moduleId, mobile, sleepTime);
		sendThread.start();
	}

	public static String get(String urlAll, String charset) {
		String result = HttpUtil.sendGetRequestString(urlAll);
		return result;
	}
}

class SMSSendThread extends Thread {
	private long sleepTime = 0;
	protected Logger logger = LoggerFactory.getLogger(SMSSendThread.class);
	String paramStr;
	int moduleId;
	String mobile;

	public SMSSendThread(String paramStr, int moduleId, String mobile, long sleepTime) {
		this.paramStr = paramStr;
		this.moduleId = moduleId;
		this.mobile = mobile;
		this.sleepTime = sleepTime;
	}

	public void run() {
		if (sleepTime > 0) {
			try {
				Thread.sleep(sleepTime);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			sleepTime = 0;
		}
		SMSUtil.send(paramStr, moduleId, mobile);
	}

}