package org.springframework.data.mybatis.mapping;

import org.springframework.data.mybatis.annotations.JoinColumn;
import org.springframework.data.mybatis.annotations.JoinTable;
import org.springframework.util.StringUtils;

/**
 * @author Jarvis Song
 */
public class MybatisOneToManyAssociation extends MybatisAssociation {

    protected JoinColumn joinColumn;
    protected JoinTable  joinTable;

    public MybatisOneToManyAssociation(MybatisPersistentProperty inverse, MybatisPersistentProperty obverse) {
        super(inverse, obverse);
        //user,booking
        if (null != inverse) {
            joinColumn = inverse.findAnnotation(JoinColumn.class);
            joinTable = inverse.findAnnotation(JoinTable.class);
        }
    }

    public boolean preferJoinTable() {
        if (null != joinTable) {
            return true;
        }
        return false;
    }

    public String getJoinTableName() {
        if (null != joinTable && StringUtils.hasText(joinTable.name())) {
            return joinTable.name();
        }

        MybatisPersistentEntity<?> inversePersistentEntity = getInversePersistentEntity();
        MybatisPersistentEntity<?> obversePersistentEntity = getObversePersistentEntity();
        if (null != inversePersistentEntity && null != obversePersistentEntity) {
            return inversePersistentEntity.getTableName() + "_" + obversePersistentEntity.getTableName();
        }
        return null;
    }

    public String[] getJoinTableJoinColumnNames() {
        if (null != joinTable) {
            if (null != joinTable.joinColumns() && joinTable.joinColumns().length > 0) {
                String[] result = new String[joinTable.joinColumns().length];
                for (int i = 0; i < joinTable.joinColumns().length; i++) {
                    String name = joinTable.joinColumns()[i].name();
                    if (StringUtils.isEmpty(name)) {
                        MybatisPersistentEntity<?> entity = getInversePersistentEntity();
                        if (null != entity && entity.hasIdProperty()) {
                            name = entity.getTableName() + "_" + entity.getIdProperty().getColumnName();
                        }
                    }
                    result[i] = name;
                }
                return result;
            }
        }
        MybatisPersistentEntity<?> entity = getInversePersistentEntity();
        if (null != entity && entity.hasIdProperty()) {
            return new String[]{entity.getTableName() + "_" + entity.getIdProperty().getColumnName()};
        }
        return new String[0];
    }

    public String[] getJoinTableJoinReferencedColumnNames() {
        if (null != joinTable) {
            if (null != joinTable.joinColumns() && joinTable.joinColumns().length > 0) {
                String[] result = new String[joinTable.joinColumns().length];
                for (int i = 0; i < joinTable.joinColumns().length; i++) {
                    String name = joinTable.joinColumns()[i].referencedColumnName();
                    if (StringUtils.isEmpty(name)) {
                        MybatisPersistentEntity<?> entity = getInversePersistentEntity();
                        if (null != entity && entity.hasIdProperty()) {
                            name = entity.getIdProperty().getColumnName();
                        }
                    }
                    result[i] = name;
                }
                return result;
            }
        }
        MybatisPersistentEntity<?> entity = getInversePersistentEntity();
        if (null != entity && entity.hasIdProperty()) {
            return new String[]{entity.getIdProperty().getColumnName()};
        }
        return new String[0];
    }

    public String[] getJoinTableInverseJoinColumnNames() {
        if (null != joinTable) {
            if (null != joinTable.inverseJoinColumns() && joinTable.inverseJoinColumns().length > 0) {
                String[] result = new String[joinTable.inverseJoinColumns().length];
                for (int i = 0; i < joinTable.inverseJoinColumns().length; i++) {
                    String name = joinTable.inverseJoinColumns()[i].name();
                    if (StringUtils.isEmpty(name)) {
                        MybatisPersistentEntity<?> entity = getObversePersistentEntity();
                        if (null != entity && entity.hasIdProperty()) {
                            name = entity.getTableName() + "_" + entity.getIdProperty().getColumnName();
                        }
                    }
                    result[i] = name;
                }
                return result;
            }
        }
        MybatisPersistentEntity<?> entity = getObversePersistentEntity();
        if (null != entity && entity.hasIdProperty()) {
            return new String[]{entity.getTableName() + "_" + entity.getIdProperty().getColumnName()};
        }
        return new String[0];
    }

    public String[] getJoinTableInverseJoinReferencedColumnNames() {
        if (null != joinTable) {
            if (null != joinTable.inverseJoinColumns() && joinTable.inverseJoinColumns().length > 0) {
                String[] result = new String[joinTable.inverseJoinColumns().length];
                for (int i = 0; i < joinTable.inverseJoinColumns().length; i++) {
                    String name = joinTable.inverseJoinColumns()[i].referencedColumnName();
                    if (StringUtils.isEmpty(name)) {
                        MybatisPersistentEntity<?> entity = getObversePersistentEntity();
                        if (null != entity && entity.hasIdProperty()) {
                            name = entity.getIdProperty().getColumnName();
                        }
                    }
                    result[i] = name;
                }
                return result;
            }
        }
        MybatisPersistentEntity<?> entity = getObversePersistentEntity();
        if (null != entity && entity.hasIdProperty()) {
            return new String[]{entity.getIdProperty().getColumnName()};
        }
        return new String[0];
    }

    /**
     * @return
     */
    public String getJoinColumnName() {
        //user_id(booking's)
        if (null != joinColumn && StringUtils.hasText(joinColumn.name())) {
            return joinColumn.name();
        }
        MybatisPersistentEntity<?> entity = getInversePersistentEntity();
        if (null != entity && entity.hasIdProperty()) {
            return entity.getTableName() + "_" + entity.getIdProperty().getColumnName();
        }

        return null;
    }

    public String getJoinReferencedColumnName() {
        //id (user's)

        if (null != joinColumn && StringUtils.hasText(joinColumn.referencedColumnName())) {
            return joinColumn.referencedColumnName();
        }
        MybatisPersistentEntity<?> entity = getInversePersistentEntity();
        if (null != entity && entity.hasIdProperty()) {
            return entity.getIdProperty().getColumnName();
        }

        return null;
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


}
