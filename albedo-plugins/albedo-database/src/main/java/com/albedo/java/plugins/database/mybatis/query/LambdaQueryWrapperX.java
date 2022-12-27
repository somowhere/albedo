package com.albedo.java.plugins.database.mybatis.query;

import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import org.springframework.util.StringUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Collection;

/**
 * 拓展 MyBatis Plus QueryWrapper 类，主要增加如下功能：
 * <p>
 * 1. 拼接条件的方法，增加 xxxIfPresent 方法，用于判断值不存在的时候，不要拼接到条件中。
 *
 * @param <T> 数据类型
 */
public class LambdaQueryWrapperX<T> extends LambdaQueryWrapper<T> {

	private boolean skipEmpty = true;

	public LambdaQueryWrapperX<T> likeIfPresent(SFunction<T, ?> column, String val) {
		if (StringUtils.hasText(val)) {
			return (LambdaQueryWrapperX<T>) super.like(column, val);
		}
		return this;
	}

	public LambdaQueryWrapperX<T> inIfPresent(SFunction<T, ?> column, Collection<?> values) {
		if (!CollectionUtils.isEmpty(values)) {
			return (LambdaQueryWrapperX<T>) super.in(column, values);
		}
		return this;
	}

	public LambdaQueryWrapperX<T> inIfPresent(SFunction<T, ?> column, Object... values) {
		if (!ArrayUtil.isEmpty(values)) {
			return (LambdaQueryWrapperX<T>) super.in(column, values);
		}
		return this;
	}

	public LambdaQueryWrapperX<T> eqIfPresent(SFunction<T, ?> column, Object val) {
		if (val != null) {
			return (LambdaQueryWrapperX<T>) super.eq(column, val);
		}
		return this;
	}

	public LambdaQueryWrapperX<T> neIfPresent(SFunction<T, ?> column, Object val) {
		if (val != null) {
			return (LambdaQueryWrapperX<T>) super.ne(column, val);
		}
		return this;
	}

	public LambdaQueryWrapperX<T> gtIfPresent(SFunction<T, ?> column, Object val) {
		if (val != null) {
			return (LambdaQueryWrapperX<T>) super.gt(column, val);
		}
		return this;
	}

	public LambdaQueryWrapperX<T> geIfPresent(SFunction<T, ?> column, Object val) {
		if (val != null) {
			return (LambdaQueryWrapperX<T>) super.ge(column, val);
		}
		return this;
	}

	public LambdaQueryWrapperX<T> ltIfPresent(SFunction<T, ?> column, Object val) {
		if (val != null) {
			return (LambdaQueryWrapperX<T>) super.lt(column, val);
		}
		return this;
	}

	public LambdaQueryWrapperX<T> leIfPresent(SFunction<T, ?> column, Object val) {
		if (val != null) {
			return (LambdaQueryWrapperX<T>) super.le(column, val);
		}
		return this;
	}

	public LambdaQueryWrapperX<T> betweenIfPresent(SFunction<T, ?> column, Object val1, Object val2) {
		if (val1 != null && val2 != null) {
			return (LambdaQueryWrapperX<T>) super.between(column, val1, val2);
		}
		if (val1 != null) {
			return (LambdaQueryWrapperX<T>) ge(column, val1);
		}
		if (val2 != null) {
			return (LambdaQueryWrapperX<T>) le(column, val2);
		}
		return this;
	}

	public LambdaQueryWrapperX<T> betweenIfPresent(SFunction<T, ?> column, Object[] values) {
		Object val1 = ArrayUtil.get(values, 0);
		Object val2 = ArrayUtil.get(values, 1);
		return betweenIfPresent(column, val1, val2);
	}

	public LambdaQueryWrapperX<T> geHeader(SFunction<T, ?> column, LocalDateTime val) {
		if (val != null) {
			val = LocalDateTime.of(val.toLocalDate(), LocalTime.MIN);
		}
		return (LambdaQueryWrapperX<T>) super.ge(this.checkCondition(val), column, val);
	}

	public LambdaQueryWrapperX<T> geHeader(SFunction<T, ?> column, LocalDate val) {
		LocalDateTime dateTime = val != null ? LocalDateTime.of(val, LocalTime.MIN) : null;
		return (LambdaQueryWrapperX<T>) super.ge(this.checkCondition(dateTime), column, dateTime);
	}

	@Override
	public LambdaQueryWrapperX<T> lt(SFunction<T, ?> column, Object val) {
		return (LambdaQueryWrapperX<T>) super.lt(this.checkCondition(val), column, val);
	}

	@Override
	public LambdaQueryWrapperX<T> le(SFunction<T, ?> column, Object val) {
		return (LambdaQueryWrapperX<T>) super.le(this.checkCondition(val), column, val);
	}

	public LambdaQueryWrapperX<T> leFooter(SFunction<T, ?> column, LocalDateTime val) {
		if (val != null) {
			val = LocalDateTime.of(val.toLocalDate(), LocalTime.MAX);
		}
		return (LambdaQueryWrapperX<T>) super.le(this.checkCondition(val), column, val);
	}

	public LambdaQueryWrapperX<T> leFooter(SFunction<T, ?> column, LocalDate val) {
		LocalDateTime dateTime = null;
		if (val != null) {
			dateTime = LocalDateTime.of(val, LocalTime.MAX);
		}
		return (LambdaQueryWrapperX<T>) super.le(this.checkCondition(val), column, dateTime);
	}


	private boolean checkCondition(Object val) {
		if (val instanceof String && this.skipEmpty) {
			return StrUtil.isNotBlank((String) val);
		}
		if (val instanceof Collection && this.skipEmpty) {
			return !((Collection) val).isEmpty();
		}
		return val != null;
	}

	// ========== 重写父类方法，方便链式调用 ==========

	@Override
	public LambdaQueryWrapperX<T> eq(boolean condition, SFunction<T, ?> column, Object val) {
		super.eq(condition, column, val);
		return this;
	}

	@Override
	public LambdaQueryWrapperX<T> eq(SFunction<T, ?> column, Object val) {
		super.eq(column, val);
		return this;
	}

	@Override
	public LambdaQueryWrapperX<T> orderByDesc(SFunction<T, ?> column) {
		super.orderByDesc(true, column);
		return this;
	}

	@Override
	public LambdaQueryWrapperX<T> last(String lastSql) {
		super.last(lastSql);
		return this;
	}

	@Override
	public LambdaQueryWrapperX<T> in(SFunction<T, ?> column, Collection<?> coll) {
		super.in(column, coll);
		return this;
	}

}
