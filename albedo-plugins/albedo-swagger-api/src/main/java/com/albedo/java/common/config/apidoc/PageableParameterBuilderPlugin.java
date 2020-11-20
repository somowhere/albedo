package com.albedo.java.common.config.apidoc;

import com.albedo.java.common.core.vo.PageModel;
import com.fasterxml.classmate.ResolvedType;
import com.fasterxml.classmate.TypeResolver;
import com.google.common.base.Function;
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

import static com.google.common.collect.Lists.newArrayList;
import static springfox.documentation.schema.ResolvedTypes.modelRefFactory;
import static springfox.documentation.spi.schema.contexts.ModelContext.inputParam;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:09
 */
public class PageableParameterBuilderPlugin implements OperationBuilderPlugin {

	/**
	 * Constant <code>DEFAULT_PAGE_NAME="page"</code>
	 */
	public static final String DEFAULT_PAGE_NAME = "current";
	/**
	 * Constant <code>PAGE_TYPE="query"</code>
	 */
	public static final String PAGE_TYPE = "query";
	/**
	 * Constant <code>PAGE_DESCRIPTION="Page number of the requested page"</code>
	 */
	public static final String PAGE_DESCRIPTION = "Page number of the requested page";

	/**
	 * Constant <code>DEFAULT_SIZE_NAME="size"</code>
	 */
	public static final String DEFAULT_SIZE_NAME = "size";
	/**
	 * Constant <code>SIZE_TYPE="query"</code>
	 */
	public static final String SIZE_TYPE = "query";
	/**
	 * Constant <code>SIZE_DESCRIPTION="Size of a page"</code>
	 */
	public static final String SIZE_DESCRIPTION = "Size of a page";

	/**
	 * Constant <code>DEFAULT_SORT_NAME="sort"</code>
	 */
	public static final String DEFAULT_SORT_NAME = "sorts";
	/**
	 * Constant <code>SORT_TYPE="query"</code>
	 */
	public static final String SORT_TYPE = "query";
	/**
	 * Constant <code>SORT_DESCRIPTION="Sorting criteria in the format: propert"{trunked}</code>
	 */
	public static final String SORT_DESCRIPTION = "Sorting criteria in the format: property(,asc|desc). "
		+ "Default sort order is ascending. ";

	private final TypeNameExtractor nameExtractor;
	private final TypeResolver resolver;
	private final ResolvedType pageModelType;

	/**
	 * <p>Constructor for PageableParameterBuilderPlugin.</p>
	 *
	 * @param nameExtractor a {@link springfox.documentation.schema.TypeNameExtractor} object.
	 * @param resolver      a {@link com.fasterxml.classmate.TypeResolver} object.
	 */
	public PageableParameterBuilderPlugin(TypeNameExtractor nameExtractor, TypeResolver resolver) {
		this.nameExtractor = nameExtractor;
		this.resolver = resolver;
		this.pageModelType = resolver.resolve(PageModel.class);
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public boolean supports(DocumentationType delimiter) {
		return DocumentationType.SWAGGER_2.equals(delimiter);
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public void apply(OperationContext context) {
		List<Parameter> parameters = newArrayList();
		for (ResolvedMethodParameter methodParameter : context.getParameters()) {
			ResolvedType resolvedType = methodParameter.getParameterType();
			if (this.pageModelType.equals(resolvedType)) {
				ParameterContext parameterContext = new ParameterContext(methodParameter,
					new ParameterBuilder(),
					context.getDocumentationContext(),
					context.getGenericsNamingStrategy(),
					context);

				parameters.add(createPageParameter(parameterContext));
				parameters.add(createSizeParameter(parameterContext));
				parameters.add(createSortParameter(parameterContext));

				context.operationBuilder().parameters(parameters);
			}
		}
	}

	/**
	 * Page name may be varied.
	 *
	 * @return The page parameter name
	 */
	protected String getPageName() {
		return DEFAULT_PAGE_NAME;
	}

	/**
	 * Size name may be varied.
	 *
	 * @return The size parameter name
	 */
	protected String getSizeName() {
		return DEFAULT_SIZE_NAME;
	}

	/**
	 * Sort name may be varied.
	 *
	 * @return The sort parameter name
	 */
	protected String getSortName() {
		return DEFAULT_SORT_NAME;
	}

	/**
	 * Create a page parameter.
	 * Override it if needed. Set a default value for example.
	 *
	 * @param context {@link com.baomidou.mybatisplus.core.metadata.IPage} parameter context
	 * @return The page parameter
	 */
	protected Parameter createPageParameter(ParameterContext context) {
		ModelReference intModel = createModelRefFactory(context).apply(resolver.resolve(Integer.TYPE));
		return new ParameterBuilder()
			.name(getPageName())
			.parameterType(PAGE_TYPE)
			.modelRef(intModel)
			.description(PAGE_DESCRIPTION)
			.build();
	}

	/**
	 * Create a size parameter.
	 * Override it if needed. Set a default value for example.
	 *
	 * @param context {@link com.baomidou.mybatisplus.core.metadata.IPage} parameter context
	 * @return The size parameter
	 */
	protected Parameter createSizeParameter(ParameterContext context) {
		ModelReference intModel = createModelRefFactory(context).apply(resolver.resolve(Integer.TYPE));
		return new ParameterBuilder()
			.name(getSizeName())
			.parameterType(SIZE_TYPE)
			.modelRef(intModel)
			.description(SIZE_DESCRIPTION)
			.build();
	}

	/**
	 * Create a sort parameter.
	 * Override it if needed. Set a default value or further description for example.
	 *
	 * @param context {@link com.baomidou.mybatisplus.core.metadata.IPage} parameter context
	 * @return The sort parameter
	 */
	protected Parameter createSortParameter(ParameterContext context) {
		ModelReference stringModel = createModelRefFactory(context).apply(resolver.resolve(List.class, String.class));
		return new ParameterBuilder()
			.name(getSortName())
			.parameterType(SORT_TYPE)
			.modelRef(stringModel)
			.allowMultiple(true)
			.description(SORT_DESCRIPTION)
			.build();
	}

	/**
	 * <p>createModelRefFactory.</p>
	 *
	 * @param context a {@link springfox.documentation.spi.service.contexts.ParameterContext} object.
	 * @return a {@link java.util.function.Function} object.
	 */
	protected Function<ResolvedType, ? extends ModelReference> createModelRefFactory(ParameterContext context) {
		ModelContext modelContext = inputParam(
			context.getGroupName(),
			context.resolvedMethodParameter().getParameterType(),
			context.getDocumentationType(),
			context.getAlternateTypeProvider(),
			context.getGenericNamingStrategy(),
			context.getIgnorableParameterTypes());
		return modelRefFactory(modelContext, nameExtractor);
	}

	TypeResolver getResolver() {
		return resolver;
	}

	TypeNameExtractor getNameExtractor() {
		return nameExtractor;
	}

}
