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

package org.springframework.data.mybatis.domains;

import org.springframework.data.annotation.Transient;
import org.springframework.data.domain.Persistable;
import org.springframework.data.mybatis.annotations.Condition;
import org.springframework.data.mybatis.annotations.Id;
import org.springframework.data.mybatis.annotations.MappedSuperclass;

import java.io.Serializable;

import static org.springframework.data.mybatis.annotations.Id.GenerationType.AUTO;

/**
 * Abstract base class for entities. Allows parameterization of id type, chooses auto-generation and implements
 * {@link #equals(Object)} and {@link #hashCode()} based on that id.
 *
 * @param <PK> the the of the entity
 * @author Jarvis Song
 */
@MappedSuperclass
public abstract class AbstractPersistable<PK extends Serializable> implements Persistable<PK> {

    private static final long serialVersionUID = -5554308939380869754L;

    /**
     * 构造函数.
     */
    public AbstractPersistable() {
    }

    /**
     * 构造函数.
     */
    public AbstractPersistable(PK id) {
        setId(id);
    }


    @Id(strategy = AUTO)
    //    @JdbcType(JDBCType.NUMERIC)
    protected PK id;

    /*
     * (non-Javadoc)
     * @see org.springframework.data.domain.Persistable#getId()
     */
    @Condition
    public PK getId() {
        return id;
    }


    /**
     * Sets the id of the entity.
     *
     * @param id the id to set
     */
    public void setId(final PK id) {
        this.id = id;
    }

    /**
     * Must be {@link Transient} in order to ensure that no JPA provider complains because of a missing setter.
     *
     * @see Persistable#isNew()
     */
    @Transient
    public boolean isNew() {
        return null == getId();
    }

    /*
     * (non-Javadoc)
     *
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return String.format("Entity of type %s with id: %s", this.getClass().getName(), getId());
    }

    /*
     * (non-Javadoc)
     *
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {

        if (null == obj) {
            return false;
        }

        if (this == obj) {
            return true;
        }

        if (!getClass().equals(obj.getClass())) {
            return false;
        }

        AbstractPersistable<?> that = (AbstractPersistable<?>) obj;

        return null == this.getId() ? false : this.getId().equals(that.getId());
    }

    /*
     * (non-Javadoc)
     *
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {

        int hashCode = 17;

        hashCode += null == getId() ? 0 : getId().hashCode() * 31;

        return hashCode;
    }

}
