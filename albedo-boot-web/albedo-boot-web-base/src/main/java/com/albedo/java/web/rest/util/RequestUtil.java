package com.albedo.java.web.rest.util;

import com.albedo.java.util.base.Encodes;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Enumeration;

public class RequestUtil {
    protected static Logger logger = LoggerFactory.getLogger(RequestUtil.class);

    /**
     * 获得用户远程地址
     */
    public static String getRemoteAddr(HttpServletRequest request) {
        String ipAddress = null;
        ipAddress = request.getHeader("x-forwarded-for");
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getRemoteAddr();
            if (ipAddress.equals("127.0.0.1")) {
                // 根据网卡取本机配置的IP
                InetAddress inet = null;
                try {
                    inet = InetAddress.getLocalHost();
                } catch (UnknownHostException e) {
                    e.printStackTrace();
                }
                ipAddress = inet.getHostAddress();
            }

        }
        // 对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
        if (ipAddress != null && ipAddress.length() > 15) { // "***.***.***.***".length()
            // = 15
            if (ipAddress.indexOf(",") > 0) {
                ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
            }
        }
        return ipAddress;
    }

    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("X-Real-IP");
        if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip))
            return ip;
        ip = request.getHeader("X-Forwarded-For");
        if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
            int index = ip.indexOf(',');
            if (index != -1)
                return ip.substring(0, index);
            else
                return ip;
        } else {
            return request.getRemoteAddr();
        }
    }

    public static String getUserAgent(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        if (!StringUtils.isBlank(userAgent))
            return userAgent;
        else
            return null;
    }

    public static String getRequestBrowser(HttpServletRequest request) {
        String userAgent = getUserAgent(request);
        String agent = null;
        String agents[] = userAgent.split(";");
        if (agents.length > 1) {
            agent = agents[1].trim();
            if (StringUtils.isNotBlank(agent))
                return agent;
            else
                return agent;
        } else {
            agent = userAgent.substring(0, userAgent.lastIndexOf(" "));
            agent = userAgent.substring(agent.lastIndexOf(" "), userAgent.length());
            return agent;
        }

    }

    public static boolean isRestfulRequest(HttpServletRequest request) {
        String requestType = request.getHeader("X-Requested-With");
        return Globals.XML_HTTP_REQUEST.equals(requestType);

    }




    public static <T> T parseObject(Class<T> classType, HttpServletRequest request) {
        Object obj = null;
        if (classType != null) {
            try {
                obj = classType.newInstance();
            } catch (Exception e) {
                e.printStackTrace();
                logger.warn("构建对象异常：" + e.getMessage());
            }
        }
        Enumeration<String> keys = request.getParameterNames();
        String key;
        while (keys.hasMoreElements()) {
            key = keys.nextElement();
            if (!key.contains(".")) {
                continue;
            }
            String val = Encodes.urlDecode(request.getParameter(key));
            key = key.substring(key.indexOf(".") + 1);
            try {
                Reflections.setProperty(obj, key, val);
            } catch (Exception e) {
                logger.info(e.getMessage());
            }
        }
        return (T) obj;
    }

    public String getRequestOs(HttpServletRequest request) {
        String userAgent = getUserAgent(request);
        String agents[] = userAgent.split(";");
        if (agents.length > 2)
            return agents[2].trim();
        else
            return null;
    }

}
