package com.albedo.java.plugins.database.config;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.ReflectUtil;
import com.albedo.java.common.core.basic.domain.BaseDataEntity;
import com.albedo.java.common.core.basic.domain.BaseEntity;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.StrPool;
import com.baidu.fsg.uid.UidGenerator;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.baomidou.mybatisplus.core.metadata.TableInfo;
import com.baomidou.mybatisplus.core.metadata.TableInfoHelper;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;

import java.lang.reflect.Field;
import java.time.LocalDateTime;

/**
 * MyBatis Plus 元数据处理类
 * 用于自动 注入 id, createTime, updateTime, createdBy, updatedBy 等字段
 * <p>
 * 判断逻辑：
 * 1. insert 方法，自动填充 id, createTime, updateTime, createdBy, updatedBy 字段，字段为空则自动生成，不为空则使用传递进来的
 * 2. update 方法，自动填充 id, updateTime, updatedBy 字段，字段为空则自动生成，不为空则使用传递进来的
 * <p>
 * 注入值：
 * id：  IdUtil.getSnowflake(workerId, dataCenterId);
 * createTime：LocalDateTime.now()
 * updateTime：LocalDateTime.now()
 * createdBy：BaseContextHandler.getUserId()
 * updatedBy：BaseContextHandler.getUserId()
 *
 * @author somewhere
 * @date 2019/04/29
 */
@Slf4j
public class LampMetaObjectHandler implements MetaObjectHandler {


	private UidGenerator uidGenerator;

	public LampMetaObjectHandler() {
		super();
	}

	/**
	 * 注意：不支持 复合主键 自动注入！！
	 * <p>
	 * 1、所有的继承了Entity、BaseEntity的实体，在insert时，
	 * id： id为空时， 通过IdGenerate生成唯一ID。
	 * createdBy, updatedBy: 自动赋予 当前线程上的登录人id。
	 * createTime, updateTime: 自动赋予 服务器的当前时间。
	 * <p>
	 * 注意：实体中字段为空时才会赋值，若手动传值了，这里不会重新赋值
	 * <p>
	 * 2、未继承任何父类的实体，且主键标注了 @TableId(value = "xxx", type = IdType.INPUT) 也能自动赋值，主键的字段名称任意
	 * <p>
	 * 3、未继承任何父类的实体，但主键名为 id，也能自动赋值
	 */
	@Override
	public void insertFill(MetaObject metaObject) {
		fillCreated(metaObject);
		fillUpdated(metaObject);
		fillId(metaObject);
	}

	private void fillId(MetaObject metaObject) {
		if (uidGenerator == null) {
			// 这里使用SpringUtils的方式"异步"获取对象，防止启动时，报循环注入的错
			uidGenerator = SpringContextHolder.getBean(UidGenerator.class);
		}
		Long id = uidGenerator.getUid();

		//1. 继承了BaseEntity 若 ID 中有值，就不设置
		if (metaObject.getOriginalObject() instanceof BaseEntity) {
			Object oldId = ((BaseEntity) metaObject.getOriginalObject()).pkVal();
			if (oldId != null) {
				return;
			}
			Object idVal = StrPool.STRING_TYPE_NAME.equals(metaObject.getGetterType(BaseEntity.F_ID).getName()) ? String.valueOf(id) : id;
			this.setFieldValByName(BaseEntity.F_ID, idVal, metaObject);
			return;
		}

		// 2. 没有继承BaseEntity， 但主键的字段名为：  id
		if (metaObject.hasGetter(BaseEntity.F_ID)) {
			Object oldId = metaObject.getValue(BaseEntity.F_ID);
			if (oldId != null) {
				return;
			}

			Object idVal = StrPool.STRING_TYPE_NAME.equals(metaObject.getGetterType(BaseEntity.F_ID).getName()) ? String.valueOf(id) : id;
			this.setFieldValByName(BaseEntity.F_ID, idVal, metaObject);
			return;
		}

		// 3. 实体没有继承 Entity 和 BaseEntity，且 主键名为其他字段
		TableInfo tableInfo = TableInfoHelper.getTableInfo(metaObject.getOriginalObject().getClass());
		if (tableInfo == null) {
			return;
		}
		// 主键类型
		Class<?> keyType = tableInfo.getKeyType();
		if (keyType == null) {
			return;
		}
		// id 字段名
		String keyProperty = tableInfo.getKeyProperty();
		Object oldId = metaObject.getValue(keyProperty);
		if (oldId != null) {
			return;
		}

		// 反射得到 主键的值
		Field idField = ReflectUtil.getField(metaObject.getOriginalObject().getClass(), keyProperty);
		Object fieldValue = ReflectUtil.getFieldValue(metaObject.getOriginalObject(), idField);
		// 判断ID 是否有值，有值就不
		if (ObjectUtil.isNotEmpty(fieldValue)) {
			return;
		}
		Object idVal = keyType.getName().equalsIgnoreCase(StrPool.STRING_TYPE_NAME) ? String.valueOf(id) : id;
		this.setFieldValByName(keyProperty, idVal, metaObject);
	}

