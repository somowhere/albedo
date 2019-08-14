package com.albedo.java.common.persistence.injector;

import com.albedo.java.common.persistence.injector.methods.LogicFindRelationList;
import com.albedo.java.common.persistence.injector.methods.LogicFindRelationPage;
import com.baomidou.mybatisplus.core.injector.AbstractMethod;
import com.baomidou.mybatisplus.core.injector.DefaultSqlInjector;
import com.google.common.collect.Lists;

import java.util.List;

/**
 * 1.逻辑删除字段sql注入
 * 2.多对一关联对象查询sql注入
 *
 * @return
 */
public class EntityMetaSqlInjector extends DefaultSqlInjector {

	public final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(getClass());

	@Override
	public List<AbstractMethod> getMethodList(Class<?> mapperClass) {
		List<AbstractMethod> methodList = super.getMethodList(mapperClass);
		methodList.addAll(Lists.newArrayList(new LogicFindRelationList(), new LogicFindRelationPage()));
		return methodList;
	}

}
