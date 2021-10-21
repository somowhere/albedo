package com.albedo.java.common.core.exception.code;


/**
 * 异常编码
 *
 * @author somewhere
 * @date 2017-12-13 16:22
 */
public enum ResponseCode implements BaseExceptionCode {

	//系统相关 start
	SUCCESS(1, "成功"),
	FAIL(0, "失败"),
	SYSTEM_BUSY(-1, "系统繁忙~请稍后再试~"),
	SYSTEM_TIMEOUT(-2, "系统维护中~请稍后再试~"),
	PARAM_EX(-3, "参数类型解析异常"),
	SQL_EX(-4, "运行SQL出现异常"),
	NULL_POINT_EX(-5, "空指针异常"),
	ILLEGAL_ARGUMENT_EX(-6, "无效参数异常"),
	MEDIA_TYPE_EX(-7, "请求类型异常"),
	LOAD_RESOURCES_ERROR(-8, "加载资源出错"),
	BASE_VALID_PARAM(-9, "统一验证参数异常"),
	OPERATION_EX(-10, "操作异常"),
	SERVICE_MAPPER_ERROR(-11, "Mapper类转换异常"),
	CAPTCHA_ERROR(-12, "验证码校验失败"),
	JSON_PARSE_ERROR(-13, "JSON解析异常"),


	OK(200, "OK"),
	BAD_REQUEST(400, "错误的请求"),
	/**
	 * {@code 401 Unauthorized}. 需要重新登录。
	 * 该HTTP状态码表示认证错误，它是为了认证设计的，而不是为了授权设计的。收到401响应，表示请求没有被认证—压根没有认证或者认证不正确—但是请重新认证和重试。（一般在响应头部包含一个WWW-Authenticate来描述如何认证）。通常由web服务器返回，而不是web应用。从性质上来说是临时的东西。（服务器要求客户端重试）
	 *
	 * @see <a href="http://tools.ietf.org/html/rfc7235#section-3.1">HTTP/1.1: Authentication, section 3.1</a>
	 */
	UNAUTHORIZED(401, "未认证"),
	/**
	 * 该HTTP状态码是关于授权方面的。从性质上来说是永久的东西，和应用的业务逻辑相关联。它比401更具体，更实际。收到403响应表示服务器完成认证过程，但是客户端请求没有权限去访问要求的资源。
	 */
	FORBIDDEN(403, "禁止访问"),
	/**
	 * {@code 404 Not Found}.
	 *
	 * @see <a href="http://tools.ietf.org/html/rfc7231#section-6.5.4">HTTP/1.1: Semantics and Content, section 6.5.4</a>
	 */
	NOT_FOUND(404, "没有找到资源"),
	METHOD_NOT_ALLOWED(405, "不支持当前请求类型"),

	TOO_MANY_REQUESTS(429, "请求超过次数限制"),
	INTERNAL_SERVER_ERROR(500, "内部服务错误"),
	BAD_GATEWAY(502, "网关错误"),
	GATEWAY_TIMEOUT(504, "网关超时"),
	//系统相关 end

	REQUIRED_FILE_PARAM_EX(1001, "请求中必须至少包含一个有效文件"),

	DATA_SAVE_ERROR(2000, "新增数据失败"),
	DATA_UPDATE_ERROR(2001, "修改数据失败"),
	TOO_MUCH_DATA_ERROR(2002, "批量新增数据过多"),
	//jwt token 相关 start

	JWT_BASIC_INVALID(40000, "无效的基本身份验证令牌"),
	JWT_TOKEN_EXPIRED(40001, "会话超时，请重新登录"),
	JWT_SIGNATURE(40002, "不合法的token，请认真比对 token 的签名"),
	JWT_ILLEGAL_ARGUMENT(40003, "缺少token参数"),
	JWT_GEN_TOKEN_FAIL(40004, "生成token失败"),
	JWT_PARSER_TOKEN_FAIL(40005, "解析用户身份错误，请重新登录！"),
	JWT_USER_INVALID(40006, "用户名或密码错误"),
	JWT_USER_ENABLED(40007, "用户已经被禁用！"),
	JWT_OFFLINE(40008, "您已在另一个设备登录！"),
	JWT_NOT_LOGIN(40009, "登录超时，请重新登录！"),
	//jwt token 相关 end

	;

	private final int code;
	private String message;

	ResponseCode(int code, String message) {
		this.code = code;
		this.message = message;
	}

	@Override
	public int getCode() {
		return code;
	}

	@Override
	public String getMessage() {
		return message;
	}


	public ResponseCode build(String message, Object... param) {
		this.message = String.format(message, param);
		return this;
	}

	public ResponseCode param(Object... param) {
		message = String.format(message, param);
		return this;
	}
}
