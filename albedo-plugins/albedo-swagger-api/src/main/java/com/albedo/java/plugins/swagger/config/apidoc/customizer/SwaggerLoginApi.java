///*
// *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
// *  <p>
// *  you may not use this file except in compliance with the License.
// *  You may obtain a copy of the License at
// *  <p>
// * https://www.gnu.org/licenses/lgpl.html
// *  <p>
// * Unless required by applicable law or agreed to in writing, software
// * distributed under the License is distributed on an "AS IS" BASIS,
// * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// * See the License for the specific language governing permissions and
// * limitations under the License.
// */
//
//package com.albedo.java.plugins.swagger.config.apidoc.customizer;
//
//import com.albedo.java.common.core.util.StringUtil;
//import com.albedo.java.plugins.swagger.config.ApplicationSwaggerProperties;
//import com.google.common.collect.Sets;
//import org.springframework.http.HttpMethod;
//import org.springframework.http.MediaType;
//import springfox.documentation.builders.OperationBuilder;
//import springfox.documentation.builders.RequestParameterBuilder;
//import springfox.documentation.builders.ResponseBuilder;
//import springfox.documentation.schema.ScalarType;
//import springfox.documentation.service.ApiDescription;
//import springfox.documentation.service.Operation;
//import springfox.documentation.service.ParameterType;
//import springfox.documentation.service.Response;
//import springfox.documentation.spi.DocumentationType;
//import springfox.documentation.spi.service.ApiListingScannerPlugin;
//import springfox.documentation.spi.service.contexts.DocumentationContext;
//import springfox.documentation.spring.web.readers.operation.CachingOperationNameGenerator;
//
//import java.util.Arrays;
//import java.util.Collection;
//import java.util.Collections;
//import java.util.List;
//
///**
// * @author somewhere
// */
//public class SwaggerLoginApi implements ApiListingScannerPlugin {
//
//	private final ApplicationSwaggerProperties applicationSwaggerProperties;
//
//	public SwaggerLoginApi(ApplicationSwaggerProperties applicationSwaggerProperties) {
//		this.applicationSwaggerProperties = applicationSwaggerProperties;
//	}
//
//	@Override
//	public boolean supports(DocumentationType documentationType) {
//		return DocumentationType.SWAGGER_2.equals(documentationType);
//	}
//
//	/**
//	 * @return Set of response messages that overide the default/global response messages
//	 */
//	private Collection<Response> responses() { // <8b>
//		return Collections.singleton(
//			new ResponseBuilder().code("200").description("登录成功").representation(MediaType.APPLICATION_JSON)
//				.apply(r -> r.model(m -> m.name("Result").scalarModel(ScalarType.STRING)).build())
//				// .apply(r -> r.model(m -> m.referenceModel( rmb -> rmb.key(mkb
//				// -> mkb.qualifiedModelName(qmb ->
//				// qmb.namespace(PackageNames.safeGetPackageName(Result.class))
//				// .name(Result.class.getSimpleName())).isResponse(true)))
//				// .build()))
//				.build());
//	}
//
//	@Override
//	public List<ApiDescription> apply(DocumentationContext context) {
//		String path = StringUtil.isNotEmpty(applicationSwaggerProperties.getDefaultIncludePattern())
//			? applicationSwaggerProperties.getDefaultIncludePattern().replace(".*", "authenticate")
//			: "/authenticate";
//		Operation usernamePasswordOperation = new OperationBuilder(new CachingOperationNameGenerator())
//			.method(HttpMethod.POST).uniqueId("authenticate").summary("用户名密码登录").notes("username/password登录")
//			// 接收参数格式
//			.consumes(Sets.newHashSet(MediaType.APPLICATION_FORM_URLENCODED_VALUE))
//			// 返回参数格式
//			.produces(Sets.newHashSet(MediaType.APPLICATION_JSON_VALUE)).tags(
//				Sets.newHashSet("账户相关"))
//			.requestParameters(Arrays.asList(
//				new RequestParameterBuilder().description("用户名").in(ParameterType.QUERY).name("username")
//					.required(true)
//					.query(param -> param.model(model -> model.scalarModel(ScalarType.STRING))).build(),
//				new RequestParameterBuilder()
//					.description(
//						"密码(采用AES加密，默认key=somewhere-albedo[application.security.encode-key])(Mode.CBC)")
//					.in(ParameterType.QUERY).name("password").required(true)
//					.query(param -> param.model(model -> model.scalarModel(ScalarType.STRING))).build(),
//				new RequestParameterBuilder().description("唯一标识").in(ParameterType.QUERY).name("randomKey")
//					.required(true)
//					.query(param -> param.model(model -> model.scalarModel(ScalarType.STRING))).build(),
//				new RequestParameterBuilder().description("验证码").in(ParameterType.QUERY).name("code")
//					.required(true)
//					.query(param -> param.model(model -> model.scalarModel(ScalarType.STRING))).build(),
//				new RequestParameterBuilder().description("用户名").in(ParameterType.QUERY).name("username")
//					.required(true)
//					.query(param -> param.model(model -> model.scalarModel(ScalarType.STRING))).build()))
//			.responses(responses()).build();
//		ApiDescription loginApiDescription = new ApiDescription("login", path, "登录接口", "登录接口",
//			Arrays.asList(usernamePasswordOperation), false);
//		return Arrays.asList(loginApiDescription);
//	}
//
//}
