package com.albedo.java.plugins.database.injector;

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.basic.domain.BaseEntity;
import com.albedo.java.plugins.database.injector.method.UpdateAllById;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.core.injector.AbstractMethod;
import com.baomidou.mybatisplus.core.injector.DefaultSqlInjector;
import com.baomidou.mybatisplus.core.metadata.TableInfo;
import com.baomidou.mybatisplus.extension.injector.methods.InsertBatchSomeColumn;

import java.util.List;

/**
 * 自定义sql 注入器
 *
 * @author zuihou
 * @date 2020年02月19日15:39:49
 */
public class LampSqlInjector extends DefaultSqlInjector {
    @Override
    public List<AbstractMethod> getMethodList(Class<?> mapperClass, TableInfo tableInfo) {
        List<AbstractMethod> methodList = super.getMethodList(mapperClass, tableInfo);

        //增加自定义方法
        methodList.add(new InsertBatchSomeColumn(i -> i.getFieldFill() != FieldFill.UPDATE));
        methodList.add(new UpdateAllById(field -> !ArrayUtil.containsAny(new String[]{
                BaseEntity.F_SQL_CREATED_DATE, BaseEntity.F_SQL_CREATED_BY
        }, field.getColumn())));
        return methodList;
    }
}
