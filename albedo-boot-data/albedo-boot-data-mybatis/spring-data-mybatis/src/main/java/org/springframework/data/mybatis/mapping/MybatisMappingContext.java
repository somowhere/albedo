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

import org.springframework.data.mapping.context.AbstractMappingContext;
import org.springframework.data.mapping.model.SimpleTypeHolder;
import org.springframework.data.util.TypeInformation;

import java.beans.PropertyDescriptor;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.util.Comparator;

/**
 * @author Jarvis Song
 */
public class MybatisMappingContext extends AbstractMappingContext<MybatisPersistentEntityImpl<?>, MybatisPersistentProperty> {


    @Override
    protected <T> MybatisPersistentEntityImpl<?> createPersistentEntity(TypeInformation<T> typeInformation) {
        return new MybatisPersistentEntityImpl<T>(this,typeInformation, new ResultMapComparator());
    }

    @Override
    protected MybatisPersistentProperty createPersistentProperty(Field field, PropertyDescriptor descriptor, MybatisPersistentEntityImpl<?> owner, SimpleTypeHolder simpleTypeHolder) {
        return new MybatisPersistentPropertyImpl(field, descriptor, owner, simpleTypeHolder);
    }

    /**
     * (constructor?,id*,result*,association*,collection*,discriminator?)
     */
    private static final class ResultMapComparator implements
            Comparator<org.springframework.data.mybatis.mapping.MybatisPersistentProperty>, Serializable {

        @Override
        public int compare(org.springframework.data.mybatis.mapping.MybatisPersistentProperty o1, org.springframework.data.mybatis.mapping.MybatisPersistentProperty o2) {
            if (o1.isIdProperty() && o2.isIdProperty()) {
                return 0;
            }
            if (o1.isIdProperty() && !o2.isIdProperty()) {
                return -1;
            }
            if (!o1.isIdProperty() && o2.isIdProperty()) {
                return 1;
            }

            if (o1.isAssociation() && !o2.isAssociation()) {
                return 1;
            }
            if (!o1.isAssociation() && o2.isAssociation()) {
                return -1;
            }

            if (o1.isAssociation() && o2.isAssociation()) {
                boolean o1ToOne = o1.isToOneAssociation();
                boolean o2ToOne = o2.isToOneAssociation();
                if (o1ToOne && !o2ToOne) {
                    return -1;
                }
                if (!o1ToOne && o2ToOne) {
                    return 1;
                }
            }

            char o1F = o1.getName().charAt(0);
            char o2F = o2.getName().charAt(0);
            if (o1F == o2F) {
                return 0;
            }
            return o1F < o2F ? -1 : 1;
        }
    }
}
