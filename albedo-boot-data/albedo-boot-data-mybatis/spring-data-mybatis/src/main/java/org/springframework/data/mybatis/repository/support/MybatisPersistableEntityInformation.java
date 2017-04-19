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
import org.springframework.data.mybatis.domains.AuditDateAware;
import org.springframework.data.mybatis.domains.Persistable;
import org.springframework.data.repository.core.support.AbstractEntityInformation;

import java.io.Serializable;

/**
 * mybatis persistable entity information.
 *
 * @author Jarvis Song
 */
public class MybatisPersistableEntityInformation<T extends Persistable<ID>, ID extends Serializable> extends MybatisMetamodelEntityInformation<T, ID> {

    /**
     * Creates a new {@link AbstractEntityInformation} from the given domain class.
     *
     * @param persistentEntity
     * @param domainClass      must not be {@literal null}.
     */
    protected MybatisPersistableEntityInformation(PersistentEntity<T, ?> persistentEntity, AuditorAware<?> auditorAware, AuditDateAware<?> auditDateAware, Class<T> domainClass) {
        super(persistentEntity, auditorAware, auditDateAware, domainClass);
    }

    @Override
    public boolean isNew(T entity) {
        return entity.isNew();
    }

    @Override
    public ID getId(T entity) {
        return entity.getId();
    }

    @Override
    public void preInssert(T entity) {
        entity.preInssert();
    }

    @Override
    public void preUpdate(T entity) {
        entity.preUpdate();
    }
}
