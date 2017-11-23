package com.albedo.java.common.security;

public class SecurityConstants {

    public static String loginUrl = "/login";
    public static String logoutUrl = "/logout";
    public static String authLogin = "/authenticate";

    public static final String AUTHORIZATION_HEADER = "Authorization";

    public static String[] authorizePermitAll = {"/management/health",
            "/profile-info",
            "/v2/api-docs/**", "/swagger-resources/configuration/ui", "/swagger-ui/index.html"};

    /**
     * 线程变量绑定
     */
    private static final ThreadLocal<String> currentUrlHolder = new ThreadLocal<String>();
    /**
     * @Description: 设置数据源类型
     * @param dataSource  数据源名称
     * @return void
     * @throws
     */
    public static void setCurrentUrl(String dataSource) {
        currentUrlHolder.set(dataSource);
    }

    /**
     * @Description: 获取数据源名称
     * @param
     * @return String
     * @throws
     */
    public static String getCurrentUrl() {
        return currentUrlHolder.get();
    }


}
