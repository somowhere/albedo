package com.albedo.java.common.util;

import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.log.enums.OperatorType;
import com.albedo.java.common.log.event.SysLogEvent;
import com.albedo.java.modules.sys.domain.LogOperate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 异步工厂（产生任务用）
 *
 * @author somewhere
 */
public class AsyncUtil {
	private static final Logger sys_user_logger = LoggerFactory.getLogger("sys-user");

	/**
	 * 记录登陆信息
	 *
	 * @param logOperate   日志
	 */
	public static void recordLogLogin(LogOperate logOperate) {

		logOperate.setBusinessType(BusinessType.LOGIN.name());
		logOperate.setOperatorType(OperatorType.MANAGE.name());
		// 打印信息到日志
		sys_user_logger.info("[logOperateVo]:{}", logOperate);
		// 发送异步日志事件
		SpringContextHolder.publishEvent(new SysLogEvent(logOperate));
	}
}
