package com.albedo.java.util;

import com.albedo.java.util.config.SystemConfig;
import com.google.common.collect.Maps;

import java.util.Map;

public class LoginUtil {
    public final static String LOGIN_FAIL_MAP = "loginFailMap";

    /**
     * 是否是验证码登录
     *
     * @param useruame 用户名
     * @param isFail   计数加1
     * @param clean    计数清零
     * @return
     */
    public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean) {
        @SuppressWarnings("unchecked")
        Map<String, Integer> loginFailMap = (Map<String, Integer>) JedisUtil.getUser(LOGIN_FAIL_MAP);
        if (loginFailMap == null) {
            loginFailMap = Maps.newHashMap();
            JedisUtil.putUser(LOGIN_FAIL_MAP, loginFailMap);
        }
        Integer loginFailNum = loginFailMap.get(useruame);
        if (loginFailNum == null) {
            loginFailNum = 0;
        }
        if (isFail) {
            loginFailNum++;
            loginFailMap.put(useruame, loginFailNum);
        }
        if (clean) {
            loginFailMap.remove(useruame);
        }
        return SystemConfig.isDevelopMode() ? false : loginFailNum >= 3;
    }
}
