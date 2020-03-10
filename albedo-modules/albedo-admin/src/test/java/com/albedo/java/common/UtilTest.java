package com.albedo.java.common;


import cn.hutool.core.util.EscapeUtil;
import cn.hutool.http.HtmlUtil;

public class UtilTest {
	public static void main(String[] args) {
		String rs = "Webhook \u7684 payload POST \u65f6\u5fc5\u987b\u662f JSON \u5b57\u7b26\u4e32";
		System.out.println(EscapeUtil.unescapeHtml4(rs));
		System.out.println(HtmlUtil.escape("测试"));
	}
}