	private void fillCreated(MetaObject metaObject) {
		// 设置创建时间和创建人
		if (metaObject.getOriginalObject() instanceof BaseEntity) {
			created(metaObject);
			return;
		}

		if (metaObject.hasGetter(BaseDataEntity.F_CREATED_BY)) {
			Object oldVal = metaObject.getValue(BaseDataEntity.F_CREATED_BY);
			if (oldVal == null) {
				this.setFieldValByName(BaseDataEntity.F_CREATED_BY, ContextUtil.getUserId(), metaObject);
			}
		}
		if (metaObject.hasGetter(BaseDataEntity.F_CREATED_DATE)) {
			Object oldVal = metaObject.getValue(BaseDataEntity.F_CREATED_DATE);
			if (oldVal == null) {
				this.setFieldValByName(BaseDataEntity.F_CREATED_DATE, LocalDateTime.now(), metaObject);
			}
		}

	}

	private void created(MetaObject metaObject) {
		BaseDataEntity entity = (BaseDataEntity) metaObject.getOriginalObject();
		if (entity.getCreatedDate() == null) {
			this.setFieldValByName(BaseDataEntity.F_CREATED_DATE, LocalDateTime.now(), metaObject);
		}
		if (entity.getCreatedBy() == null || entity.getCreatedBy().equals(0)) {
			Object userIdVal = StrPool.STRING_TYPE_NAME.equals(metaObject.getGetterType(BaseDataEntity.F_CREATED_BY).getName()) ? String.valueOf(ContextUtil.getUserId()) : ContextUtil.getUserId();
			this.setFieldValByName(BaseDataEntity.F_CREATED_BY, userIdVal, metaObject);
		}
	}


	private void fillUpdated(MetaObject metaObject) {
		// 修改人 修改时间
		if (metaObject.getOriginalObject() instanceof BaseDataEntity) {
			update(metaObject);
			return;
		}

		if (metaObject.hasGetter(BaseDataEntity.F_LAST_MODIFIED_BY)) {
			Object oldVal = metaObject.getValue(BaseDataEntity.F_LAST_MODIFIED_BY);
			if (oldVal == null) {
				this.setFieldValByName(BaseDataEntity.F_LAST_MODIFIED_BY, ContextUtil.getUserId(), metaObject);
			}
		}
		if (metaObject.hasGetter(BaseDataEntity.F_LAST_MODIFIED_DATE)) {
			Object oldVal = metaObject.getValue(BaseDataEntity.F_LAST_MODIFIED_DATE);
			if (oldVal == null) {
				this.setFieldValByName(BaseDataEntity.F_LAST_MODIFIED_DATE, LocalDateTime.now(), metaObject);
			}
		}
	}

	private void update(MetaObject metaObject) {
		BaseDataEntity entity = (BaseDataEntity) metaObject.getOriginalObject();
		if (entity.getLastModifiedBy() == null || entity.getLastModifiedBy().equals(0)) {
			Object userIdVal = StrPool.STRING_TYPE_NAME.equals(metaObject.getGetterType(BaseDataEntity.F_LAST_MODIFIED_BY).getName()) ? String.valueOf(ContextUtil.getUserId()) : ContextUtil.getUserId();
			this.setFieldValByName(BaseDataEntity.F_LAST_MODIFIED_BY, userIdVal, metaObject);
		}
		if (entity.getLastModifiedDate() == null) {
			this.setFieldValByName(BaseDataEntity.F_LAST_MODIFIED_DATE, LocalDateTime.now(), metaObject);
		}
	}

	/**
	 * 所有的继承了Entity、BaseEntity的实体，在update时，
	 * updatedBy: 自动赋予 当前线程上的登录人id
	 * updateTime: 自动赋予 服务器的当前时间
	 */
	@Override
	public void updateFill(MetaObject metaObject) {
		log.debug("start update fill ....");
		fillUpdated(metaObject);
	}
}
