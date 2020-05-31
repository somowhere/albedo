package com.albedo.java.common.persistence;

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.Iterator;

/**
 * @author somewhere
 * @date 2018/03/08
 */
public class PageQuery<T> extends Page<T> {
	private static final String PAGE = "page";
	private static final String LIMIT = "limit";
	private static final String ORDER_BY_FIELD = "orderByField";
	private static final String IS_ASC = "isAsc";

	public PageQuery(long current, long size) {
		super(current, size);
	}

	public PageQuery(Pageable pageable) {
		super(pageable.getPageNumber()
			, pageable.getPageSize());
		if (pageable.getSort() != null) {
			Iterator<Sort.Order> iterator = pageable.getSort().iterator();
			while (iterator.hasNext()) {
				Sort.Order order = iterator.next();
				if (order.getDirection().isAscending()) {
					if (ObjectUtil.isEmpty(this.getOrders())) {
						this.setAscs(Lists.newArrayList(order.getProperty()));
					} else {
						ArrayUtil.append(this.ascs(), order.getProperty());
					}

				} else if (order.getDirection().isDescending()) {
					if (ObjectUtil.isEmpty(this.getOrders())) {
						this.setDescs(Lists.newArrayList(order.getProperty()));
					} else {
						ArrayUtil.append(this.descs(), order.getProperty());
					}

				}
			}
		}

	}
}
