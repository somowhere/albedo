package com.albedo.java.web.rest.util;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.config.SystemConfig;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 * Cookie工具类
 *
 * @author Lijie
 * @version 2013-01-15
 */
public class CookieUtil {

    public final static String THEME_KEY = "theme";

    public static String getTheme() {
        HttpServletRequest request = null;
        try {
            request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        } catch (Exception e) {
            if (request == null)
                return "cerulean";
        }
        String rs = CookieUtil.getCookie(request, CookieUtil.getkey(CookieUtil.THEME_KEY));
        return PublicUtil.isEmpty(rs) ? "cerulean" : rs;
    }

    /**
     * 获取与当前登陆用户关联的唯一key,如果没有登陆用户则不对应
     *
     * @param key
     * @return
     */
    public static String getkey(String key) {
        return PublicUtil.toAppendStr(SystemConfig.get("productName"), key);
    }

    /**
     * 设置 Cookie（生成时间为1天）
     *
     * @param name  名称
     * @param value 值
     */
    public static void setCookie(HttpServletResponse response, String name, String value) {
        setCookie(response, name, value, 60 * 60 * 24);
    }

    /**
     * 设置 Cookie
     *
     * @param name   名称
     * @param value  值
     * @param maxAge 生存时间（单位秒）
     */
    public static void setCookie(HttpServletResponse response, String name, String value, int maxAge) {
        Cookie cookie = new Cookie(name, null);
        cookie.setPath("/");
        cookie.setMaxAge(maxAge);
        try {
            cookie.setValue(URLEncoder.encode(value, "utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.addCookie(cookie);
    }
    /**
     * 获得指定Cookie的值
     *
     * @param name 名称
     * @return 值
     */
    public static String getCookie(HttpServletRequest request, String name) {
        return getCookie(request, null, name, false);
    }
    /**
     * 删除指定Cookie的值，。
     *
     * @param name 名称
     * @return 值
     */
    public static void removeCookie(HttpServletRequest request, HttpServletResponse response, String name) {
        getCookie(request, response, name, true);
    }
    /**
     * 获得指定Cookie的值，并删除。
     *
     * @param name 名称
     * @return 值
     */
    public static String getCookie(HttpServletRequest request, HttpServletResponse response, String name) {
        return getCookie(request, response, name, true);
    }

    /**
     * 获得指定Cookie的值
     *
     * @param request  请求对象
     * @param response 响应对象
     * @param name     名字
     * @param isRemove 是否移除
     * @return 值
     */
    public static String getCookie(HttpServletRequest request, HttpServletResponse response, String name, boolean isRemove) {
        String value = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    try {
                        value = URLDecoder.decode(cookie.getValue(), "utf-8");
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                    if (isRemove) {
                        cookie.setValue(null);
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                    }
                }
            }
        }
        return value;
    }

    /**
     * 删除指定Cookie的值
     *
     * @param request  请求对象
     * @param response 响应对象
     * @param name     名字
     * @return 值
     */
    public static void deleteCookie(HttpServletRequest request, HttpServletResponse response, String name) {
        getCookie(request, response, name, true);
    }

}
