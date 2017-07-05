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

package org.springframework.data.mybatis.repository.support;

import org.springframework.data.domain.Sort;
import org.springframework.data.mapping.Association;
import org.springframework.data.mapping.PersistentProperty;
import org.springframework.data.mapping.SimpleAssociationHandler;
import org.springframework.data.mapping.SimplePropertyHandler;
import org.springframework.data.mybatis.mapping.*;
import org.springframework.data.mybatis.repository.dialect.Dialect;
import org.springframework.data.repository.query.parser.Part.IgnoreCaseType;
import org.springframework.data.repository.query.parser.Part.Type;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import static org.springframework.data.repository.query.parser.Part.IgnoreCaseType.ALWAYS;
import static org.springframework.data.repository.query.parser.Part.IgnoreCaseType.WHEN_POSSIBLE;
import static org.springframework.data.repository.query.parser.Part.Type.*;

/**
 * @author Jarvis Song
 */
public class MybatisMapperGenerator {


    private final Dialect dialect;
    private final MybatisPersistentEntity<?> persistentEntity;

    public MybatisMapperGenerator(Dialect dialect, MybatisPersistentEntity<?> persistentEntity) {

        this.dialect = dialect;
        this.persistentEntity = persistentEntity;
    }

    public String buildConditionCaluse(Type type, IgnoreCaseType ignoreCaseType, String[] properties) {
        StringBuilder builder = new StringBuilder();
        switch (type) {
            case CONTAINING:
            case NOT_CONTAINING:
                if (ignoreCaseType == ALWAYS || ignoreCaseType == WHEN_POSSIBLE) {
                    builder.append("concat('%',upper(#{" + properties[0] + "}),'%')");
                } else {
                    builder.append("concat('%',#{" + properties[0] + "},'%')");
                }
                break;
            case STARTING_WITH:
                if (ignoreCaseType == ALWAYS || ignoreCaseType == WHEN_POSSIBLE) {
                    builder.append("concat(upper(#{" + properties[0] + "}),'%')");
                } else {
                    builder.append("concat(#{" + properties[0] + "},'%')");
                }
                break;
            case ENDING_WITH:
                if (ignoreCaseType == ALWAYS || ignoreCaseType == WHEN_POSSIBLE) {
                    builder.append("concat('%',upper(#{" + properties[0] + "}))");
                } else {
                    builder.append("concat('%',#{" + properties[0] + "})");
                }
                break;
            case IN:
            case NOT_IN:
                builder.append("<foreach item=\"item\" index=\"index\" collection=\"" + properties[0] + "\" open=\"(\" separator=\",\" close=\")\">#{item}</foreach>");
                break;
            case IS_NOT_NULL:
                builder.append(" is not null");
                break;
            case IS_NULL:
                builder.append(" is null");
                break;

            case TRUE:
                builder.append("=true");
                break;
            case FALSE:
                builder.append("=false");
                break;

            default:
                if (ignoreCaseType == ALWAYS || ignoreCaseType == WHEN_POSSIBLE) {
                    builder.append("upper(#{" + properties[0] + "})");
                } else {
                    builder.append("#{" + properties[0] + "}");
                }
                break;
        }

        return builder.toString();
    }

    public String buildConditionOperate(Type type) {
        StringBuilder builder = new StringBuilder();
        switch (type) {
            case SIMPLE_PROPERTY:
                builder.append("=");
                break;
            case NEGATING_SIMPLE_PROPERTY:
                builder.append("<![CDATA[<>]]>");
                break;
            case LESS_THAN:
            case BEFORE:
                builder.append("<![CDATA[<]]>");
                break;
            case LESS_THAN_EQUAL:
                builder.append("<![CDATA[<=]]>");
                break;
            case GREATER_THAN:
            case AFTER:
                builder.append("<![CDATA[>]]>");
                break;
            case GREATER_THAN_EQUAL:
                builder.append("<![CDATA[>=]]>");
                break;

            case LIKE:
            case NOT_LIKE:
            case STARTING_WITH:
            case ENDING_WITH:
                if (type == NOT_LIKE) {
                    builder.append(" not");
                }
                builder.append(" like ");
                break;
            case CONTAINING:
            case NOT_CONTAINING:
                if (type == NOT_CONTAINING) {
                    builder.append(" not");
                }
                builder.append(" like ");
                break;
            case IN:
            case NOT_IN:
                if (type == NOT_IN) {
                    builder.append(" not");
                }
                builder.append(" in ");
                break;

        }
        return builder.toString();
    }

