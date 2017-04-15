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

package org.springframework.data.mybatis.repository.config;

import org.springframework.core.annotation.AnnotationAttributes;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ResourceLoader;
import org.springframework.core.type.AnnotationMetadata;
import org.springframework.data.repository.config.AnnotationRepositoryConfigurationSource;

import java.lang.annotation.Annotation;

/**
 * @author Jarvis Song
 */
public class MybatisAnnotationRepositoryConfigurationSource extends AnnotationRepositoryConfigurationSource {
    /**
     * Creates a new {@link AnnotationRepositoryConfigurationSource} from the given {@link AnnotationMetadata} and
     * annotation.
     *
     * @param metadata
     * @param annotation     must not be {@literal null}.
     * @param resourceLoader must not be {@literal null}.
     * @param environment
     */
    public MybatisAnnotationRepositoryConfigurationSource(AnnotationMetadata metadata, Class<? extends Annotation> annotation, ResourceLoader resourceLoader, Environment environment) {
        super(metadata, annotation, resourceLoader, environment);
    }

    public String[] getMapperLocations() {
        AnnotationAttributes attributes = getAttributes();
        return attributes.getStringArray("mapperLocations");
    }

}
