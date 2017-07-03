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

package org.springframework.data.mybatis.mapping;

import org.springframework.data.mapping.Association;
import org.springframework.data.mapping.PersistentProperty;
import org.springframework.data.mybatis.annotations.JoinColumn;
import org.springframework.util.StringUtils;

/**
 * @author Jarvis Song
 */
public class MybatisManyToOneAssociation extends MybatisAssociation {

    private JoinColumn joinColumn;

    /**
     * Creates a new {@link Association} between the two given {@link PersistentProperty}s.
     *
     * @param inverse
     * @param obverse
     */
    public MybatisManyToOneAssociation(MybatisPersistentProperty inverse, MybatisPersistentProperty obverse) {
        super(inverse, obverse);
        if (null != inverse) {
            joinColumn = inverse.findAnnotation(JoinColumn.class);
        }
    }


    public String getJoinColumnName() {
        String name = null;
        if (null != joinColumn && StringUtils.hasText(joinColumn.name())) {
            return joinColumn.name();
        } else {
            MybatisPersistentEntity<?> entity = getObversePersistentEntity();
            if (null != entity && entity.hasIdProperty()) {
                name = entity.getTableName() + "_" + entity.getIdProperty().getColumnName();
            }
        }
        return name;
    }

    @Override
    public MybatisPersistentProperty getObverse() {

        MybatisPersistentEntity<?> entity = getObversePersistentEntity();
        if (null == entity) {
            return null;
        }
        if (null == joinColumn || StringUtils.isEmpty(joinColumn.referencedColumnName())) {
            return entity.getIdProperty();
        }

        return entity.findByColumnName(joinColumn.referencedColumnName());

    }

    public String getJoinReferencedColumnName() {
        if (null != joinColumn && StringUtils.hasText(joinColumn.referencedColumnName())) {
            return joinColumn.referencedColumnName();
        }
        MybatisPersistentProperty obverse = getObverse();
        if (null != obverse) {
            return obverse.getColumnName();
        }

        return null;
    }

    public boolean insertable() {
        return null != joinColumn ? joinColumn.insertable() : true;
    }

    public boolean updatable() {
        return null != joinColumn ? joinColumn.updatable() : true;
    }
}
