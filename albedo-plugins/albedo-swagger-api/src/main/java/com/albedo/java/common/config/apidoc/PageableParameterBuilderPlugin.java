package com.albedo.java.common.config.apidoc;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fasterxml.classmate.ResolvedType;
import com.fasterxml.classmate.TypeResolver;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import springfox.documentation.builders.ParameterBuilder;
import springfox.documentation.schema.ModelReference;
import springfox.documentation.schema.TypeNameExtractor;
import springfox.documentation.service.Parameter;
import springfox.documentation.service.ResolvedMethodParameter;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.schema.contexts.ModelContext;
import springfox.documentation.spi.service.OperationBuilderPlugin;
import springfox.documentation.spi.service.contexts.OperationContext;
import springfox.documentation.spi.service.contexts.ParameterContext;

import java.util.List;
import java.util.function.Function;

import static springfox.documentation.schema.ResolvedTypes.modelRefFactory;
import static springfox.documentation.spi.schema.contexts.ModelContext.inputParam;

public class PageableParameterBuilderPlugin implements OperationBuilderPlugin {

	private final TypeNameExtractor nameExtractor;
	private final TypeResolver resolver;
	private final ResolvedType pageableType;

	@Autowired
	public PageableParameterBuilderPlugin(TypeNameExtractor nameExtractor, TypeResolver resolver) {
		this.nameExtractor = nameExtractor;
		this.resolver = resolver;
		this.pageableType = resolver.resolve(Page.class);
	}

	@Override
	public boolean supports(DocumentationType delimiter) {
		return DocumentationType.SWAGGER_2.equals(delimiter);
	}

	protected Function<ResolvedType, ? extends ModelReference> createModelRefFactory(ParameterContext context) {
		ModelContext modelContext = inputParam(
			context.getGroupName(),
			context.resolvedMethodParameter().getParameterType(),
			context.getDocumentationType(),
			context.getAlternateTypeProvider(),
			context.getGenericNamingStrategy(),
			context.getIgnorableParameterTypes());
		return (Function<ResolvedType, ? extends ModelReference>) modelRefFactory(modelContext, nameExtractor);
	}

	TypeResolver getResolver() {
		return resolver;
	}

	TypeNameExtractor getNameExtractor() {
		return nameExtractor;
	}


	@Override
	public void apply(OperationContext context) {
		for (ResolvedMethodParameter methodParameter : context.getParameters()) {
			ResolvedType resolvedType = methodParameter.getParameterType();
			if (pageableType.equals(resolvedType)) {
				ParameterContext parameterContext = new ParameterContext(methodParameter,
					new ParameterBuilder(),
					context.getDocumentationContext(),
					context.getGenericsNamingStrategy(),
					context);

				ModelReference intModel = createModelRefFactory(parameterContext).apply(resolver.resolve(Integer.TYPE));
				ModelReference stringModel = createModelRefFactory(parameterContext).apply(resolver.resolve(List.class, String.class));

				List<Parameter> parameters = Lists.newArrayList(
					new ParameterBuilder()
						.parameterType("query").name("current").modelRef(intModel)
						.description("Page number of the requested page")
						.build(),
					new ParameterBuilder()
						.parameterType("query").name("size").modelRef(intModel)
						.description("Size of a page")
						.build(),
					new ParameterBuilder()
						.parameterType("query").name("descs").modelRef(stringModel).allowMultiple(true)
						.description("Sorting criteria in the format: property(,asc|desc). Default sort order is ascending. Multiple sort criteria are supported.")
						.build(),
					new ParameterBuilder()
						.parameterType("query").name("ascs").modelRef(stringModel).allowMultiple(true)
						.description("Sorting criteria in the format: property(,asc|desc). Default sort order is ascending. Multiple sort criteria are supported.")
						.build(),
					new ParameterBuilder()
						.parameterType("query").name("queryConditionJson").modelRef(stringModel).allowMultiple(true)
						.description("search json [{\"fieldName\":\"name\",\"attrType\":\"String\",\"fieldNode\":\"\",\"operate\":\"like\",\"weight\":0,\"value\":\"g\"},{\"fieldName\":\"status\",\"attrType\":\"Integer\",\"fieldNode\":\"\",\"operate\":\"in\",\"weight\":0,\"value\":\"-1\"}]}")
						.build());

				context.operationBuilder().parameters(parameters);
			}
		}
	}

}
