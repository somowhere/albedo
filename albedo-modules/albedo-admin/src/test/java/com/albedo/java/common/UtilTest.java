package com.albedo.java.common;


import cn.hutool.core.net.URLEncoder;
import cn.hutool.core.util.EscapeUtil;
import cn.hutool.http.HtmlUtil;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

public class UtilTest {
	public static void main(String[] args) throws UnsupportedEncodingException {
		String rs = "Webhook \u7684 payload POST \u65f6\u5fc5\u987b\u662f JSON \u5b57\u7b26\u4e32";
		System.out.println(EscapeUtil.unescapeHtml4(rs));
		System.out.println(HtmlUtil.escape("测试"));
		String s = "%5B%7B%22format%22:%22%22,%22fieldName%22:%22a.username%22,%22attrType%22:%22String%22,%22fieldNode%22:%22%22,%22operate%22:%22like%22,%22weight%22:0,%22value%22:%22%E5%86%9C%E4%BF%A1%22,%22endValue%22:%22%22%7D%5D";
		System.out.println(EscapeUtil.unescape(s));
		System.out.println(URLDecoder.decode(s, "utf-8"));
	}
}
