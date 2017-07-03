package com.albedo.java.util.domain;

/**
 * 系统常量 Copyright 2013 albedo All right reserved Author lijie Created on 2013-10-23 下午5:44:16
 */
public class Constant {
    /**
     * 是否
     **/
    public static final Integer YES = 1;
    public static final Integer NO = 0;
    public static final String Yes = "1";
    public static final String No = "0";
    /**
     * debug模式 yes or no
     */
    public final static String SYSTEM_DEMO_STYLE = "system.demo.style";
    /**
     * 图标根路径
     */
    public final static String SYSTEM_ICON_PATH = "system.icon.path";
    /**
     * 上传目录根路径
     */
    public final static String SYSTEM_FILE_UPLOAD_ROOT_PATH = "system.file.upload.root.path";
    /**
     * 是否缓存静态文件 yes or no
     */
    public final static String SYSTEM_CACHE_STATIC_FILE = "system.cache.static.file";
    /**
     * 缓存静态文件的时间
     */
    public final static String SYSTEM_CACHE_STATIC_MINUTE = "system.cache.static.minute";
    /**
     * 消息推送 yes or no
     */
    public final static String SYSTEM_COMET_FLAG = "system.comet.flag";
    /**
     * 要排除的特殊请求,如果有请填写 ,多个的话用 "," 隔开
     */
    public final static String SYSTEM_TOKEN_FREEURL = "system.token.freeURL";
    /**
     * 同一session客户端两次提交时间间隔最大值 毫秒
     */
    public final static String SYSTEM_TOKEN_MAX_TIME = "system.token.max.time";

    /**
     * 是否开启防表单重复提交 默认开启yes
     */
    public final static String SYSTEM_IS_TOKEN = "system.is.token";
    /**
     * memcached 服务端
     */
    public final static String MEMCACHED_SERVER = "memcached.server";
    /**
     * memcached 超时
     */
    public final static String MEMCACHED_EXPIRE_TIME = "memcached.expire.time";

    /**
     * 用户 在线
     */
    public final static String STAFF_ONLINE = "0";
    /**
     * 用户 离线
     */
    public final static String STAFF_OFFLINE = "1";

    /**
     * 通知前台用户上线、下线 注册方法名
     */
    public final static String STAFF_LINE = "staffLine";

    /**
     * session失效后的url存放位置
     */
    public final static String GLOBAL_RETURN_URL = "global_retun_url";
    /**
     * 在线用户监听
     */
    public final static String ONLINE_STAFF_LISTENER = "onlineStaffListener";
    /**
     * 推送消息监听
     */
    public final static String WAIT_SENT_INFO_LISTENER = "waitSendInfoListener";
    /**
     * 当前用户拥有菜单字符串
     */
    public final static String CURRENT_STAFF_MENU_STR = "CurrentStaffMenuStr";

}
