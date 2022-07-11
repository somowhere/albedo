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
//import com.albedo.java.common.core.vo.PageModel;
//import com.albedo.java.plugins.swagger.config.ApplicationSwaggerProperties;
//import com.google.common.collect.Lists;
//import org.springframework.core.Ordered;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.ResponseEntity;
//import springfox.documentation.builders.PathSelectors;
//import springfox.documentation.service.*;
//import springfox.documentation.spi.service.contexts.SecurityContext;
//import springfox.documentation.spring.web.plugins.Docket;
//
//import java.nio.ByteBuffer;
//import java.util.ArrayList;
//import java.util.Arrays;
//import java.util.HashSet;
//import java.util.List;
//
///**
// * @author somewhere
// * @description
// * @date 2020/5/31 17:06
// */
//public class AlbedoSwaggerCustomizer implements SwaggerCustomizer, Ordered {
//
//	public static final int DEFAULT_ORDER = 0;
//
//	private final ApplicationSwaggerProperties applicationSwaggerProperties;
//
//	private int order = 0;
//
//	public AlbedoSwaggerCustomizer(ApplicationSwaggerProperties applicationSwaggerProperties) {
//		this.applicationSwaggerProperties = applicationSwaggerProperties;
//	}
//
//	@Override
//	public void customize(Docket docket) {
//		Contact contact = new Contact(this.applicationSwaggerProperties.getContactName(),
//			this.applicationSwaggerProperties.getContactUrl(), this.applicationSwaggerProperties.getContactEmail());
//		ApiInfo apiInfo = new ApiInfo(this.applicationSwaggerProperties.getTitle(),
//			this.applicationSwaggerProperties.getDescription(), this.applicationSwaggerProperties.getVersion(),
//			this.applicationSwaggerProperties.getTermsOfServiceUrl(), contact,
//			this.applicationSwaggerProperties.getLicense(), this.applicationSwaggerProperties.getLicenseUrl(),
//			new ArrayList());
//		docket.host(this.applicationSwaggerProperties.getHost())
//			.protocols(new HashSet(Arrays.asList(this.applicationSwaggerProperties.getProtocols())))
//			.apiInfo(apiInfo)
//			.useDefaultResponseMessages(this.applicationSwaggerProperties.isUseDefaultResponseMessages())
//			.securitySchemes(securitySchemes()).securityContexts(securityContexts()).forCodeGeneration(true)
//			.directModelSubstitute(ByteBuffer.class, String.class).genericModelSubstitutes(ResponseEntity.class)
//			.ignoredParameterTypes(PageModel.class).select()
//			.paths(PathSelectors.regex(this.applicationSwaggerProperties.getDefaultIncludePattern())).build();
//	}
//
//	@Override
//	public int getOrder() {
//		return this.order;
//	}
//
//	public void setOrder(int order) {
//		this.order = order;
//	}
//
//	// /**
//	// * 这个类决定了你使用哪种认证方式，我这里使用密码模式
//	// * 其他方式自己摸索一下，完全莫问题啊
//	// */
//	// private SecurityScheme securityOauthScheme() {
//	// GrantType grantType = new ResourceOwnerPasswordCredentialsGrant(
//	// applicationSwaggerProperties.getOauthServer());
//	//
//	// return new OAuthBuilder()
//	// .name("spring_oauth")
//	// .grantTypes(Collections.singletonList(grantType))
//	// .scopes(Arrays.asList(scopes()))
//	// .build();
//	// }
//
//	// /**
//	// * 这里设置 swagger2 认证的安全上下文
//	// */
//	// private SecurityContext securityOauthContext() {
//	// return SecurityContext.builder()
//	// .securityReferences(Collections.singletonList(new SecurityReference("spring_oauth",
//	// scopes())))
//	// .forPaths(PathSelectors.any())
//	// .build();
//	// }
//
//	/**
//	 * 这里是写允许认证的scope
//	 */
//	private AuthorizationScope[] scopes() {
//		return new AuthorizationScope[]{new AuthorizationScope("all", "All scope is trusted!")};
//	}
//
//	private List<SecurityScheme> securitySchemes() {
//		return Lists.newArrayList(
//			// securityOauthScheme(),
//			new ApiKey(HttpHeaders.AUTHORIZATION, HttpHeaders.AUTHORIZATION, "header"));
//	}
//
//	private List<SecurityContext> securityContexts() {
//		return Lists.newArrayList(
//			// securityOauthContext(),
//			SecurityContext.builder().securityReferences(defaultAuth()).build());
//	}
//
//	List<SecurityReference> defaultAuth() {
//		AuthorizationScope authorizationScope = new AuthorizationScope("global", "accessEverything");
//		AuthorizationScope[] authorizationScopes = new AuthorizationScope[1];
//		authorizationScopes[0] = authorizationScope;
//		return Lists.newArrayList(new SecurityReference("Authorization", authorizationScopes));
//	}
//
//}
