/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.plugins.swagger.config.apidoc;

import com.albedo.java.common.core.vo.PageModel;
import com.fasterxml.classmate.ResolvedType;
import com.fasterxml.classmate.TypeResolver;
import springfox.documentation.builders.RequestParameterBuilder;
import springfox.documentation.schema.ScalarType;
import springfox.documentation.schema.TypeNameExtractor;
import springfox.documentation.service.ParameterType;
import springfox.documentation.service.RequestParameter;
import springfox.documentation.service.ResolvedMethodParameter;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.OperationBuilderPlugin;
import springfox.documentation.spi.service.contexts.OperationContext;

import java.util.List;

import static com.google.common.collect.Lists.newArrayList;

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
	 * Constant <code>PAGE_DESCRIPTION="Page number of the requested page"</code>
	 */
	public static final String PAGE_DESCRIPTION = "Page number of the requested page";

	/**
	 * Constant <code>DEFAULT_SIZE_NAME="size"</code>
	 */
	public static final String DEFAULT_SIZE_NAME = "size";

	/**
	 * Constant <code>SIZE_DESCRIPTION="Size of a page"</code>
	 */
	public static final String SIZE_DESCRIPTION = "Size of a page";

	/**
	 * Constant <code>DEFAULT_SORT_NAME="sort"</code>
	 */
	public static final String DEFAULT_SORT_NAME = "sorts";

	/**
	 * Constant
	 * <code>SORT_DESCRIPTION="Sorting criteria in the format: propert"{trunked}</code>
	 */
	public static final String SORT_DESCRIPTION = "Sorting criteria in the format: property(,asc|desc). "
		+ "Default sort order is ascending. ";

	private final TypeNameExtractor nameExtractor;

	private final TypeResolver resolver;

	private final ResolvedType pageModelType;

	/**
	 * <p>
	 * Constructor for PageableParameterBuilderPlugin.
	 * </p>
	 *
	 * @param nameExtractor a {@link springfox.documentation.schema.TypeNameExtractor}
	 *                      object.
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
		List<RequestParameter> parameters = newArrayList();
		for (ResolvedMethodParameter methodParameter : context.getParameters()) {
			ResolvedType resolvedType = methodParameter.getParameterType();
			if (this.pageModelType.equals(resolvedType)) {

				parameters.add(createPageParameter());
				parameters.add(createSizeParameter());
				parameters.add(createSortParameter());

				context.operationBuilder().requestParameters(parameters);
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
	 * Create a page parameter. Override it if needed. Set a default value for example.
	 *
	 * @return The page parameter
	 */
	protected RequestParameter createPageParameter() {
		return new RequestParameterBuilder().description(PAGE_DESCRIPTION).in(ParameterType.QUERY).name(getPageName())
			.required(true).query(param -> param.model(model -> model.scalarModel(ScalarType.INTEGER))).build();
	}

	/**
	 * Create a size parameter. Override it if needed. Set a default value for example.
	 *
	 * @return The size parameter
	 */
	protected RequestParameter createSizeParameter() {
		return new RequestParameterBuilder().description(SIZE_DESCRIPTION).in(ParameterType.QUERY).name(getSizeName())
			.required(true).query(param -> param.model(model -> model.scalarModel(ScalarType.STRING))).build();
	}

	/**
	 * Create a sort parameter. Override it if needed. Set a default value or further
	 * description for example.
	 *
	 * @return The sort parameter
	 */
	protected RequestParameter createSortParameter() {
		return new RequestParameterBuilder().description(SORT_DESCRIPTION).in(ParameterType.QUERY).name(getSortName())
			.required(true).query(param -> param.model(model -> model.scalarModel(ScalarType.INTEGER))).build();
	}

}
