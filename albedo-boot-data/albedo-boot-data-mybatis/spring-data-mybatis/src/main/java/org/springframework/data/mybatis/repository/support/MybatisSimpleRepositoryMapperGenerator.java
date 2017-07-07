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

import org.apache.ibatis.builder.xml.XMLMapperBuilder;
import org.apache.ibatis.session.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.mapping.*;
import org.springframework.data.mapping.model.MappingException;
import org.springframework.data.mybatis.annotations.Condition;
import org.springframework.data.mybatis.annotations.Conditions;
import org.springframework.data.mybatis.annotations.DynamicSearch;
import org.springframework.data.mybatis.mapping.*;
import org.springframework.data.mybatis.repository.dialect.Dialect;
import org.springframework.data.mybatis.repository.dialect.identity.IdentityColumnSupport;
import org.springframework.data.repository.query.parser.Part.IgnoreCaseType;
import org.springframework.data.repository.query.parser.Part.Type;
import org.springframework.util.StringUtils;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import static org.springframework.data.mybatis.annotations.Id.GenerationType.*;

/**
 * generate basic mapper for simple repository automatic.
 *
 * @author Jarvis Song
 */
public class MybatisSimpleRepositoryMapperGenerator {
    private transient static final Logger logger = LoggerFactory.getLogger(MybatisSimpleRepositoryMapperGenerator.class);
    private static final String MAPPER_BEGIN = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
            "<!DOCTYPE mapper PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\" \"http://mybatis.org/dtd/mybatis-3-mapper.dtd\">";
    private static final String MAPPER_END = "</mapper>";

    private final Configuration configuration;
    private final Dialect dialect;
    private final MybatisMappingContext context;
    private final Class<?> domainClass;
    private final MybatisPersistentEntity<?> persistentEntity;
    private final MybatisMapperGenerator generator;

    public MybatisSimpleRepositoryMapperGenerator(Configuration configuration, Dialect dialect, MybatisMappingContext context, Class<?> domainClass) {
        this.configuration = configuration;
        this.dialect = dialect;
        this.context = context;
        this.domainClass = domainClass;
        this.persistentEntity = context.getPersistentEntity(domainClass);

        this.generator = new MybatisMapperGenerator(dialect, persistentEntity);
    }


    public void generate() {
        if (null == persistentEntity) {
            logger.warn("Could not find persistent entity for domain: " + domainClass + " from mapping context.");
            return;
        }
        String xml;
        String namespace = domainClass.getName();
        try {
            xml = render();
        } catch (IOException e) {
            throw new MappingException("create auto mapping error for " + namespace, e);
        }
        if (logger.isDebugEnabled()) {
            logger.debug("\n******************* Auto Generate MyBatis Mapping XML (" + namespace + ") *******************\n" + xml);
        }
        InputStream inputStream = null;
        try {
            inputStream = new ByteArrayInputStream(xml.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            // ignore
        }
        String resource = namespace + "_auto_generate.xml";
        try {
            XMLMapperBuilder xmlMapperBuilder = new XMLMapperBuilder(inputStream, configuration, resource, configuration.getSqlFragments(), namespace);
            xmlMapperBuilder.parse();
        } catch (Exception e) {
            throw new MappingException("create auto mapping error for " + namespace, e);
        } finally {
            try {
                inputStream.close();
            } catch (IOException e) {
                logger.error(e.getMessage(), e);
            }
        }
    }

    private String render() throws IOException {

        StringBuilder builder = new StringBuilder();
        builder.append(MAPPER_BEGIN);

        builder.append("<mapper namespace=\"" + domainClass.getName() + "\">");

        if (!isFragmentExist("TABLE_NAME")) {
            builder.append("<sql id=\"TABLE_NAME\">" + dialect.wrapTableName(persistentEntity.getTableName()) + "</sql>");
        }
        if (dialect.supportsSequences()) {
            if (!isFragmentExist("SEQUENCE")) {
                builder.append("<sql id=\"SEQUENCE\">" + dialect.getSequenceNextValString(persistentEntity.getSequenceName()) + "</sql>");
            }
        }
        if (!isFragmentExist("SELECT_CONDITION_INNER")) {
            builder.append("<sql id=\"SELECT_CONDITION_INNER\"></sql>");
        }
        if (!isResultMapExist("ResultMap")) {
            buildResultMap(builder);
        }
        if (!isStatementExist("_insert")) {
            buildInsertSQL(builder);
        }
        if (!isStatementExist("_update")) {
            buildUpdateSQL(builder, "_update", false);
        }
        if (!isStatementExist("_updateIgnoreNull")) {
            buildUpdateSQL(builder, "_updateIgnoreNull", true);
        }
        if (!isStatementExist("_getById")) {
            buildGetById(builder);
        }
        if (!isStatementExist("_findAll")) {
            buildFindAll(builder);
        }
        if (!isStatementExist("_findBasicAll")) {
            buildFindBasicAll(builder);
        }
        if (!isStatementExist("_count")) {
            buildCount(builder);
        }
        if (!isStatementExist("_deleteById")) {
            buildDeleteById(builder);
        }
        if (!isStatementExist("_deleteAll")) {
            buildDeleteAll(builder);
        }
        if (!isStatementExist("_findByPager")) {
            buildFindByPager(builder);
        }
        if (!isStatementExist("_findBasicByPager")) {
            buildFindBasicByPager(builder);
        }
        if (!isStatementExist("_countByCondition")) {
            buildCountByCondition(builder);
        }
        if (!isStatementExist("_countBasicByCondition")) {
            buildCountBasicByCondition(builder);
        }
        if (!isStatementExist("_getBasicById")) {
            buildGetBasicById(builder);
        }
        if (!isStatementExist("_deleteByCondition")) {
            buildDeleteByCondition(builder);
        }
        builder.append(MAPPER_END);
        String result = builder.toString();

        System.out.println(result);
        return result;
    }


    private void buildUpdateSQL(final StringBuilder builder, String statementName, final boolean ignoreNull) {
        if (!persistentEntity.hasIdProperty()) {
            return;
        }
        builder.append("<update id=\"" + statementName + "\" parameterType=\"" + domainClass.getName() + "\" lang=\"XML\">");
        builder.append("update ").append(dialect.wrapTableName(persistentEntity.getTableName()));
        builder.append("<set>");

        persistentEntity.doWithProperties(new SimplePropertyHandler() {
            @Override
            public void doWithPersistentProperty(PersistentProperty<?> pp) {
                MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                if (property.isIdProperty()) {
                    return;
                }

                if (property.isVersionProperty()) {
                    builder.append(dialect.wrapColumnName(property.getColumnName())).append("=").append(dialect.wrapColumnName(property.getColumnName())).append("+1,");
                    return;
                }
                if (!property.updatable()) return;
                if (ignoreNull) {
                    builder.append("<if test=\"" + property.getName() + " != null\">");
                }
                builder.append(dialect.wrapColumnName(property.getColumnName())).append("=#{").append(property.getName())
                        .append(",jdbcType=").append(property.getJdbcType())
                        .append(null != property.getSpecifiedTypeHandler() ? (",typeHandler=" + property.getSpecifiedTypeHandler().getName()) : "")
                        .append("},");
                if (ignoreNull) {
                    builder.append("</if>");
                }
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
                                if (ignoreNull) {
                                    builder.append("<if test=\"" + association.getInverse().getName() + " != null and " + association.getInverse().getName() + "." + property.getName() + " != null\">");
                                }
                                builder.append(dialect.wrapColumnName(property.getColumnName())).append("=#{").append(association.getInverse().getName()).append(".").append(property.getName()).append("},");
                                if (ignoreNull) {
                                    builder.append("</if>");
                                }
                            }
                        });
                    }
                    return;
                }

