/*
 *
 *   Copyright 2016 the original author or authors.
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 */

package org.springframework.data.mybatis.repository.support;

import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.mapping.PersistentEntity;
import org.springframework.data.mapping.PersistentProperty;
import org.springframework.data.mapping.PersistentPropertyAccessor;
import org.springframework.data.mybatis.annotations.PreInssert;
import org.springframework.data.mybatis.annotations.PreUpdate;
import org.springframework.data.mybatis.domains.AuditDateAware;
import org.springframework.data.repository.core.support.AbstractEntityInformation;

import java.io.Serializable;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * mybatis meta.
 *
 * @author Jarvis Song
 */
public class MybatisMetamodelEntityInformation<T, ID extends Serializable> extends MybatisEntityInformationSupport<T, ID> {

    private PersistentProperty<?> createdDateProperty;
    private PersistentProperty<?> lastModifiedDateProperty;
    private PersistentProperty<?> createdByProperty;
    private PersistentProperty<?> lastModifiedByProperty;


    /**
     * Creates a new {@link AbstractEntityInformation} from the given domain class.
     *
     * @param persistentEntity
     * @param domainClass      must not be {@literal null}.
     */
    protected MybatisMetamodelEntityInformation(PersistentEntity<T, ?> persistentEntity, AuditorAware<?> auditorAware, AuditDateAware<?> auditDateAware, Class<T> domainClass) {
        super(persistentEntity, auditorAware, auditDateAware, domainClass);

        createdDateProperty = persistentEntity.getPersistentProperty(CreatedDate.class);
        lastModifiedDateProperty = persistentEntity.getPersistentProperty(LastModifiedDate.class);
        createdByProperty = persistentEntity.getPersistentProperty(CreatedBy.class);
        lastModifiedByProperty = persistentEntity.getPersistentProperty(LastModifiedBy.class);
    }

    @Override
    public ID getId(T entity) {
        if (null == persistentEntity) {
            return null;
        }

        return (ID) persistentEntity.getIdentifierAccessor(entity).getIdentifier();

    }

    @Override
    public Class<ID> getIdType() {
        if (null == persistentEntity) {
            return null;
        }

        PersistentProperty idProperty = persistentEntity.getIdProperty();
        if (null == idProperty) {
            return null;
        }
        return (Class<ID>) idProperty.getType();
    }

    @Override
    public boolean hasVersion() {
        return persistentEntity.hasVersionProperty();
    }

    public int appearNumber(String srcText, String findText, int position) {
        int count = 0;
        Pattern p = Pattern.compile(findText);
        Matcher m = p.matcher(srcText);
        while (m.find()) {
            count++;
            if (position == count) break;
        }
        return m.start();
    }

    private Method getAnnotaionMethod(T entity, Class annotationClass) {
        String className = entity.getClass().getName(), baseName = className.substring(0, appearNumber(className, ".", 3));
        Method method = null;
        Class<?> temp = entity.getClass();
        while (method == null && temp.toString().contains(baseName)) {
            Method[] methods = temp.getDeclaredMethods();
            for (Method item : methods) {
                if (item.getAnnotation(annotationClass) != null) return item;
            }
            temp = temp.getSuperclass();
        }
        return null;
    }


    @Override
    public void preInssert(T entity) {

        Method method = getAnnotaionMethod(entity, PreInssert.class);
        try {
            if (method != null)
                method.invoke(entity);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void preUpdate(T entity) {
        Method method = getAnnotaionMethod(entity, PreUpdate.class);
        try {
            if (method != null)
                method.invoke(entity);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void setAuditDate(PersistentProperty<?> property, T entity, Class<? extends Annotation> annotationType, boolean isCheckVal) {

        Object val = persistentEntity.getPropertyAccessor(entity).getProperty(property);
        if (isCheckVal && null != val) {
            return;
        }


        if (null != auditDateAware) {
            persistentEntity.getPropertyAccessor(entity).setProperty(property, auditDateAware.getCurrentDate());
            return;
        }

        Class<?> type = property.getRawType();
        if (Date.class.isAssignableFrom(type)) {
            persistentEntity.getPropertyAccessor(entity).setProperty(property, new Date());
        } else if (Long.class == type || long.class == type) {
            persistentEntity.getPropertyAccessor(entity).setProperty(property, System.currentTimeMillis());
        } else {
            throw new IllegalArgumentException("now we can not support " + type.getName() + " for " + annotationType.getName()
                    + ", you can implement org.springframework.data.mybatis.domains.AuditDateAware interface as a spring bean.");
        }
    }

    @Override
    public void setCreatedDate(T entity) {
        if (null == createdDateProperty) {
            return;
        }
        setAuditDate(createdDateProperty, entity, CreatedDate.class, true);
    }

    @Override
    public void setLastModifiedDate(T entity) {
        if (null == lastModifiedDateProperty) {
            return;
        }
        setAuditDate(lastModifiedDateProperty, entity, LastModifiedDate.class, false);

    }

    private void setCurrentAuditor(PersistentProperty<?> property, T entity, boolean isCheckVal) {
        Object val = persistentEntity.getPropertyAccessor(entity).getProperty(property);
        if (isCheckVal && null != val) {
            return;
        }
        persistentEntity.getPropertyAccessor(entity).setProperty(property, auditorAware.getCurrentAuditor());
    }

    @Override
    public void setCreatedBy(T entity) {
        if (null == createdByProperty || null == auditorAware) {
            return;
        }
        setCurrentAuditor(createdByProperty, entity, false);
    }

    @Override
    public void setLastModifiedBy(T entity) {
        if (null == lastModifiedByProperty || null == auditorAware) {
            return;
        }
        setCurrentAuditor(lastModifiedByProperty, entity, false);
    }

    @Override
    public int increaseVersion(T entity) {
        PersistentProperty<?> versionProperty = persistentEntity.getVersionProperty();
        if (null == versionProperty) {
            return 0;
        }

        PersistentPropertyAccessor accessor = persistentEntity.getPropertyAccessor(entity);
        int newVer = (Integer) accessor.getProperty(versionProperty) + 1;
        accessor.setProperty(versionProperty, newVer);

        return newVer;
    }

    @Override
    public void setVersion(T entity, int version) {
        PersistentProperty<?> versionProperty = persistentEntity.getVersionProperty();
        if (null == versionProperty) {
            return;
        }
        persistentEntity.getPropertyAccessor(entity).setProperty(versionProperty, version);

    }
}
