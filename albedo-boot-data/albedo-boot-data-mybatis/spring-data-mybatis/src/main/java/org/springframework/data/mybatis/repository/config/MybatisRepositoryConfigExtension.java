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

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.core.annotation.AnnotationAttributes;
import org.springframework.core.io.ResourceLoader;
import org.springframework.data.annotation.Persistent;
import org.springframework.data.mybatis.annotations.Entity;
import org.springframework.data.mybatis.mapping.MybatisMappingContext;
import org.springframework.data.mybatis.repository.dialect.DialectFactoryBean;
import org.springframework.data.mybatis.repository.support.MybatisRepository;
import org.springframework.data.mybatis.repository.support.MybatisRepositoryFactoryBean;
import org.springframework.data.repository.config.AnnotationRepositoryConfigurationSource;
import org.springframework.data.repository.config.RepositoryConfigurationExtensionSupport;
import org.springframework.data.repository.config.RepositoryConfigurationSource;
import org.springframework.data.repository.config.XmlRepositoryConfigurationSource;
import org.springframework.data.repository.core.RepositoryMetadata;
import org.springframework.data.repository.core.support.AbstractRepositoryMetadata;
import org.springframework.data.repository.util.TxUtils;
import org.springframework.util.StringUtils;

import java.lang.annotation.Annotation;
import java.util.*;

/**
 * Mybatis repository configuration extension for spring data.
 *
 * @author Jarvis Song
 */
public class MybatisRepositoryConfigExtension extends RepositoryConfigurationExtensionSupport {
    private static final String DEFAULT_TRANSACTION_MANAGER_BEAN_NAME = TxUtils.DEFAULT_TRANSACTION_MANAGER;
    private static final String DEFAULT_SQL_SESSION_FACTORY_BEAN_NAME = "sqlSessionFactory";
    private static final String DEFAULT_AUDITOR_AWARE_BEAN_NAME       = "auditorAware";
    private static final String ENABLE_DEFAULT_TRANSACTIONS_ATTRIBUTE = "enableDefaultTransactions";
    private static final String SQL_SESSION_TEMPLATE_BEAN_NAME_SUFFIX = "_Template";
    private static final String DIALECT_BEAN_NAME_SUFFIX              = "_Dialect";
    public static final  String MAPPING_CONTEXT_SUFFIX                = "_MappingContext";

    private final ResourceLoader resourceLoader;

    public MybatisRepositoryConfigExtension(ResourceLoader resourceLoader) {

        this.resourceLoader = resourceLoader;
    }

    @Override
    public String getModuleName() {
        return "MyBatis";
    }

    @Override
    protected String getModulePrefix() {
        return getModuleName().toLowerCase(Locale.US);
    }

    @Override
    public String getRepositoryFactoryClassName() {
        return MybatisRepositoryFactoryBean.class.getName();
    }

    @Override
    protected Collection<Class<? extends Annotation>> getIdentifyingAnnotations() {
        return Arrays.asList(Entity.class, Persistent.class);

    }

    @Override
    protected Collection<Class<?>> getIdentifyingTypes() {
        return Collections.<Class<?>>singleton(MybatisRepository.class);
    }


    private Class<?> loadRepositoryInterface(String repositoryInterface, ResourceLoader loader) {

        ClassLoader classLoader = loader.getClassLoader();

        try {
            return org.springframework.util.ClassUtils.forName(repositoryInterface, classLoader);
        } catch (ClassNotFoundException e) {
        } catch (LinkageError e) {
        }

        return null;
    }

