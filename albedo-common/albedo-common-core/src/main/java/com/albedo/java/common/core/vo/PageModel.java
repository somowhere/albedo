package com.albedo.java.common.core.vo;

import cn.hutool.core.net.URLEncoder;
import com.albedo.java.common.core.util.EscapeUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

@Data
public class PageModel<T> extends Page<T> {


	public static final String F_DESC = "desc";
	public static final String F_ASC = "asc";
	/**
	 * 查询条件json
	 */
	private String queryConditionJson;

	public void setQueryConditionJson(String queryConditionJson) {
		try {
			this.queryConditionJson = URLDecoder.decode(queryConditionJson, "utf-8");
		} catch (UnsupportedEncodingException e) {
			this.queryConditionJson = queryConditionJson;
		}
	}

}