    public String buildSelectColumns(final boolean basic) {
        final StringBuilder builder = new StringBuilder();

        persistentEntity.doWithProperties(new SimplePropertyHandler() {
            @Override
            public void doWithPersistentProperty(PersistentProperty<?> pp) {
                MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                builder.append(quota(persistentEntity.getEntityName()) + "." + dialect.wrapColumnName(property.getColumnName())).append(" as ").append(quota(property.getName())).append(",");
            }
        });

        persistentEntity.doWithAssociations(new SimpleAssociationHandler() {
            @Override
            public void doWithAssociation(Association<? extends PersistentProperty<?>> ass) {
                if ((ass instanceof MybatisEmbeddedAssociation)) {
                    final MybatisEmbeddedAssociation association = (MybatisEmbeddedAssociation) ass;
                    MybatisPersistentEntity<?> obversePersistentEntity = association.getObversePersistentEntity();
                    if (null != obversePersistentEntity) {
                        obversePersistentEntity.doWithProperties(new SimplePropertyHandler() {
                            @Override
                            public void doWithPersistentProperty(PersistentProperty<?> pp) {
                                MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                                builder.append(quota(persistentEntity.getEntityName()) + "." + dialect.wrapColumnName(property.getColumnName())).append(" as ").append(quota(association.getInverse().getName() + "." + property.getName())).append(",");
                            }
                        });
                    }
                    return;
                }

                if ((ass instanceof MybatisManyToOneAssociation)) {
                    final MybatisManyToOneAssociation association = (MybatisManyToOneAssociation) ass;
                    if (basic) {
                        builder.append(quota(persistentEntity.getEntityName()) + "." + dialect.wrapColumnName(association.getJoinColumnName())).append(" as ").append(quota(association.getInverse().getName() + "." + association.getObverse().getName())).append(",");
                        return;
                    } else {
                        MybatisPersistentEntity<?> obversePersistentEntity = association.getObversePersistentEntity();
                        if (null != obversePersistentEntity) {
                            obversePersistentEntity.doWithProperties(new SimplePropertyHandler() {
                                @Override
                                public void doWithPersistentProperty(PersistentProperty<?> pp) {
                                    MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                                    builder.append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName()) + "." + dialect.wrapColumnName(property.getColumnName()))
                                            .append(" as ").append(quota(association.getInverse().getName() + "." + property.getName())).append(",");
                                }
                            });
                            obversePersistentEntity.doWithAssociations(new SimpleAssociationHandler() {
                                @Override
                                public void doWithAssociation(Association<? extends PersistentProperty<?>> ass) {
                                    if ((ass instanceof MybatisEmbeddedAssociation)) {
                                        final MybatisEmbeddedAssociation association1 = (MybatisEmbeddedAssociation) ass;
                                        MybatisPersistentEntity<?> obversePersistentEntity1 = association1.getObversePersistentEntity();
                                        if (null != obversePersistentEntity1) {
                                            obversePersistentEntity1.doWithProperties(new SimplePropertyHandler() {
                                                @Override
                                                public void doWithPersistentProperty(PersistentProperty<?> pp) {
                                                    MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                                                    builder.append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName()) + "." + dialect.wrapColumnName(property.getColumnName()))
                                                            .append(" as ").append(quota(association.getInverse().getName() + "." + association1.getInverse().getName() + "." + property.getName())).append(",");
                                                }
                                            });
                                        }
                                        return;
                                    }

                                    if ((ass instanceof MybatisManyToOneAssociation)) {
                                        final MybatisManyToOneAssociation association1 = (MybatisManyToOneAssociation) ass;
                                        builder.append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName()) + "." + dialect.wrapColumnName(association1.getJoinColumnName()))
                                                .append(" as ").append(quota(association.getInverse().getName() + "." + association1.getInverse().getName() + "." + association1.getObverse().getName())).append(",");

                                    }
                                }
                            });
                        }


                    }
                }

                if ((ass instanceof MybatisOneToManyAssociation)) {
                    if (basic) {
                        return;
                    }

                    final MybatisOneToManyAssociation association = (MybatisOneToManyAssociation) ass;
                    MybatisPersistentEntity<?> obversePersistentEntity = association.getObversePersistentEntity();
                    if (null != obversePersistentEntity) {
                        obversePersistentEntity.doWithProperties(new SimplePropertyHandler() {
                            @Override
                            public void doWithPersistentProperty(PersistentProperty<?> pp) {
                                MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                                builder.append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName()) + "." + dialect.wrapColumnName(property.getColumnName()))
                                        .append(" as ").append(quota(association.getInverse().getName() + "." + property.getName())).append(",");
                            }
                        });
                        obversePersistentEntity.doWithAssociations(new SimpleAssociationHandler() {
                            @Override
                            public void doWithAssociation(Association<? extends PersistentProperty<?>> ass) {
                                if ((ass instanceof MybatisEmbeddedAssociation)) {
                                    final MybatisEmbeddedAssociation association1 = (MybatisEmbeddedAssociation) ass;
                                    MybatisPersistentEntity<?> obversePersistentEntity1 = association1.getObversePersistentEntity();
                                    if (null != obversePersistentEntity1) {
                                        obversePersistentEntity1.doWithProperties(new SimplePropertyHandler() {
                                            @Override
                                            public void doWithPersistentProperty(PersistentProperty<?> pp) {
                                                MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                                                builder.append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName()) + "." + dialect.wrapColumnName(property.getColumnName()))
                                                        .append(" as ").append(quota(association.getInverse().getName() + "." + association1.getInverse().getName() + "." + property.getName())).append(",");
                                            }
                                        });
                                    }
                                    return;
                                }

                                if ((ass instanceof MybatisManyToOneAssociation)) {
                                    final MybatisManyToOneAssociation association1 = (MybatisManyToOneAssociation) ass;
                                    builder.append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName()) + "." + dialect.wrapColumnName(association1.getJoinColumnName()))
                                            .append(" as ").append(quota(association.getInverse().getName() + "." + association1.getInverse().getName() + "." + association1.getObverse().getName())).append(",");

                                }
                            }
                        });
                    }

                }
            }
        });


        if (builder.length() > 0 && builder.charAt(builder.length() - 1) == ',') {
            builder.deleteCharAt(builder.length() - 1);
        }

        return builder.toString();
    }


    public String buildFrom(boolean basic) {
        StringBuilder builder = new StringBuilder();
        builder.append(dialect.wrapTableName(persistentEntity.getTableName())).append(" ").append(quota(persistentEntity.getEntityName()));
        if (!basic) {
            builder.append(buildLeftOuterJoin());
        }
        return builder.toString();
    }

    private String buildLeftOuterJoin() {
        final StringBuilder builder = new StringBuilder();

        persistentEntity.doWithAssociations(new SimpleAssociationHandler() {
            @Override
            public void doWithAssociation(Association<? extends PersistentProperty<?>> ass) {
                if ((ass instanceof MybatisManyToOneAssociation)) {
                    final MybatisManyToOneAssociation association = (MybatisManyToOneAssociation) ass;
                    builder.append(" left outer join ").append(dialect.wrapTableName(association.getObversePersistentEntity().getTableName())).append(" ")
                            .append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName()))
                            .append(" on ").append(quota(persistentEntity.getEntityName())).append(".").append(dialect.wrapColumnName(association.getJoinColumnName()))
                            .append("=").append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName())).append(".").append(dialect.wrapColumnName(association.getJoinReferencedColumnName()));
                    return;
                }

                if ((ass instanceof MybatisOneToManyAssociation)) {
                    final MybatisOneToManyAssociation association = (MybatisOneToManyAssociation) ass;

                    if (association.preferJoinTable()) {
                        // join table
                        builder.append(" left outer join ").append(dialect.wrapTableName(association.getJoinTableName())).append(" ")
                                .append(" on ");
                        String[] joinTableJoinColumnNames = association.getJoinTableJoinColumnNames();
                        String[] joinTableJoinReferencedColumnNames = association.getJoinTableJoinReferencedColumnNames();
                        for (int i = 0; i < joinTableJoinColumnNames.length; i++) {
                            if (i > 0) {
                                builder.append(" and ");
                            }
                            builder.append(dialect.wrapTableName(association.getJoinTableName())).append(".").append(joinTableJoinColumnNames[i]).append("=")
                                    .append(quota(persistentEntity.getEntityName())).append(".").append(dialect.wrapColumnName(joinTableJoinReferencedColumnNames[i]));
                        }
                        builder.append(" left outer join ").append(dialect.wrapTableName(association.getObversePersistentEntity().getTableName())).append(" ")
                                .append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName()))
                                .append(" on ");
                        String[] joinTableInverseJoinColumnNames = association.getJoinTableInverseJoinColumnNames();
                        String[] joinTableInverseJoinReferencedColumnNames = association.getJoinTableInverseJoinReferencedColumnNames();
                        for (int i = 0; i < joinTableInverseJoinColumnNames.length; i++) {
                            if (i > 0) {
                                builder.append(" and ");
                            }
                            builder.append(dialect.wrapTableName(association.getJoinTableName())).append(".").append(joinTableInverseJoinColumnNames[i]).append("=")
                                    .append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName())).append(".").append(dialect.wrapColumnName(joinTableInverseJoinReferencedColumnNames[i]));
                        }
                    } else {
                        // join column
                        builder.append(" left outer join ").append(dialect.wrapTableName(association.getObversePersistentEntity().getTableName())).append(" ")
                                .append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName()))
                                .append(" on ").append(quota(persistentEntity.getEntityName())).append(".").append(dialect.wrapColumnName(association.getJoinReferencedColumnName()))
                                .append("=").append(quota(persistentEntity.getEntityName() + "." + association.getInverse().getName())).append(".").append(dialect.wrapColumnName(association.getJoinColumnName()));
                    }
                }

            }
        });