                if ((ass instanceof MybatisManyToOneAssociation)) {
                    MybatisManyToOneAssociation association = (MybatisManyToOneAssociation) ass;
                    if (!association.updatable()) return;
                    if (ignoreNull) {
                        builder.append("<if test=\"" + association.getInverse().getName() + " != null and " + association.getInverse().getName() + "." + association.getObverse().getName() + " != null\">");
                    }
                    builder.append(dialect.wrapColumnName(association.getJoinColumnName())).append("=#{").append(association.getInverse().getName()).append(".").append(association.getObverse().getName()).append("},");
                    if (ignoreNull) {
                        builder.append("</if>");
                    }
                    return;
                }


            }
        });

        if (builder.charAt(builder.length() - 1) == ',') {
            builder.deleteCharAt(builder.length() - 1);
        }
        builder.append("</set>");
        builder.append("<trim prefix=\"where\" prefixOverrides=\"and |or \">");

        final MybatisPersistentProperty idProperty = persistentEntity.getIdProperty();
        if (idProperty.isCompositeId()) {
            MybatisPersistentEntityImpl<?> idEntity = context.getPersistentEntity(idProperty.getActualType());
            if (null != idEntity) {
                idEntity.doWithProperties(new SimplePropertyHandler() {
                    @Override
                    public void doWithPersistentProperty(PersistentProperty<?> pp) {
                        MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                        builder.append(" and ").append(dialect.wrapColumnName(property.getColumnName())).append("=").append("#{").append(idProperty.getName()).append(".").append(property.getName()).append("}");
                    }
                });
            }
        } else {
            builder.append(" and ").append(dialect.wrapColumnName(idProperty.getColumnName())).append("=").append("#{").append(idProperty.getName()).append("}");
        }

        MybatisPersistentProperty versionProperty = persistentEntity.getVersionProperty();
        if (null != versionProperty) {
            builder.append(" and ").append(dialect.wrapColumnName(versionProperty.getColumnName())).append("=").append("#{").append(versionProperty.getName()).append("}");
        }

        builder.append("</trim>");
        builder.append("</update>");
    }


    private void buildDeleteByCondition(StringBuilder builder) {
        builder.append("<delete id=\"_deleteByCondition\" lang=\"XML\">");
        builder.append("delete");
        if (dialect.supportsDeleteAlias()) {
            builder.append(" ").append(quota(persistentEntity.getEntityName()));
        }
        builder.append(" from ").append(generator.buildFrom(true));

        builder.append("<if test=\"_condition != null\">");
        builder.append("<trim prefix=\" where \" prefixOverrides=\"and |or \">");
        builder.append(buildCondition());
        builder.append("<include refid=\"SELECT_CONDITION_INNER\" />");
        builder.append("</trim>");
        builder.append("</if>");
        builder.append("</delete>");
    }

    private void buildGetById(final StringBuilder builder) {
        builder.append("<select id=\"_getById\" parameterType=\"" + domainClass.getName() + "\" resultMap=\"ResultMap\" lang=\"XML\">");
        builder.append("select ").append(generator.buildSelectColumns(false)).append(" from ").append(generator.buildFrom(false));

        builder.append("<trim prefix=\" where \" prefixOverrides=\"and |or \">");
        buildByIdCaluse(builder);
        builder.append("</trim>");
        builder.append("</select>");
    }

    private void buildByIdCaluse(final StringBuilder builder) {
        final MybatisPersistentProperty idProperty = persistentEntity.getIdProperty();
        if (idProperty.isCompositeId()) {
            MybatisPersistentEntityImpl<?> idEntity = context.getPersistentEntity(idProperty.getActualType());
            if (null != idEntity) {
                idEntity.doWithProperties(new SimplePropertyHandler() {
                    @Override
                    public void doWithPersistentProperty(PersistentProperty<?> pp) {
                        MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                        builder.append(" and ").append(quota(persistentEntity.getEntityName())).append(".").append(dialect.wrapColumnName(property.getColumnName()))
                                .append("=").append("#{" + idProperty.getName() + "." + property.getName() + "}");
                    }
                });
            }
        } else {
            builder.append(" and ").append(quota(persistentEntity.getEntityName())).append(".").append(dialect.wrapColumnName(idProperty.getColumnName()))
                    .append("=").append("#{" + idProperty.getName() + "}");
        }
    }

    private void buildGetBasicById(final StringBuilder builder) {


        builder.append("<select id=\"_getBasicById\" parameterType=\"" + domainClass.getName() + "\" resultMap=\"ResultMap\" lang=\"XML\">");
        builder.append("select ").append(generator.buildSelectColumns(true)).append(" from ").append(generator.buildFrom(true));
        builder.append("<trim prefix=\" where \" prefixOverrides=\"and |or \">");
        buildByIdCaluse(builder);
        builder.append("</trim>");
        builder.append("</select>");
    }

    private void buildFindBasicByPager(StringBuilder builder) {

        builder.append("<select id=\"_findBasicByPager\" resultMap=\"ResultMap\" lang=\"XML\">");
        StringBuilder condition = new StringBuilder();
        condition.append("<if test=\"_condition != null\">");
        condition.append("<trim prefix=\" where \" prefixOverrides=\"and |or \">");
        condition.append(buildCondition());
        condition.append("<include refid=\"SELECT_CONDITION_INNER\" />");
        condition.append("</trim>");
        condition.append("</if>");

        builder.append(dialect.getLimitHandler().processSql(true, generator.buildSelectColumns(true), " from " + generator.buildFrom(true), condition.toString(), generator.buildSorts(true, null)));

        builder.append("</select>");
    }


    private void buildFindByPager(StringBuilder builder) {
        builder.append("<select id=\"_findByPager\" resultMap=\"ResultMap\" lang=\"XML\">");
        StringBuilder condition = new StringBuilder();
        condition.append("<if test=\"_condition != null\">");
        condition.append("<trim prefix=\" where \" prefixOverrides=\"and |or \">");
        condition.append(buildCondition());
        condition.append("<include refid=\"SELECT_CONDITION_INNER\" />");
        condition.append("</trim>");
        condition.append("</if>");

        builder.append(dialect.getLimitHandler().processSql(true, generator.buildSelectColumns(false), " from " + generator.buildFrom(false), condition.toString(), generator.buildSorts(false, null)));

        builder.append("</select>");
    }

    private void buildDeleteAll(StringBuilder builder) {
        builder.append("<delete id=\"_deleteAll\">truncate table " + dialect.wrapTableName(persistentEntity.getTableName()) + " </delete>");
    }

    private void buildDeleteById(final StringBuilder builder) {
        if (!persistentEntity.hasIdProperty()) {
            return;
        }
        builder.append("<delete id=\"_deleteById\" parameterType=\"" + domainClass.getName() + "\" lang=\"XML\">");

        builder.append("delete");
        if (dialect.supportsDeleteAlias()) {
            builder.append(" ").append(quota(persistentEntity.getEntityName()));
        }
        builder.append(" from ").append(generator.buildFrom(true));

        builder.append("<trim prefix=\" where \" prefixOverrides=\"and |or \">");


        final MybatisPersistentProperty idProperty = persistentEntity.getIdProperty();
        if (idProperty.isCompositeId()) {
            MybatisPersistentEntityImpl<?> idEntity = context.getPersistentEntity(idProperty.getActualType());
            if (null != idEntity) {
                idEntity.doWithProperties(new PropertyHandler<MybatisPersistentProperty>() {
                    @Override
                    public void doWithPersistentProperty(MybatisPersistentProperty property) {
                        builder.append("and ").append(dialect.wrapColumnName(property.getColumnName())).append("=#{" + idProperty.getName() + "." + property.getName() + "}");

                    }
                });
            }
        } else {
            builder.append(" and ").append(dialect.wrapColumnName(idProperty.getColumnName())).append("=#{" + idProperty.getName() + "}");
        }

        builder.append("</trim>");
        builder.append("</delete>");
    }

    private void buildCount(StringBuilder builder) {
        builder.append("<select id=\"_count\" resultType=\"long\" lang=\"XML\">");
        builder.append("select count(*) from ");
        builder.append(generator.buildFrom(true));
        builder.append("</select>");

    }


    private void buildCountByCondition(StringBuilder builder) {
        builder.append("<select id=\"_countByCondition\" resultType=\"long\" lang=\"XML\">");

        builder.append("select count(*) from ").append(generator.buildFrom(false));

        builder.append("<if test=\"_condition != null\">");
        builder.append("<trim prefix=\" where \" prefixOverrides=\"and |or \">");
        builder.append(buildCondition());
        builder.append("<include refid=\"SELECT_CONDITION_INNER\" />");
        builder.append("</trim>");
        builder.append("</if>");

        builder.append("</select>");
    }

    private void buildCountBasicByCondition(StringBuilder builder) {
        builder.append("<select id=\"_countBasicByCondition\" resultType=\"long\" lang=\"XML\">");

        builder.append("select count(*) from ").append(generator.buildFrom(true));

        builder.append("<if test=\"_condition != null\">");
        builder.append("<trim prefix=\" where \" prefixOverrides=\"and |or \">");
        builder.append(buildCondition());
        builder.append("<include refid=\"SELECT_CONDITION_INNER\" />");
        builder.append("</trim>");
        builder.append("</if>");

        builder.append("</select>");
    }

    private String buildCondition() {
        final StringBuilder builder = new StringBuilder();
        if (persistentEntity.findAnnotation(DynamicSearch.class) != null) {
            builder.append(" ${_sqlConditionDsf} ");
        }
        persistentEntity.doWithProperties(new PropertyHandler<MybatisPersistentProperty>() {
            @Override
            public void doWithPersistentProperty(MybatisPersistentProperty property) {

                Set<Condition> conditions = new HashSet<Condition>();
                Condition cond = property.findAnnotation(Condition.class);
                if (null != cond) {
                    conditions.add(cond);
                }
                Conditions conds = property.findAnnotation(Conditions.class);
                if (null != conds && null != conds.value() && conds.value().length > 0) {
                    conditions.addAll(Arrays.asList(conds.value()));
                }
                if (conditions.isEmpty()) {
                    return;
                }
                for (Condition condition : conditions) {
                    String[] condProperties = condition.properties();
                    String condColumn = condition.column();
                    String condAlias = condition.alias();
                    Type condType = condition.type();
                    IgnoreCaseType ignoreCaseType = condition.ignoreCaseType();
                    if (null == condProperties || condProperties.length == 0) {
                        condProperties = new String[]{property.getName()};
                    }
                    if (StringUtils.isEmpty(condColumn)) {
                        condColumn = dialect.wrapColumnName(property.getColumnName());
                    }
                    if (StringUtils.isEmpty(condAlias)) {
                        condAlias = persistentEntity.getEntityName();
                    }
                    builder.append("<if test=\"_condition != null");

                    for (int i = 0; i < condProperties.length; i++) {
                        String condProperty = condProperties[i];
                        String[] split = condProperty.split("\\.");
                        if (split.length > 1) {
                            builder.append(" and _condition." + split[0] + " != null");
                        }
                        builder.append(" and _condition." + condProperty + " != null");
                    }
                    builder.append("\">");

                    builder.append(" and ").append(quota(condAlias)).append(".").append(condColumn);
                    builder.append(generator.buildConditionOperate(condType));
                    for (int i = 0; i < condProperties.length; i++) {
                        condProperties[i] = "_condition." + condProperties[i];
                    }
                    builder.append(generator.buildConditionCaluse(condType, ignoreCaseType, condProperties));
                    builder.append("</if>");
                }

            }
        });
        persistentEntity.doWithAssociations(new AssociationHandler<MybatisPersistentProperty>() {
            @Override
            public void doWithAssociation(Association<MybatisPersistentProperty> association) {
                MybatisPersistentProperty property = association.getInverse();
                Set<Condition> conditions = new HashSet<Condition>();
                Condition cond = property.findAnnotation(Condition.class);
                if (null != cond) {
                    conditions.add(cond);
                }
                Conditions conds = property.findAnnotation(Conditions.class);
                if (null != conds && null != conds.value() && conds.value().length > 0) {
                    conditions.addAll(Arrays.asList(conds.value()));
                }
                if (conditions.isEmpty()) {
                    return;
                }
                for (Condition condition : conditions) {
                    String[] condProperties = condition.properties();
                    String condColumn = condition.column();
                    String condAlias = condition.alias();
                    Type condType = condition.type();
                    IgnoreCaseType ignoreCaseType = condition.ignoreCaseType();
                    if (null == condProperties || condProperties.length == 0) {
                        condProperties = new String[]{property.getName()};
                    }
                    if (StringUtils.isEmpty(condColumn)) {
                        condColumn = dialect.wrapColumnName(property.getColumnName());
                    }
                    if (StringUtils.isEmpty(condAlias)) {
                        condAlias = persistentEntity.getEntityName();
                    }
                    builder.append("<if test=\"_condition != null");

                    for (int i = 0; i < condProperties.length; i++) {
                        String condProperty = condProperties[i];
                        String[] split = condProperty.split("\\.");
                        if (split.length > 1) {
                            builder.append(" and _condition." + split[0] + " != null");
                        }
                        builder.append(" and _condition." + condProperty + " != null");
                    }
                    builder.append("\">");

                    builder.append(" and ").append(quota(condAlias)).append(".").append(condColumn);
                    builder.append(generator.buildConditionOperate(condType));
                    for (int i = 0; i < condProperties.length; i++) {
                        condProperties[i] = "_condition." + condProperties[i];
                    }
                    builder.append(generator.buildConditionCaluse(condType, ignoreCaseType, condProperties));
                    builder.append("</if>");
                }

            }
        });

        return builder.toString();

    }


    private void buildFindBasicAll(StringBuilder builder) {
        builder.append("<select id=\"_findBasicAll\" resultMap=\"ResultMap\" lang=\"XML\">");

        builder.append("select ").append(generator.buildSelectColumns(true)).append(" from ").append(generator.buildFrom(true));


        builder.append("<if test=\"_condition != null\">");
        builder.append("<trim prefix=\" where \" prefixOverrides=\"and |or \">");
        builder.append(buildCondition());
        builder.append("<include refid=\"SELECT_CONDITION_INNER\" />");
        builder.append("</trim>");
        builder.append("</if>");

        if (persistentEntity.hasIdProperty()) {
            MybatisPersistentProperty idProperty = persistentEntity.getIdProperty();
            if (!idProperty.isCompositeId()) {
                builder.append("<if test=\"_ids != null\">");

                builder.append(" where ").append(quota(persistentEntity.getEntityName())).append(".").append(dialect.wrapColumnName(idProperty.getColumnName())).append(" in ");
                builder.append("<foreach item=\"item\" index=\"index\" collection=\"_ids\" open=\"(\" separator=\",\" close=\")\">#{item}</foreach>");

                builder.append("</if>");
            }
        }
        builder.append(generator.buildSorts(true, null));

        builder.append("</select>");
    }

    private void buildFindAll(StringBuilder builder) {
        builder.append("<select id=\"_findAll\" resultMap=\"ResultMap\" lang=\"XML\">");
        builder.append("select ").append(generator.buildSelectColumns(false)).append(" from ").append(generator.buildFrom(false));

        builder.append("<if test=\"_condition != null\">");
        builder.append("<trim prefix=\" where \" prefixOverrides=\"and |or \">");
        builder.append(buildCondition());
        builder.append("<include refid=\"SELECT_CONDITION_INNER\" />");

        builder.append("</trim>");
        builder.append("</if>");

        if (persistentEntity.hasIdProperty()) {
            builder.append("<if test=\"_ids != null\">");

            MybatisPersistentProperty idProperty = persistentEntity.getIdProperty();
            if (!idProperty.isCompositeId()) {
                builder.append(" where ").append(quota(persistentEntity.getEntityName())).append(".").append(dialect.wrapColumnName(idProperty.getColumnName())).append(" in ");
                builder.append("<foreach item=\"item\" index=\"index\" collection=\"_ids\" open=\"(\" separator=\",\" close=\")\">#{item}</foreach>");
            }
            builder.append("</if>");
        }
        builder.append(generator.buildSorts(false, null));

        builder.append("</select>");
    }


    private void buildInsertSQL(final StringBuilder builder) {
        builder.append("<insert id=\"_insert\" parameterType=\"" + domainClass.getName() + "\" lang=\"XML\"");

        MybatisPersistentProperty idProperty = persistentEntity.getIdProperty();
        if (persistentEntity.hasIdProperty() && !idProperty.isCompositeId()) {
            builder.append(" keyProperty=\"" + idProperty.getName() + "\" keyColumn=\"" + idProperty.getColumnName() + "\"");
        }

        builder.append(">");
        if (persistentEntity.hasIdProperty() && !idProperty.isCompositeId()) {
            IdentityColumnSupport identityColumnSupport = dialect.getIdentityColumnSupport();
            if (idProperty.getIdGenerationType() == IDENTITY || (idProperty.getIdGenerationType() == AUTO && identityColumnSupport.supportsIdentityColumns())) {
                builder.append("<selectKey keyProperty=\"" + idProperty.getName() + "\" resultType=\"" + idProperty.getActualType().getName() + "\" order=\"AFTER\">");
                builder.append(dialect.getIdentityColumnSupport().getIdentitySelectString(persistentEntity.getTableName(), idProperty.getColumnName(), idProperty.getJdbcType().TYPE_CODE));
                builder.append("</selectKey>");
            } else if (idProperty.getIdGenerationType() == SEQUENCE || (idProperty.getIdGenerationType() == AUTO && dialect.supportsSequences())) {
                builder.append("<selectKey keyProperty=\"" + idProperty.getName() + "\" resultType=\"" + idProperty.getActualType().getName() + "\" order=\"BEFORE\">");
                builder.append("<include refid=\"SEQUENCE\" />");
                builder.append("</selectKey>");
            }
        }
        builder.append("<![CDATA[");

        builder.append("insert into ").append(dialect.wrapTableName(persistentEntity.getTableName())).append("(");


        persistentEntity.doWithProperties(new SimplePropertyHandler() {
            @Override
            public void doWithPersistentProperty(PersistentProperty<?> pp) {
                MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                if (property.isIdProperty()) {
                    if (property.isCompositeId()) {
                        MybatisPersistentEntityImpl<?> idEntity = context.getPersistentEntity(property.getActualType());
                        if (null != idEntity) {
                            idEntity.doWithProperties(new SimplePropertyHandler() {
                                @Override
                                public void doWithPersistentProperty(PersistentProperty<?> pp) {
                                    MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                                    builder.append(dialect.wrapColumnName(property.getColumnName())).append(",");
                                }
                            });
                        }
                        return;
                    }
                    IdentityColumnSupport identityColumnSupport = dialect.getIdentityColumnSupport();
                    if (property.getIdGenerationType() == IDENTITY || (property.getIdGenerationType() == AUTO && identityColumnSupport.supportsIdentityColumns())) {
                        return;
                    }
                }
                if (!property.insertable()) return;
                builder.append(dialect.wrapColumnName(property.getColumnName())).append(",");
            }
        });

        persistentEntity.doWithAssociations(new SimpleAssociationHandler() {
            @Override
            public void doWithAssociation(Association<? extends PersistentProperty<?>> ass) {

                if ((ass instanceof MybatisEmbeddedAssociation)) {
                    MybatisEmbeddedAssociation association = (MybatisEmbeddedAssociation) ass;
                    MybatisPersistentEntity<?> obversePersistentEntity = association.getObversePersistentEntity();
                    if (null != obversePersistentEntity) {
                        obversePersistentEntity.doWithProperties(new SimplePropertyHandler() {
                            @Override
                            public void doWithPersistentProperty(PersistentProperty<?> pp) {
                                MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                                builder.append(dialect.wrapColumnName(property.getColumnName())).append(",");
                            }
                        });
                    }
                    return;
                }

                if ((ass instanceof MybatisManyToOneAssociation)) {
                    MybatisManyToOneAssociation association = (MybatisManyToOneAssociation) ass;
                    if (!association.insertable()) return;
                    builder.append(dialect.wrapColumnName(association.getJoinColumnName())).append(",");
                    return;
                }


            }
        });

        if (builder.charAt(builder.length() - 1) == ',') {
            builder.deleteCharAt(builder.length() - 1);
        }
        builder.append(") values(");

        persistentEntity.doWithProperties(new SimplePropertyHandler() {
            @Override
            public void doWithPersistentProperty(PersistentProperty<?> pp) {
                MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                if (property.isIdProperty()) {
                    if (property.isCompositeId()) {
                        MybatisPersistentEntityImpl<?> idEntity = context.getPersistentEntity(property.getActualType());
                        if (null != idEntity) {
                            idEntity.doWithProperties(new SimplePropertyHandler() {
                                @Override
                                public void doWithPersistentProperty(PersistentProperty<?> pp) {
                                    MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                                    builder.append("#{").append(property.getName()).append(",jdbcType=").append(property.getJdbcType()).append("},");
                                }
                            });
                        }
                        return;
                    }
                    if (!property.insertable()) return;
                    IdentityColumnSupport identityColumnSupport = dialect.getIdentityColumnSupport();
                    if (property.getIdGenerationType() == IDENTITY || (property.getIdGenerationType() == AUTO && identityColumnSupport.supportsIdentityColumns())) {
                        return;
                    }
                }
                builder.append("#{").append(property.getName()).append(",jdbcType=").append(property.getJdbcType());
                if (null != property.getSpecifiedTypeHandler()) {
                    builder.append(",typeHandler=").append(property.getSpecifiedTypeHandler().getName());
                }
                builder.append("},");
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
                                builder.append("#{").append(association.getInverse().getName()).append(".").append(property.getName()).append(",jdbcType=").append(property.getJdbcType()).append("},");
                            }
                        });
                    }
                    return;
                }
                if ((ass instanceof MybatisManyToOneAssociation)) {
                    MybatisManyToOneAssociation association = (MybatisManyToOneAssociation) ass;
                    if (!association.insertable()) return;
                    builder.append("#{").append(association.getInverse().getName()).append(".").append(association.getObverse().getName()).append(",jdbcType=").append(association.getObverse().getJdbcType()).append("},");
                    return;
                }
            }
        });

        if (builder.charAt(builder.length() - 1) == ',') {
            builder.deleteCharAt(builder.length() - 1);
        }

        builder.append(")]]>");

        builder.append("</insert>");


    }


    private void buildInnerResultMapId(final StringBuilder builder, final MybatisPersistentProperty idProperty, final String prefix) {

        if (null != idProperty) {
            if (idProperty.isCompositeId()) {

                MybatisPersistentEntityImpl<?> idEntity = context.getPersistentEntity(idProperty.getActualType());
                if (null != idEntity) {
                    idEntity.doWithProperties(new SimplePropertyHandler() {
                        @Override
                        public void doWithPersistentProperty(PersistentProperty<?> pp) {
                            MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                            builder.append(String.format("<id property=\"%s\" column=\"%s\" javaType=\"%s\" jdbcType=\"%s\"/>",
                                    idProperty.getName() + "." + property.getName(),
                                    alias(prefix + property.getName()),
                                    property.getActualType().getName(),
                                    property.getJdbcType()
                            ));
                        }
                    });
                }

            } else {
                builder.append(String.format("<id property=\"%s\" column=\"%s\" javaType=\"%s\" jdbcType=\"%s\"/>",
                        idProperty.getName(),
                        alias(prefix + idProperty.getName()),
                        idProperty.getActualType().getName(),
                        idProperty.getJdbcType()
                ));
            }
        }
    }

    private void buildInnerResultMap(final StringBuilder builder, final MybatisPersistentEntity<?> persistentEntity, final String prefix) {

        final StringBuilder constructorBuilder = new StringBuilder();
        final StringBuilder resultBuilder = new StringBuilder();

        PreferredConstructor<?, MybatisPersistentProperty> persistenceConstructor = persistentEntity.getPersistenceConstructor();
        if (null != persistenceConstructor && persistenceConstructor.hasParameters()) {
            constructorBuilder.append("<constructor>");

            for (PreferredConstructor.Parameter<Object, MybatisPersistentProperty> parameter : persistenceConstructor.getParameters()) {
                MybatisPersistentProperty property = persistentEntity.getPersistentProperty(parameter.getName());
                if (null != property) {
                    if (property.isIdProperty()) {
                        if (property.isCompositeId()) {
                            MybatisPersistentEntityImpl<?> idEntity = context.getPersistentEntity(property.getActualType());
                            if (null != idEntity) {
                                idEntity.doWithProperties(new SimplePropertyHandler() {
                                    @Override
                                    public void doWithPersistentProperty(PersistentProperty<?> pp) {
                                        MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                                        constructorBuilder.append(String.format("<idArg column=\"%s\" javaType=\"%s\" jdbcType=\"%s\"/>",
                                                alias(prefix + property.getName()),
                                                property.getActualType().getName(),
                                                property.getJdbcType()
                                        ));
                                    }
                                });
                            }
                        } else {
                            constructorBuilder.append(String.format("<idArg column=\"%s\" javaType=\"%s\" jdbcType=\"%s\"/>",
                                    alias(prefix + property.getName()),
                                    property.getActualType().getName(),
                                    property.getJdbcType()
                            ));
                        }
                    } else {
                        constructorBuilder.append(String.format("<arg column=\"%s\" javaType=\"%s\" jdbcType=\"%s\"/>",
                                alias(prefix + property.getName()),
                                property.getActualType().getName(),
                                property.getJdbcType()
                        ));
                    }
                } else {


                }
            }


            constructorBuilder.append("</constructor>");
        }


        persistentEntity.doWithProperties(new SimplePropertyHandler() {
            @Override
            public void doWithPersistentProperty(PersistentProperty<?> pp) {
                MybatisPersistentProperty property = (MybatisPersistentProperty) pp;
                if (persistentEntity.isConstructorArgument(property)) {
                    return;
                }


                if (property.isIdProperty()) {
                    buildInnerResultMapId(resultBuilder, property, prefix);
                    return;
                }
                resultBuilder.append(String.format("<result property=\"%s\" column=\"%s\" javaType=\"%s\" jdbcType=\"%s\""
                                + (null != property.getSpecifiedTypeHandler() ? (" typeHandler=\"" + property.getSpecifiedTypeHandler().getName() + "\"") : "")
                                + " />",
                        property.getName(),
                        alias(prefix + property.getName()),
                        property.getActualType().getName(),
                        property.getJdbcType()
                ));
            }
        });


        builder.append(constructorBuilder).append(resultBuilder);
    }

    private void buildInnerToOneAssociationResultMap(final StringBuilder builder, final PersistentProperty<? extends PersistentProperty<?>> inverse) {
        Class<?> actualType = inverse.getActualType();
        builder.append(String.format("<association property=\"%s\" javaType=\"%s\">",
                inverse.getName(),
                actualType.getName()
        ));
        MybatisPersistentEntityImpl<?> inversePersistentEntity = context.getPersistentEntity(actualType);
        if (null != inversePersistentEntity) {
            buildInnerResultMap(builder, inversePersistentEntity, inverse.getName() + ".");

            inversePersistentEntity.doWithAssociations(new AssociationHandler<MybatisPersistentProperty>() {
                @Override
                public void doWithAssociation(final Association<MybatisPersistentProperty> ass) {
                    if (ass instanceof MybatisEmbeddedAssociation) {
                        MybatisPersistentEntityImpl<?> inversePersistentEntity1 = context.getPersistentEntity(ass.getInverse().getActualType());

                        builder.append(String.format("<association property=\"%s\" javaType=\"%s\">",
                                ass.getInverse().getName(),
                                ass.getInverse().getActualType().getName()
                        ));

                        inversePersistentEntity1.doWithProperties(new PropertyHandler<MybatisPersistentProperty>() {
                            @Override
                            public void doWithPersistentProperty(MybatisPersistentProperty p1) {
                                builder.append(String.format("<result property=\"%s\" column=\"%s\" javaType=\"%s\" jdbcType=\"%s\"" + (
                                                null != p1.getSpecifiedTypeHandler() ? (" typeHandler=\"" + p1.getSpecifiedTypeHandler().getName() + "\"") : ""
                                        ) + "/>",
                                        p1.getName(),
                                        alias(inverse.getName() + "." + ass.getInverse().getName() + "." + p1.getName()),
                                        p1.getActualType().getName(),
                                        p1.getJdbcType()
                                ));
                            }
                        });


                        builder.append("</association>");
                        return;
                    }
                    if (ass instanceof MybatisManyToOneAssociation) {
                        MybatisManyToOneAssociation association = (MybatisManyToOneAssociation) ass;
                        builder.append(String.format("<association property=\"%s\" javaType=\"%s\">",
                                ass.getInverse().getName(),
                                ass.getInverse().getActualType().getName()
                        ));

                        builder.append(String.format("<result property=\"%s\" column=\"%s\" javaType=\"%s\" jdbcType=\"%s\"" + (
                                        null != association.getObverse().getSpecifiedTypeHandler() ? (" typeHandler=\"" + association.getObverse().getSpecifiedTypeHandler().getName() + "\"") : ""
                                ) + "/>",
                                association.getObverse().getName(),
                                alias(inverse.getName() + "." + ass.getInverse().getName() + "." + association.getObverse().getName()),
                                association.getObverse().getActualType().getName(),
                                association.getObverse().getJdbcType()
                        ));
                        builder.append("</association>");
                        return;
                    }
                }
            });

        }
        builder.append("</association>");
    }

    private void buildInnerToManyAssociationResultMap(final StringBuilder builder, PersistentProperty<? extends PersistentProperty<?>> inverse) {
        Class<?> actualType = inverse.getActualType();
        builder.append(String.format("<collection property=\"%s\" ofType=\"%s\">",
                inverse.getName(),
                actualType.getName()
        ));
        MybatisPersistentEntityImpl<?> inversePersistentEntity = context.getPersistentEntity(actualType);
        if (null != inversePersistentEntity) {
            buildInnerResultMap(builder, inversePersistentEntity, inverse.getName() + ".");


        }
        builder.append("</collection>");
    }

    private void buildResultMap(final StringBuilder builder) {
        builder.append("<resultMap id=\"ResultMap\" type=\"" + domainClass.getName() + "\">");


        buildInnerResultMap(builder, persistentEntity, "");

        persistentEntity.doWithAssociations(new AssociationHandler<MybatisPersistentProperty>() {
            @Override
            public void doWithAssociation(Association<MybatisPersistentProperty> ass) {
                MybatisPersistentProperty inverse = ass.getInverse();

                if (ass instanceof MybatisEmbeddedAssociation) {
                    buildInnerToOneAssociationResultMap(builder, inverse);
                    return;
                }
                if (ass instanceof MybatisManyToOneAssociation) {
                    buildInnerToOneAssociationResultMap(builder, inverse);
                    return;
                }

                if (ass instanceof MybatisOneToManyAssociation) {
                    buildInnerToManyAssociationResultMap(builder, inverse);
                    return;
                }

            }
        });

        builder.append("</resultMap>");
    }


    private String alias(String column) {
        return column;
    }

    private String quota(String alias) {
        return dialect.openQuote() + alias + dialect.closeQuote();
    }

    /**
     * is ResultMap exists.
     *
     * @param name no need namespace.
     */
    public boolean isResultMapExist(String name) {
        if (null == configuration) {
            return false;
        }
        return configuration.hasResultMap(domainClass.getName() + "." + name);
    }

    /**
     * Is Fragment exists.
     */
    public boolean isFragmentExist(String fragment) {
        if (null == configuration) {
            return false;
        }
        return configuration.getSqlFragments().containsKey(domainClass.getName() + "." + fragment);
    }

    /**
     * is statement exists.
     */
    public boolean isStatementExist(String id) {
        if (null == configuration) {
            return false;
        }
        return configuration.hasStatement(domainClass.getName() + "." + id);
    }
}
