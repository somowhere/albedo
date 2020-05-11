package com.albedo.java.common.core.vo;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;

@Data
public class PageModel<T> extends Page<T> {


	public static final String F_DESC = "desc";
	public static final String F_ASC = "asc";

}
