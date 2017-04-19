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

import org.springframework.data.mybatis.repository.query.MybatisEntityMetadata;
import org.springframework.data.repository.core.EntityInformation;

import java.io.Serializable;

/**
 * mybatis entity information.
 *
 * @author Jarvis Song
 */
public interface MybatisEntityInformation<T, ID extends Serializable>
        extends EntityInformation<T, ID>, MybatisEntityMetadata<T> {


    int increaseVersion(T entity);

    void setVersion(T entity, int version);

    boolean hasVersion();

    void preInssert(T entity);

    void preUpdate(T entity);


    void setCreatedDate(T entity);

    void setLastModifiedDate(T entity);

    void setCreatedBy(T entity);

    void setLastModifiedBy(T entity);

}
