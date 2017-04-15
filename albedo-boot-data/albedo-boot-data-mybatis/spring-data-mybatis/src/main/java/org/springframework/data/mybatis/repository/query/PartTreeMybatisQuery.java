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

package org.springframework.data.mybatis.repository.query;

import org.apache.ibatis.builder.xml.XMLMapperBuilder;
import org.apache.ibatis.session.Configuration;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.mapping.Association;
import org.springframework.data.mapping.PropertyPath;
import org.springframework.data.mapping.model.MappingException;
import org.springframework.data.mybatis.mapping.*;
import org.springframework.data.mybatis.repository.dialect.Dialect;
import org.springframework.data.mybatis.repository.query.MybatisQueryExecution.DeleteExecution;
import org.springframework.data.mybatis.repository.support.MybatisMapperGenerator;
import org.springframework.data.mybatis.repository.support.MybatisQueryException;
import org.springframework.data.mybatis.repository.util.StringUtils;
import org.springframework.data.repository.core.EntityMetadata;
import org.springframework.data.repository.query.parser.Part;
import org.springframework.data.repository.query.parser.Part.IgnoreCaseType;
import org.springframework.data.repository.query.parser.PartTree;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.UUID;

import static org.springframework.data.repository.query.parser.Part.IgnoreCaseType.ALWAYS;
import static org.springframework.data.repository.query.parser.Part.IgnoreCaseType.WHEN_POSSIBLE;

/**
 * part tree query implementation of {@link org.springframework.data.repository.query.RepositoryQuery}.
 *
 * @author Jarvis Song
 */
public class PartTreeMybatisQuery extends AbstractMybatisQuery {
    private transient static final Logger logger = LoggerFactory.getLogger(PartTreeMybatisQuery.class);

    private static final String MAPPER_BEGIN = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
            "<!DOCTYPE mapper PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\" \"http://mybatis.org/dtd/mybatis-3-mapper.dtd\">";
    private static final String MAPPER_END   = "</mapper>";

    private final Dialect                    dialect;
    private final EntityMetadata             entityInformation;
    private final Class<?>                   domainClass;
    private final PartTree                   tree;
    private final MybatisParameters          parameters;
    private final MybatisMappingContext      context;
    private final MybatisMapperGenerator     generator;
    private final MybatisPersistentEntity<?> persistentEntity;

    private final String statementName;

    protected PartTreeMybatisQuery(
            MybatisMappingContext context,
            SqlSessionTemplate sqlSessionTemplate, Dialect dialect, MybatisQueryMethod method) {
        super(sqlSessionTemplate, method);
        this.context = context;
        this.dialect = dialect;
        this.entityInformation = method.getEntityInformation();
        this.domainClass = this.entityInformation.getJavaType();
        this.tree = new PartTree(method.getName(), domainClass);
        this.parameters = method.getParameters();
        this.persistentEntity = context.getPersistentEntity(domainClass);
        this.generator = new MybatisMapperGenerator(dialect, persistentEntity);
        this.statementName = super.getStatementName() + UUID.randomUUID().toString().replace("-", "");

        doCreateQueryStatement(method); // prepare mybatis statement.
    }

    private String quota(String alias) {
        return dialect.openQuote() + alias + dialect.closeQuote();
    }

    @Override
    protected MybatisQueryExecution getExecution() {
        if (tree.isDelete()) {
            return new DeleteExecution();
        }
        return super.getExecution();
    }

    @Override
    protected String getStatementName() {
        return statementName;
    }

