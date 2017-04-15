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

package org.springframework.data.mybatis.domain.sample;

import org.springframework.data.mybatis.annotations.Condition;
import org.springframework.data.mybatis.annotations.Entity;
import org.springframework.data.mybatis.domains.LongId;

import static org.springframework.data.repository.query.parser.Part.Type.SIMPLE_PROPERTY;


/**
 * @author Jarvis Song
 */
@Entity(table = "DS_GROUP")
public class Group extends LongId {
    @Condition
    private String code;
    @Condition(type = SIMPLE_PROPERTY)
    private String name;

    public Group() {
    }

    public Group(Long id) {
        this.id = id;
    }

    public Group(String code, String name) {
        this.code = code;
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
