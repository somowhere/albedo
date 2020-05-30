package com.albedo.java.common.core.vo;

import com.albedo.java.common.core.util.StringUtil;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class PageModel<T> extends Page<T> {


	public static final String F_DESC = "desc";
	public static final String F_ASC = "asc";

	public PageModel(List<T> records, int total) {
		this.setRecords(records);
		this.setTotal(total);
	}

	public void setSorts(String sorts) {
		String[] split = sorts.split(StringUtil.SPLIT_DEFAULT);
		if (split.length == 2) {
			getOrders().add(F_DESC.equals(split[1]) ? OrderItem.desc(split[0]) : OrderItem.asc(split[0]));
		}
	}

	@Override
	public String toString() {
		return "PageModel(current=" + getCurrent() + ",size=" + getSize() + ",orders=" + getOrders() + ") ";
	}

}
