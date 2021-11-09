package com.albedo.java.plugins.database.mybatis.conditions.update;

import com.albedo.java.common.core.util.StringUtil;
import com.baomidou.mybatisplus.core.conditions.AbstractLambdaWrapper;
import com.baomidou.mybatisplus.core.conditions.SharedString;
import com.baomidou.mybatisplus.core.conditions.segments.MergeSegments;
import com.baomidou.mybatisplus.core.conditions.update.Update;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.function.Consumer;

import static com.baomidou.mybatisplus.core.enums.WrapperKeyword.APPLY;

/**
 * 修改构造器
 * <p>
 * 1, 对nested、eq、ne、gt、ge、lt、le、in、*like*、 等方法 进行条件判断，null 或 "" 字段不加入查询
 * 2，对*like*相关方法的参数 %和_ 符号进行转义，便于模糊查询
 *
 * @author somewhere
 * @date Created on 2019/5/27 17:15
 */
public class LbuWrapper<T> extends AbstractLambdaWrapper<T, LbuWrapper<T>>
	implements Update<LbuWrapper<T>, SFunction<T, ?>> {

	private static final long serialVersionUID = -4194344880194881367L;
	/**
	 * SQL 更新字段内容，例如：name='1', age=2
	 */
	private final List<String> sqlSet;

	/**
	 * 不建议直接 new 该实例，使用 Wrappers.lambdaUpdate()
	 */
	public LbuWrapper() {
		// 如果无参构造函数，请注意实体 NULL 情况 SET 必须有否则 SQL 异常
		this((T) null);
	}

	/**
	 * 不建议直接 new 该实例，使用 Wrappers.lambdaUpdate(entity)
	 */
	public LbuWrapper(T entity) {
		super.setEntity(entity);
		super.initNeed();
		this.sqlSet = new ArrayList<>();
	}

	/**
	 * 不建议直接 new 该实例，使用 Wrappers.lambdaUpdate(entity)
	 */
	public LbuWrapper(Class<T> entityClass) {
		super.setEntityClass(entityClass);
		super.initNeed();
		this.sqlSet = new ArrayList<>();
	}

	/**
	 * 不建议直接 new 该实例，使用 Wrappers.lambdaUpdate(...)
	 */
	private LbuWrapper(T entity, Class<T> entityClass, List<String> sqlSet, AtomicInteger paramNameSeq,
					   Map<String, Object> paramNameValuePairs, MergeSegments mergeSegments, SharedString paramAlias,
					   SharedString lastSql, SharedString sqlComment, SharedString sqlFirst) {
		super.setEntity(entity);
		super.setEntityClass(entityClass);
		this.sqlSet = sqlSet;
		this.paramNameSeq = paramNameSeq;
		this.paramNameValuePairs = paramNameValuePairs;
		this.expression = mergeSegments;
		this.paramAlias = paramAlias;
		this.lastSql = lastSql;
		this.sqlComment = sqlComment;
		this.sqlFirst = sqlFirst;
	}

	/**
	 * 空值校验
	 * 传入空字符串("")时， 视为： 字段名 = ""
	 *
	 * @param val 参数值
	 * @author somewhere
	 */
	private static boolean checkCondition(Object val) {
		return val != null;
	}

	@Override
	public LbuWrapper<T> set(boolean condition, SFunction<T, ?> column, Object val, String mapping) {
		return maybeDo(condition, () -> {
			String sql = formatParam(mapping, val);
			sqlSet.add(columnToString(column) + Constants.EQUALS + sql);
		});
	}

	@Override
	public LbuWrapper<T> setSql(boolean condition, String sql) {
		if (condition && StringUtils.isNotBlank(sql)) {
			sqlSet.add(sql);
		}
		return typedThis;
	}

	@Override
	public String getSqlSet() {
		if (CollectionUtils.isEmpty(sqlSet)) {
			return null;
		}
		return String.join(StringPool.COMMA, sqlSet);
	}

	@Override
	protected LbuWrapper<T> instance() {
		return new LbuWrapper<>(getEntity(), getEntityClass(), null, paramNameSeq, paramNameValuePairs,
			new MergeSegments(), paramAlias, SharedString.emptyString(), SharedString.emptyString(), SharedString.emptyString());
	}

	@Override
	public void clear() {
		super.clear();
		sqlSet.clear();
	}

	@Override
	public LbuWrapper<T> nested(Consumer<LbuWrapper<T>> consumer) {
		final LbuWrapper<T> instance = instance();
		consumer.accept(instance);
		if (!instance.isEmptyOfWhere()) {
			appendSqlSegments(APPLY, instance);
		}
		return this;
	}


	@Override
	public LbuWrapper<T> eq(SFunction<T, ?> column, Object val) {
		return super.eq(checkCondition(val), column, val);
	}

	@Override
	public LbuWrapper<T> ne(SFunction<T, ?> column, Object val) {
		return super.ne(checkCondition(val), column, val);
	}

	@Override
	public LbuWrapper<T> gt(SFunction<T, ?> column, Object val) {
		return super.gt(checkCondition(val), column, val);
	}

	@Override
	public LbuWrapper<T> ge(SFunction<T, ?> column, Object val) {
		return super.ge(checkCondition(val), column, val);
	}

	@Override
	public LbuWrapper<T> lt(SFunction<T, ?> column, Object val) {
		return super.lt(checkCondition(val), column, val);
	}

	@Override
	public LbuWrapper<T> le(SFunction<T, ?> column, Object val) {
		return super.le(checkCondition(val), column, val);
	}

	@Override
	public LbuWrapper<T> like(SFunction<T, ?> column, Object val) {
		return super.like(checkCondition(val), column, StringUtil.keywordConvert(val));
	}

	@Override
	public LbuWrapper<T> notLike(SFunction<T, ?> column, Object val) {
		return super.notLike(checkCondition(val), column, StringUtil.keywordConvert(val));
	}

	@Override
	public LbuWrapper<T> likeLeft(SFunction<T, ?> column, Object val) {
		return super.likeLeft(checkCondition(val), column, StringUtil.keywordConvert(val));
	}

	@Override
	public LbuWrapper<T> likeRight(SFunction<T, ?> column, Object val) {
		return super.likeRight(checkCondition(val), column, StringUtil.keywordConvert(val));
	}

	@Override
	public LbuWrapper<T> in(SFunction<T, ?> column, Collection<?> coll) {
		return super.in(coll != null && !coll.isEmpty(), column, coll);
	}

	@Override
	public LbuWrapper<T> in(SFunction<T, ?> column, Object... values) {
		return super.in(values != null && values.length > 0, column, values);
	}
}