    private String buildQueryCondition(boolean basic) {

        StringBuilder builder = new StringBuilder();
        builder.append("<trim prefix=\" where \" prefixOverrides=\"and |or \">");
        int c = 0;
        for (Iterator<PartTree.OrPart> iterator = tree.iterator(); iterator.hasNext(); ) {
            PartTree.OrPart orPart = iterator.next();
            builder.append(" or (");
            builder.append("<trim prefix=\"\" prefixOverrides=\"and |or \">");

            for (Iterator<Part> it = orPart.iterator(); it.hasNext(); ) {
                String columnName = null;
                Part part = it.next();
                MybatisPersistentProperty property = persistentEntity.getPersistentProperty(part.getProperty().getSegment());
                if (null == property) {
                    throw new MybatisQueryException("can not find property: " + part.getProperty().getSegment() + " from entity: " + persistentEntity.getName());
                }
                if (!property.isEntity()) {
                    columnName = quota(persistentEntity.getEntityName()) + "." + dialect.wrapColumnName(property.getColumnName());
                } else if (!basic) {
                    if (property.isAssociation()) {
                        Association<MybatisPersistentProperty> ass = property.getAssociation();
                        if (ass instanceof MybatisManyToOneAssociation) {
                            MybatisManyToOneAssociation association = (MybatisManyToOneAssociation) ass;

                            MybatisPersistentEntity<?> obversePersistentEntity = association.getObversePersistentEntity();
                            if (null == obversePersistentEntity) {
                                throw new MybatisQueryException("can not find obverse persistent entity.");
                            }

                            PropertyPath leaf = part.getProperty().getLeafProperty();

                            if (obversePersistentEntity.getType() == leaf.getType()) {

                                //columnName = quota(persistentEntity.getEntityName() + "." + part.getProperty().getSegment()) + "." + dialect.wrapColumnName(obversePersistentEntity.getIdProperty().getColumnName());
                                throw new UnsupportedOperationException("findBy{Association Model} Style is not support now.");

                            } else {
                                MybatisPersistentProperty leafProperty = obversePersistentEntity.getPersistentProperty(leaf.getSegment());
                                if (null == leafProperty) {
                                    throw new MybatisQueryException("can not find property: " + leaf.getSegment() + " from entity: " + obversePersistentEntity.getName());
                                }
                                columnName = quota(persistentEntity.getEntityName() + "." + part.getProperty().getSegment()) + "." + dialect.wrapColumnName(leafProperty.getColumnName());
                            }
                        } else if (ass instanceof MybatisEmbeddedAssociation) {
                            columnName = quota(persistentEntity.getEntityName()) + "." + dialect.wrapColumnName(ass.getObverse().getColumnName());
                        }
                    }
                }

                if (null == columnName) {
                    throw new MybatisQueryException("can not find property: " + part.getProperty().getSegment() + " in " + method.getName());
                }

                builder.append(" and ");

                IgnoreCaseType ignoreCaseType = part.shouldIgnoreCase();
                if (ignoreCaseType == ALWAYS || ignoreCaseType == WHEN_POSSIBLE) {
                    builder.append("upper(").append(columnName).append(")");
                } else {
                    builder.append(columnName);
                }

                builder.append(generator.buildConditionOperate(part.getType()));
                String[] properties = new String[part.getType().getNumberOfArguments()];
                for (int i = 0; i < properties.length; i++) {
                    properties[i] = resolveParameterName(c++);
                }
                builder.append(generator.buildConditionCaluse(part.getType(), ignoreCaseType, properties));
            }

            builder.append("</trim>");

            builder.append(" )");

        }
        builder.append("</trim>");
        return builder.toString();
    }

    private String resolveParameterName(int position) {
        String paramName = null;
        if (parameters.hasParameterAt(position)) {
            paramName = parameters.getParameter(position).getName();
        }
        return StringUtils.isNotEmpty(paramName) ? paramName : "p" + position;
    }

    private String doCreateDeleteQueryStatement() {
        StringBuilder builder = new StringBuilder();
        builder.append("<delete id=\"" + getStatementName() + "\" lang=\"XML\">");
        builder.append("delete");
        if (dialect.supportsDeleteAlias()) {
            builder.append(" ").append(quota(persistentEntity.getEntityName()));
        }
        builder.append(" from ").append(generator.buildFrom(isBasicQuery())).append(" ");
        builder.append(buildQueryCondition(isBasicQuery()));
        builder.append("</delete>");

        if (method.isCollectionQuery()) {
            // query first, then delete
            builder.append(doCreateSelectQueryStatement("query_" + getStatementName()));
        }

        return builder.toString();
    }