    @Override
    public void registerBeansForRoot(BeanDefinitionRegistry registry, RepositoryConfigurationSource config) {
        super.registerBeansForRoot(registry, config);


        Set<Class<?>> initialEntitySet = new HashSet<Class<?>>();
        Collection<BeanDefinition> candidates = config.getCandidates(resourceLoader);
        for (BeanDefinition candidate : candidates) {
            Class<?> repositoryInterface = loadRepositoryInterface(candidate.getBeanClassName(), resourceLoader);
            if (null == repositoryInterface) {
                continue;
            }

            RepositoryMetadata metadata = AbstractRepositoryMetadata.getMetadata(repositoryInterface);
            if (null == metadata) {
                continue;
            }

            initialEntitySet.add(metadata.getDomainType());
        }


        Object source = config.getSource();
        String sqlSessionFactoryRef = config.getAttribute("sqlSessionFactoryRef");
        sqlSessionFactoryRef = (null == sqlSessionFactoryRef ? DEFAULT_SQL_SESSION_FACTORY_BEAN_NAME : sqlSessionFactoryRef);


        BeanDefinitionBuilder mappingContextBuilder = BeanDefinitionBuilder.rootBeanDefinition(MybatisMappingContext.class);
        mappingContextBuilder.addPropertyValue("initialEntitySet", initialEntitySet);
        registerIfNotAlreadyRegistered(mappingContextBuilder.getBeanDefinition(), registry, sqlSessionFactoryRef.concat(MAPPING_CONTEXT_SUFFIX), source);


        // create database dialect
        BeanDefinitionBuilder dialectBuilder = BeanDefinitionBuilder.rootBeanDefinition(DialectFactoryBean.class);
        dialectBuilder.addPropertyReference("sqlSessionFactory", sqlSessionFactoryRef);
        registerIfNotAlreadyRegistered(dialectBuilder.getBeanDefinition(), registry, sqlSessionFactoryRef.concat(DIALECT_BEAN_NAME_SUFFIX), source);


        // create sqlSessionTemplate bean.
        BeanDefinitionBuilder builder = BeanDefinitionBuilder.rootBeanDefinition(SqlSessionTemplate.class);
        builder.addConstructorArgReference(sqlSessionFactoryRef);
        registerIfNotAlreadyRegistered(builder.getBeanDefinition(), registry, sqlSessionFactoryRef.concat(SQL_SESSION_TEMPLATE_BEAN_NAME_SUFFIX), source);

        // create mybatis mapper register
        if (config instanceof MybatisAnnotationRepositoryConfigurationSource) {
            String[] mapperLocations = ((MybatisAnnotationRepositoryConfigurationSource) config).getMapperLocations();
            if (null != mapperLocations && mapperLocations.length > 0) {
                BeanDefinitionBuilder builder1 = BeanDefinitionBuilder.rootBeanDefinition(MybatisMappersRegister.class);
                builder1.addPropertyReference("sqlSessionFactory", sqlSessionFactoryRef);
                builder1.addPropertyValue("locations", mapperLocations);
                registerIfNotAlreadyRegistered(builder1.getBeanDefinition(), registry, sqlSessionFactoryRef.concat("_MapperLocations"), source);
            }
        }

    }

    @Override
    public void postProcess(BeanDefinitionBuilder builder, RepositoryConfigurationSource source) {
        String transactionManagerRef = source.getAttribute("transactionManagerRef");
        builder.addPropertyValue("transactionManager", null == transactionManagerRef ? DEFAULT_TRANSACTION_MANAGER_BEAN_NAME : transactionManagerRef);

        String sqlSessionFactoryRef = source.getAttribute("sqlSessionFactoryRef");
        sqlSessionFactoryRef = (null == sqlSessionFactoryRef ? DEFAULT_SQL_SESSION_FACTORY_BEAN_NAME : sqlSessionFactoryRef);
        builder.addPropertyReference("sqlSessionTemplate", sqlSessionFactoryRef.concat(SQL_SESSION_TEMPLATE_BEAN_NAME_SUFFIX));
        builder.addPropertyReference("dialect", sqlSessionFactoryRef.concat(DIALECT_BEAN_NAME_SUFFIX));
        builder.addPropertyReference("mappingContext", sqlSessionFactoryRef.concat(MAPPING_CONTEXT_SUFFIX));

    }

    @Override
    public void postProcess(BeanDefinitionBuilder builder, AnnotationRepositoryConfigurationSource config) {
        AnnotationAttributes attributes = config.getAttributes();
        builder.addPropertyValue(ENABLE_DEFAULT_TRANSACTIONS_ATTRIBUTE, attributes.getBoolean(ENABLE_DEFAULT_TRANSACTIONS_ATTRIBUTE));
    }

    @Override
    public void postProcess(BeanDefinitionBuilder builder, XmlRepositoryConfigurationSource config) {
        String enableDefaultTransactions = config.getAttribute(ENABLE_DEFAULT_TRANSACTIONS_ATTRIBUTE);
        if (StringUtils.hasText(enableDefaultTransactions)) {
            builder.addPropertyValue(ENABLE_DEFAULT_TRANSACTIONS_ATTRIBUTE, enableDefaultTransactions);
        }
    }


}