//        if (!CollectionUtils.isEmpty(manyToManys)) {
//            for (MybatisEntityModel manyToMany : manyToManys) {
//                MybatisEntityModel.JoinTableConfig config = manyToMany.getJoinTableConfig();
//                builder.append(" left outer join ").append(config.getJoinTableName()).append(" ").append(quota(model.getName() + "." + manyToMany.getFromPropertyName())).append(" on ");
//                for (int i = 0; i < config.getJoinColumnsName().length; i++) {
//                    if (i > 0) {
//                        builder.append(" and ");
//                    }
//                    builder.append(quota(model.getName() + "." + manyToMany.getFromPropertyName())).append(".").append(config.getJoinColumnsName()[i]).append("=");
//                    builder.append(quota(model.getName())).append(".").append(config.getJoinColumnsReferencedColumnName()[i]);
//                }
//                builder.append(" left outer join ").append();
//            }
//
//        }

        return builder.toString();
    }

    private String quota(String alias) {
        return dialect.openQuote() + alias + dialect.closeQuote();
    }

    public String buildSorts(boolean basic, Sort sort) {
        StringBuilder builder = new StringBuilder();

        if (null != sort) {
            Map<String, String> map = new HashMap<String, String>();
            String[] arr = buildSelectColumns(basic).split(",");
            for (String s : arr) {
                if (StringUtils.isEmpty(s)) {
                    continue;
                }
                String[] ss = s.split(" as ");
                String key = ss[ss.length - 1];
                String val = ss[0];
                key = key.replace(String.valueOf(dialect.openQuote()), "").replace(String.valueOf(dialect.closeQuote()), "");
                map.put(key, val);
            }

            builder.append(" order by ");
            for (Iterator<Sort.Order> iterator = sort.iterator(); iterator.hasNext(); ) {
                Sort.Order order = iterator.next();
                String p = map.get(order.getProperty());
                builder.append((StringUtils.isEmpty(p) ? order.getProperty() : p) + " " + order.getDirection().name() + ",");
            }
            if (builder.length() > 0) {
                builder.deleteCharAt(builder.length() - 1);
            }
        } else {
            builder.append("<if test=\"_sorts != null\">");
            builder.append("<bind name=\"_columnsMap\" value='#{");
            String[] arr = buildSelectColumns(basic).split(",");
            for (String s : arr) {
                if (StringUtils.isEmpty(s)) {
                    continue;
                }
                String[] ss = s.split(" as ");
                String key = ss[ss.length - 1];
                String val = ss[0];
                key = key.replace(String.valueOf(dialect.openQuote()), "").replace(String.valueOf(dialect.closeQuote()), "");
                val = val.replace("\"", "\\\"");
                builder.append(String.format("\"%s\":\"%s\",", key, val));
            }
            if (builder.charAt(builder.length() - 1) == ',') {
                builder.deleteCharAt(builder.length() - 1);
            }
            builder.append("}' />");
            builder.append(" order by ");
            builder.append("<foreach item=\"item\" index=\"idx\" collection=\"_sorts\" open=\"\" separator=\",\" close=\"\">");
            builder.append("<if test=\"item.ignoreCase\">lower(</if>").append("${_columnsMap[item.property]}").append("<if test=\"item.ignoreCase\">)</if>").append(" ${item.direction}");
            builder.append("</foreach>");
            builder.append("</if>");
        }
        return builder.toString();
    }


}
