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

package org.springframework.data.mybatis.repository.query;

import org.springframework.core.annotation.AnnotatedElementUtils;
import org.springframework.data.mybatis.annotations.Entity;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;


/**
 * default implementation of mybatis entity metadata.
 *
 * @author Jarvis Song
 */
public class DefaultMybatisEntityMetadata<T> implements MybatisEntityMetadata<T> {

    private final Class<T> domainType;

    public DefaultMybatisEntityMetadata(Class<T> domainType) {
        Assert.notNull(domainType, "Domain type must not be null!");
        this.domainType = domainType;
    }

    @Override
    public String getEntityName() {
        Entity entity = AnnotatedElementUtils.findMergedAnnotation(domainType, Entity.class);
        boolean hasName = null != entity && StringUtils.hasText(entity.name());

        return hasName ? entity.name() : domainType.getSimpleName();
    }

    @Override
    public Class<T> getJavaType() {
        return domainType;
    }
}
