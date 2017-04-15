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

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * @author Jarvis Song
 */
@ConfigurationProperties(prefix = MybatisProperties.PREFIX)
public class MybatisProperties {
    public static final String PREFIX = "spring.data.mybatis";

    private Class<?> defaultScriptingLanguage;

    private String[] mapperLocations;
    private String[] beforeMapperLocations;

    private String[] handlerPackages;

    private String[] repositoriesBasePackagesFile;
    private String[] repositoriesBasePackages;

    public Class<?> getDefaultScriptingLanguage() {
        return defaultScriptingLanguage;
    }

    public void setDefaultScriptingLanguage(Class<?> defaultScriptingLanguage) {
        this.defaultScriptingLanguage = defaultScriptingLanguage;
    }

    public String[] getMapperLocations() {
        return mapperLocations;
    }

    public void setMapperLocations(String[] mapperLocations) {
        this.mapperLocations = mapperLocations;
    }

    public String[] getBeforeMapperLocations() {
        return beforeMapperLocations;
    }

    public void setBeforeMapperLocations(String[] beforeMapperLocations) {
        this.beforeMapperLocations = beforeMapperLocations;
    }

    public String[] getRepositoriesBasePackagesFile() {
        return repositoriesBasePackagesFile;
    }

    public void setRepositoriesBasePackagesFile(String[] repositoriesBasePackagesFile) {
        this.repositoriesBasePackagesFile = repositoriesBasePackagesFile;
    }

    public String[] getRepositoriesBasePackages() {
        return repositoriesBasePackages;
    }

    public void setRepositoriesBasePackages(String[] repositoriesBasePackages) {
        this.repositoriesBasePackages = repositoriesBasePackages;
    }

    public String[] getHandlerPackages() {
        return handlerPackages;
    }

    public void setHandlerPackages(String[] handlerPackages) {
        this.handlerPackages = handlerPackages;
    }
}
