package com.albedo.java.common.persistence.handler;

import com.albedo.java.common.persistence.domain.AbstractDataEntity;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.data.domain.AuditorAware;
import org.springframework.util.Assert;

import java.time.LocalDateTime;
import java.util.Iterator;
import java.util.Map;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:07
 */
public class EntityMetaObjectHandler implements MetaObjectHandler {

	private final AuditorAware auditorAware;

	public EntityMetaObjectHandler(AuditorAware auditorAware) {
		Assert.isTrue(auditorAware != null, "auditorAware is not defined");
		this.auditorAware = auditorAware;
	}


	@Override
	public void insertFill(MetaObject metaObject) {
		if (checkMetaObject(metaObject)) {
			setFieldValByName(AbstractDataEntity.F_CREATEDBY, auditorAware.getCurrentAuditor().get(), metaObject);
			LocalDateTime date = LocalDateTime.now();
			setFieldValByName(AbstractDataEntity.F_CREATEDDATE, date, metaObject);
			setFieldValByName(AbstractDataEntity.F_LASTMODIFIEDBY, auditorAware.getCurrentAuditor().get(), metaObject);
			setFieldValByName(AbstractDataEntity.F_LASTMODIFIEDDATE, date, metaObject);
		}

	}

	private boolean checkMetaObject(MetaObject metaObject) {
		boolean isDataEntity = false;
		if (metaObject.getOriginalObject() instanceof Map) {
			Map<String, Object> map = (Map<String, Object>) metaObject.getOriginalObject();
			Iterator<String> iterator = map.keySet().iterator();
			while (iterator.hasNext()) {
				String next = iterator.next();
				if (map.get(next) instanceof AbstractDataEntity) {
					isDataEntity = true;
					break;
				}
			}
		}
		return isDataEntity || metaObject.getOriginalObject() instanceof AbstractDataEntity;
	}

	@Override
	public void updateFill(MetaObject metaObject) {
		if (checkMetaObject(metaObject)) {
			LocalDateTime date = LocalDateTime.now();
			setFieldValByName(AbstractDataEntity.F_LASTMODIFIEDBY, auditorAware.getCurrentAuditor().get(), metaObject);
			setFieldValByName(AbstractDataEntity.F_LASTMODIFIEDDATE, date, metaObject);
		}
	}
}
