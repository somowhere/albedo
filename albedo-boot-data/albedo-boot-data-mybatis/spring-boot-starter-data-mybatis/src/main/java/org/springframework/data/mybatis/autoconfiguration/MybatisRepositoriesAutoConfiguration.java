/*
 *
 *   Copyright 2017 the original author or authors.
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

package org.springframework.data.mybatis.autoconfiguration;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.core.io.support.ResourcePatternUtils;
import org.springframework.data.mybatis.repository.config.MybatisRepositoryConfigExtension;
import org.springframework.data.mybatis.repository.support.MybatisRepository;
import org.springframework.data.mybatis.support.SqlSessionFactoryBean;
import org.springframework.util.StringUtils;

import javax.sql.DataSource;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * @author Jarvis Song
 */
@Configuration
@EnableConfigurationProperties(MybatisProperties.class)
@ConditionalOnProperty(prefix = "spring.data.mybatis.repositories", name = "enabled", havingValue = "true", matchIfMissing = true)
@ConditionalOnBean({DataSource.class})
@ConditionalOnMissingBean({MybatisRepositoryConfigExtension.class})
@ConditionalOnClass({MybatisRepository.class, SqlSessionFactory.class})
@AutoConfigureAfter({DataSourceAutoConfiguration.class, DataSourceTransactionManagerAutoConfiguration.class})
@Import(MybatisRepositoriesAutoConfigureRegistrar.class)
public class MybatisRepositoriesAutoConfiguration implements ResourceLoaderAware {

    @Autowired
    private MybatisProperties properties;
    private ResourceLoader resourceLoader;

    @Bean
    @ConditionalOnMissingBean
    public SqlSessionFactoryBean sqlSessionFactory(DataSource dataSource) throws Exception {
        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
        factoryBean.setDataSource(dataSource);

        if (null != properties.getBeforeMapperLocations() && properties.getBeforeMapperLocations().length > 0) {
            Set<Resource> set = new HashSet<Resource>();
            for (String s : properties.getBeforeMapperLocations()) {
                Resource[] resources = ResourcePatternUtils.getResourcePatternResolver(this.resourceLoader).getResources(s);
                if (null != resources && resources.length > 0) {
                    set.addAll(Arrays.asList(resources));
                }
            }
            if (!set.isEmpty()) {
                factoryBean.setMapperLocations(set.toArray(new Resource[set.size()]));
            }
        }

        String handlers = "ir.boot.autoconfigure.data.mybatis.handlers";
        if (null != properties.getHandlerPackages() && properties.getHandlerPackages().length > 0) {
            for (String s : properties.getHandlerPackages()) {
                if (StringUtils.isEmpty(s)) {
                    continue;
                }
                handlers += "," + s;
            }

        }

        factoryBean.setTypeHandlersPackage(handlers);

        org.apache.ibatis.session.Configuration configuration = factoryBean.getObject().getConfiguration();
        configuration.setMapUnderscoreToCamelCase(true);
        if (null != properties.getDefaultScriptingLanguage()) {
            configuration.setDefaultScriptingLanguage(properties.getDefaultScriptingLanguage());
        }
        return factoryBean;
    }


    public void setResourceLoader(ResourceLoader resourceLoader) {
        this.resourceLoader = resourceLoader;
    }


}
