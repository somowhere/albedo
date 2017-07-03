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

import org.springframework.data.domain.AuditorAware;
import org.springframework.data.mapping.PersistentEntity;
import org.springframework.data.mybatis.annotations.Entity;
import org.springframework.data.mybatis.domains.AuditDateAware;
import org.springframework.data.mybatis.domains.Persistable;
import org.springframework.data.mybatis.mapping.MybatisMappingContext;
import org.springframework.data.repository.core.support.AbstractEntityInformation;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import java.io.Serializable;

/**
 * mybatis entity information support.
 *
 * @author Jarvis Song
 */
public abstract class MybatisEntityInformationSupport<T, ID extends Serializable> extends AbstractEntityInformation<T, ID>
        implements MybatisEntityInformation<T, ID> {


    protected final PersistentEntity<T, ?> persistentEntity;
    protected final AuditorAware<?> auditorAware;
    protected final AuditDateAware<?> auditDateAware;

    /**
     * Creates a new {@link AbstractEntityInformation} from the given domain class.
     *
     * @param auditDateAware
     * @param domainClass    must not be {@literal null}.
     */
    protected MybatisEntityInformationSupport(
            PersistentEntity<T, ?> persistentEntity,
            AuditorAware<?> auditorAware,
            AuditDateAware<?> auditDateAware, Class<T> domainClass) {
        super(domainClass);
        this.persistentEntity = persistentEntity;
        this.auditorAware = auditorAware;
        this.auditDateAware = auditDateAware;
    }

    public static <T, ID extends Serializable> MybatisEntityInformation<T, ID> getEntityInformation(MybatisMappingContext mappingContext,
                                                                                                    AuditorAware<?> auditorAware,
                                                                                                    AuditDateAware<?> auditDateAware,
                                                                                                    Class<T> domainClass) {
        Assert.notNull(domainClass);
        PersistentEntity<T, ?> persistentEntity = (PersistentEntity<T, ?>) mappingContext.getPersistentEntity(domainClass);
        if (Persistable.class.isAssignableFrom(domainClass)) {
            return new MybatisPersistableEntityInformation(persistentEntity, auditorAware, auditDateAware, domainClass);
        }

        return new MybatisMetamodelEntityInformation<T, ID>(persistentEntity, auditorAware, auditDateAware, domainClass);
    }

    @Override
    public String getEntityName() {
        Class<T> domainClass = getJavaType();
        Entity entity = domainClass.getAnnotation(Entity.class);
        if (null != entity && StringUtils.hasText(entity.name())) {
            return entity.name();
        }

        return domainClass.getSimpleName();
    }

}