    private String doCreateCountQueryStatement(String statementName) {
        StringBuilder builder = new StringBuilder();
        builder.append("<select id=\"" + statementName + "\" lang=\"XML\" resultType=\"long\">");
        builder.append("select count(*) from ");
        builder.append(generator.buildFrom(isBasicQuery()));
        builder.append(buildQueryCondition(isBasicQuery()));
        builder.append("</select>");
        return builder.toString();
    }


    private String doCreatePageQueryStatement(boolean includeCount) {
        Class<?> returnedObjectType = method.getReturnedObjectType();
        if (returnedObjectType != domainClass && !returnedObjectType.isAssignableFrom(domainClass)) {
            throw new IllegalArgumentException("return object type must be or assignable from " + domainClass);
        }
        StringBuilder builder = new StringBuilder();
        StringBuilder condition = new StringBuilder();
        condition.append(buildQueryCondition(isBasicQuery()));
        builder.append("<select id=\"" + statementName + "\" lang=\"XML\" resultMap=\"ResultMap\">");
        builder.append(dialect.getLimitHandler().processSql(true, generator.buildSelectColumns(isBasicQuery()), " from " + generator.buildFrom(isBasicQuery()), condition.toString(), generator.buildSorts(isBasicQuery(), tree.getSort())));
        builder.append("</select>");

        if (includeCount) {
            builder.append(doCreateCountQueryStatement("count_" + getStatementName()));
        }

        return builder.toString();
    }

    private String doCreateSelectQueryStatement(String statementName) {
        StringBuilder builder = new StringBuilder();
        builder.append("<select id=\"" + statementName + "\" lang=\"XML\" resultMap=\"ResultMap\">");
        builder.append("select ");

        if (tree.isDistinct()) {
            builder.append(" distinct ");
        }

        builder.append(generator.buildSelectColumns(isBasicQuery()));
        builder.append(" from ");
        builder.append(generator.buildFrom(isBasicQuery()));
        // build condition
        builder.append(buildQueryCondition(isBasicQuery()));

        builder.append(generator.buildSorts(isBasicQuery(), tree.getSort()));

        builder.append("</select>");
        return builder.toString();
    }

    private String doCreateCollectionQueryStatement() {
        Class<?> returnedObjectType = method.getReturnedObjectType();

        if (returnedObjectType != domainClass && !returnedObjectType.isAssignableFrom(domainClass)) {
            throw new IllegalArgumentException("return object type must be or assignable from " + domainClass);
        }

        return doCreateSelectQueryStatement(getStatementName());
    }


    private void doCreateQueryStatement(MybatisQueryMethod method) {

        Configuration configuration = sqlSessionTemplate.getConfiguration();

        String statementXML = "";
        if (tree.isDelete()) {
            statementXML = doCreateDeleteQueryStatement();
        } else if (tree.isCountProjection()) {
            statementXML = doCreateCountQueryStatement(getStatementName());
        } else if (method.isPageQuery()) {
            statementXML = doCreatePageQueryStatement(true);
        } else if (method.isSliceQuery()) {
            statementXML = doCreatePageQueryStatement(false);
        } else if (method.isStreamQuery()) {
        } else if (method.isCollectionQuery()) {
            statementXML = doCreateCollectionQueryStatement();
        } else if (method.isQueryForEntity()) {
            statementXML = doCreateSelectQueryStatement(getStatementName());
        }


        StringBuilder builder = new StringBuilder();
        builder.append(MAPPER_BEGIN);
        builder.append("<mapper namespace=\"" + getNamespace() + "\">");
        builder.append(statementXML);
        builder.append(MAPPER_END);


        String xml = builder.toString();

        if (logger.isDebugEnabled()) {
            logger.debug("\n******************* Auto Generate MyBatis Mapping XML (" + getStatementId() + ") *******************\n" + xml);
        }
        InputStream inputStream = null;
        try {
            inputStream = new ByteArrayInputStream(xml.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            // ignore
        }
        String namespace = getNamespace();
        String resource = getStatementId() + "_auto_generate.xml";
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


}
