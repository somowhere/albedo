package org.springframework.data.mybatis.mapping;

/**
 * @author Jarvis Song
 */
public class MybatisManyToManyAssociation extends MybatisOneToManyAssociation {

    public MybatisManyToManyAssociation(MybatisPersistentProperty inverse, MybatisPersistentProperty obverse) {
        super(inverse, obverse);
    }

    public boolean preferJoinTable() {
        if (null != joinColumn) {
            return false;
        }
        return true;
    }
}
