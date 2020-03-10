package com.albedo.java.common.core.vo;

import cn.hutool.core.util.EscapeUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;

@Data
public class PageModel<T> extends Page<T> {


	public static final String F_DESC = "desc";
	public static final String F_ASC = "asc";
	/**
	 * 查询条件json
	 */
	private String queryConditionJson;

	public void setQueryConditionJson(String queryConditionJson) {
		this.queryConditionJson = EscapeUtil.unescapeHtml4(queryConditionJson);
	}

}
