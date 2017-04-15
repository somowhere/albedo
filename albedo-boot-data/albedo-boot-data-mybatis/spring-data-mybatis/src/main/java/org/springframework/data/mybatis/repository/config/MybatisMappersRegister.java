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

import org.apache.ibatis.builder.xml.XMLMapperBuilder;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.core.io.Resource;
import org.springframework.data.mapping.model.MappingException;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.io.InputStream;

/**
 * @author Jarvis Song
 */
public class MybatisMappersRegister implements InitializingBean, ApplicationContextAware {

    private SqlSessionFactory  sqlSessionFactory;
    private String[]           locations;
    private ApplicationContext applicationContext;


    @Override
    public void afterPropertiesSet() throws Exception {
        Assert.notNull(sqlSessionFactory);
        if (StringUtils.isEmpty(locations)) {
            return;
        }

        Configuration configuration = sqlSessionFactory.getConfiguration();
        for (String s : locations) {
            if (StringUtils.isEmpty(s)) {
                continue;
            }

            Resource[] resources = applicationContext.getResources(s);
            if (null == resources || resources.length == 0) {
                continue;
            }
            for (Resource r : resources) {
                InputStream inputStream = r.getInputStream();
                String namespace = r.getFilename();
                String rr = "after_" + namespace;

                XMLMapperBuilder xmlMapperBuilder = new XMLMapperBuilder(inputStream, configuration, rr, configuration.getSqlFragments());
                try {
                    xmlMapperBuilder.parse();
                } catch (Exception e) {
                    throw new MappingException("parse after mapping error for " + namespace, e);
                } finally {
                    try {
                        inputStream.close();
                    } catch (IOException e) {
                        // ignore
                    }
                }
            }


        }


    }

    public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }

    public void setLocations(String[] locations) {
        this.locations = locations;
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }
}
