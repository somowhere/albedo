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

import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.context.EnvironmentAware;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ResourceLoader;
import org.springframework.core.type.AnnotationMetadata;
import org.springframework.data.repository.config.*;
import org.springframework.util.Assert;

import java.lang.annotation.Annotation;

/**
 * Mybatis repositories register for spring data.
 *
 * @author Jarvis Song
 */
class MybatisRepositoriesRegistrar extends RepositoryBeanDefinitionRegistrarSupport implements ResourceLoaderAware, EnvironmentAware {

    private ResourceLoader resourceLoader;
    private Environment    environment;

    @Override
    protected Class<? extends Annotation> getAnnotation() {
        return EnableMybatisRepositories.class;
    }

    @Override
    protected RepositoryConfigurationExtension getExtension() {
        return new MybatisRepositoryConfigExtension(resourceLoader);
    }

    @Override
    public void setResourceLoader(ResourceLoader resourceLoader) {
        super.setResourceLoader(resourceLoader);
        this.resourceLoader = resourceLoader;
    }

    @Override
    public void setEnvironment(Environment environment) {
        this.environment = environment;
        super.setEnvironment(environment);
    }

    @Override
    public void registerBeanDefinitions(AnnotationMetadata annotationMetadata, BeanDefinitionRegistry registry) {
        Assert.notNull(resourceLoader, "ResourceLoader must not be null!");
        Assert.notNull(annotationMetadata, "AnnotationMetadata must not be null!");
        Assert.notNull(registry, "BeanDefinitionRegistry must not be null!");

        // Guard against calls for sub-classes
        if (annotationMetadata.getAnnotationAttributes(getAnnotation().getName()) == null) {
            return;
        }

        MybatisAnnotationRepositoryConfigurationSource configurationSource = new MybatisAnnotationRepositoryConfigurationSource(
                annotationMetadata, getAnnotation(), resourceLoader, environment);

        RepositoryConfigurationExtension extension = getExtension();
        RepositoryConfigurationUtils.exposeRegistration(extension, registry, configurationSource);

        RepositoryConfigurationDelegate delegate = new RepositoryConfigurationDelegate(configurationSource, resourceLoader,
                environment);

        delegate.registerRepositoriesIn(registry, extension);
    }
}
