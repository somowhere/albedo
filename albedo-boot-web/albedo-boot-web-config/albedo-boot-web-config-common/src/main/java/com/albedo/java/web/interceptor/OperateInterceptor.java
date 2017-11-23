package com.albedo.java.web.interceptor;

import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.util.DateUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.annotation.ParamNotNull;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.web.rest.base.BaseResource;
import com.albedo.java.web.rest.util.RequestUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.NamedThreadLocal;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

public class OperateInterceptor implements HandlerInterceptor {

    public static final String TOKEN_NAME = "Albedo-Requst-Token";
    public static final String SESSION_TOKEN = "sessionToken";
    public static final String REQUEST_TOKEN = "requestToken";
    private static final ThreadLocal<Long> startTimeThreadLocal = new NamedThreadLocal<Long>("ThreadLocal StartTime");
    protected Logger logger = LoggerFactory.getLogger(getClass());
    private boolean isTokenInterceptor;
    private String freeURL;

    /**
     * 同一session客户端 访问根地址 免验证次数记录map
     */
    // private Map<String, Integer> sessionPassCountMap = Maps.newHashMap();
    public OperateInterceptor(AlbedoProperties albedoProperties) {
        isTokenInterceptor = albedoProperties.getIsTokenInterceptor();
        freeURL = albedoProperties.getFreeURL();
    }

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // Long checkTime = new Date().getTime();
        boolean flag = false;
        if (isTokenInterceptor) {
            String msg = "{\"_success\" : false,\"_operationMsg\": \"非正常访问，属于非法客户端!\"}";
            String requestURI = request.getRequestURI();
            if (PublicUtil.isNotEmpty(freeURL)) {
                String urlValue[] = freeURL.split(",");
                if (PublicUtil.isNotEmpty(urlValue)) {
                    String as[];
                    int j = (as = urlValue).length;
                    for (int i = 0; i < j; i++) {
                        String url = as[i];
                        if (requestURI.indexOf(url) != -1) {
                            flag = true;
                            break;
                        }
                    }
                }
            }
            if (!flag) {
                HttpSession session = request.getSession();
                String sessionToken;
                try {
                    String requestType = request.getHeader("X-Requested-With");
                    if ("XMLHttpRequest".equals(requestType)) {
                        sessionToken = request.getHeader(TOKEN_NAME);
                        if (PublicUtil.isNotEmpty(sessionToken) && sessionToken.indexOf("||") != -1) {
                            String token = (String) session.getAttribute(SESSION_TOKEN);
                            if (!sessionToken.equals(token)) {
                                flag = true;
                            } else {
                                logger.warn("客户端ajax防重复验证生效：客户端多次提交 sessionToken:{}", sessionToken);
                                msg = "{\"_success\" : false,\"_operationMsg\" : \"对不起,请勿重复提交!\"}";
                            }
                            session.setAttribute(SESSION_TOKEN, sessionToken);
                        }
                    } else {
                        flag = true;
                    }
                    // } else {

                    // String sessionId = session.getId();
                    // Integer count = sessionPassCountMap.get(sessionId);
                    // if ((PublicUtil.isEmpty(sessionToken) &&
                    // requestURI.equals(PublicUtil.toAppendStr(SystemConfig.getAdminPath(),
                    // "/")) && (count == null || count < 3))) {
                    // sessionPassCountMap.put(sessionId, count == null ? 1 :
                    // ++count);
                    // flag = true;
                    // } else if(DesUtil.checkSessionKey(sessionToken,
                    // checkTime) || (PublicUtil.isNotEmpty(sessionToken) &&
                    // sessionToken.equals(request.getParameter(REQUEST_TOKEN)))){
                    // flag = true;
                    // } else {
                    // logger.warn("客户端防重复验证生效：客户端多次提交 requestToken:{}",
                    // sessionToken);
                    // msg =
                    // "{\"_success\" : false,\"_operationMsg\" : \"对不起,请勿重复提交!\"}";
                    // }
                    // }
                } catch (IllegalStateException e) {
                    flag = false;
                    msg = PublicUtil.toAppendStr(
                            "{\"_success\" : false,\"_operationMsg\" : \"Error creating HttpSession due response is commited to client. You can use the CreateSessionInterceptor or create the HttpSession from your action before the result is rendered to the client: ",
                            e.getMessage(), "\"}");
                    e.printStackTrace();
                }
                if (!flag) {
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(msg);
                    // request.getSession().setAttribute(SESSION_TOKEN,
                    // DesUtil.getSessionKey());
                    return flag;
                }
            }
        } else {
            flag = true;
        }
        long beginTime = System.currentTimeMillis();// 1、开始时间
        startTimeThreadLocal.set(beginTime); // 线程绑定变量（该数据只有当前请求的线程可见）
        if (flag) {
            if (handler instanceof HandlerMethod) {
                HandlerMethod handlerMethod = (HandlerMethod) handler;
                // 接口参数非空验证
                ParamNotNull appNotNull = handlerMethod.getMethodAnnotation(ParamNotNull.class);
                if (appNotNull != null) {
                    List<String> props = Lists.newArrayList(appNotNull.props());
                    List<String> paramList = Reflections.getMethodParameterList(handlerMethod.getBeanType(), handlerMethod.getMethod().getName());
                    for (String paramKey : paramList) {
                        if ((PublicUtil.isEmpty(props) || props.contains(paramKey)) && PublicUtil.isEmpty(request.getParameter(paramKey))) {
                            BaseResource.writeStringHttpResponse(PublicUtil.toAppendStr("操作失败，参数[" + paramKey + "]不能为空"), response);
                            flag = false;
                            break;
                        }
                    }
                }
            }
            if (logger.isDebugEnabled())
                logger.info("开始计时: {}  URI: {}", new SimpleDateFormat("hh:mm:ss.SSS").format(beginTime), request.getRequestURI());
        } else {
            writeUrl(request, response, "/");
        }
        return flag;
    }

    public void writeUrl(HttpServletRequest request, HttpServletResponse response, String url) throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        StringBuffer path = new StringBuffer("<script> window.top.location.href='").append(request.getScheme()).append("://").append(request.getServerName()).append(":").append(request.getServerPort()).append(request.getContextPath());
        path.append(url).append("'</script>").toString();
        response.getWriter().println(path.toString());
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // if (modelAndView != null) {
        // String viewName = modelAndView.getViewName();
        // UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
        // if (viewName.startsWith("a/") && DeviceType.MOBILE.equals(userAgent.getOperatingSystem().getDeviceType())) {
        // modelAndView.setViewName(viewName.replaceFirst("a", "mobile"));
        // }
        // }
    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        long beginTime = startTimeThreadLocal.get();// 得到线程绑定的局部变量（开始时间）
        long endTime = System.currentTimeMillis(); // 2、结束时间
        // 保存日志
//		LogUtil.saveLog(request, handler, ex, endTime - beginTime, null);
        // 打印JVM信息。
        Map<String, String> params = Maps.newHashMap();
        Enumeration<String> keys = request.getParameterNames();
        String key;
        while (keys.hasMoreElements()) {
            key = keys.nextElement();
            params.put(key, StringUtil.abbr(StringUtil.endsWithIgnoreCase(key, "password") ? "" : request.getParameter(key), 100));
        }
        logger.info("IP：{} 计时结束：{}  耗时：{}  URI: {} params: {} ", RequestUtil.getRemoteAddr(request), new SimpleDateFormat("hh:mm:ss.SSS").format(endTime), DateUtil.formatDateTime(endTime - beginTime), request.getRequestURI(), params);
    }
}
