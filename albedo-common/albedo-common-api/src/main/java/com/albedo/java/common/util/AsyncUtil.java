package com.albedo.java.common.util;

import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import com.albedo.java.common.core.util.AddressUtil;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.modules.sys.domain.LogLogin;
import com.albedo.java.modules.sys.service.LogLoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Objects;
import java.util.TimerTask;

/**
 * 异步工厂（产生任务用）
 *
 * @author somewhere
 *
 */
public class AsyncUtil
{
    private static final Logger sys_user_logger = LoggerFactory.getLogger("sys-user");

    /**
     * 记录登陆信息
     *
     * @param username 用户名
     * @param status 状态
     * @param message 消息
     * @param args 列表
     * @return 任务task
     */
    public static TimerTask recordLogLogin(final String username, final String status,
										   final String message, final Object... args)
    {
		HttpServletRequest request = ((ServletRequestAttributes) Objects
			.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();

		UserAgent userAgent = UserAgentUtil.parse(request.getHeader("User-Agent"));
		final String ip = WebUtil.getIP(request);
        return new TimerTask()
        {
            @Override
            public void run()
            {
                String address = AddressUtil.getRealAddressByIP(ip);
                StringBuilder s = new StringBuilder();
                s.append(StringUtil.getBlock(ip));
                s.append(address);
                s.append(StringUtil.getBlock(username));
                s.append(StringUtil.getBlock(status));
                s.append(StringUtil.getBlock(message));
                // 打印信息到日志
                sys_user_logger.info(s.toString(), args);
                // 封装对象
                LogLogin logLogin = new LogLogin();
				logLogin.setLoginName(username);
				logLogin.setIpAddress(ip);
				logLogin.setLoginLocation(address);
				logLogin.setBrowser(userAgent.getBrowser().getName());
				logLogin.setOs(userAgent.getOs().getName());
				logLogin.setMessage(message);
				// 日志状态
				logLogin.setStatus(status);
                // 插入数据
                SpringContextHolder.getBean(LogLoginService.class).save(logLogin);
            }
        };
    }
}
