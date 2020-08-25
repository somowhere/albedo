package com.albedo.java.common.config.apidoc.customizer;

import com.albedo.java.common.config.ApplicationSwaggerProperties;
import com.albedo.java.common.core.util.StringUtil;
import com.fasterxml.classmate.TypeResolver;
import com.google.common.collect.Sets;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import springfox.documentation.builders.OperationBuilder;
import springfox.documentation.builders.ParameterBuilder;
import springfox.documentation.builders.ResponseMessageBuilder;
import springfox.documentation.schema.ModelRef;
import springfox.documentation.service.ApiDescription;
import springfox.documentation.service.Operation;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.ApiListingScannerPlugin;
import springfox.documentation.spi.service.contexts.DocumentationContext;
import springfox.documentation.spring.web.readers.operation.CachingOperationNameGenerator;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * @author somewhere
 */
public class SwaggerLoginApi implements ApiListingScannerPlugin {
	private final ApplicationSwaggerProperties applicationSwaggerProperties;

	public SwaggerLoginApi(ApplicationSwaggerProperties applicationSwaggerProperties) {
		this.applicationSwaggerProperties = applicationSwaggerProperties;
	}

	@Override
	public List<ApiDescription> apply(DocumentationContext documentationContext) {
		Operation usernamePasswordOperation = new OperationBuilder(new CachingOperationNameGenerator())
			.method(HttpMethod.POST)
			.summary("用户名密码登录")
			.notes("username/password登录")
			// 接收参数格式
			.consumes(Sets.newHashSet(MediaType.APPLICATION_FORM_URLENCODED_VALUE))
			// 返回参数格式
			.produces(Sets.newHashSet(MediaType.APPLICATION_JSON_VALUE))
			.tags(Sets.newHashSet("账户相关"))
			.parameters(Arrays.asList(
				new ParameterBuilder()
					.description("用户名")
					.type(new TypeResolver().resolve(String.class))
					.name("username")
					.defaultValue("admin")
					.parameterType("query")
					.parameterAccess("access")
					.required(true)
					.modelRef(new ModelRef("string"))
					.build(),
				new ParameterBuilder()
					.description("密码(采用AES加密，默认key=somewhere-albedo[application.security.encode-key])(Mode.CBC)")
					.type(new TypeResolver().resolve(String.class))
					.name("password")
					.parameterType("query")
					.parameterAccess("access")
					.required(true)
					.modelRef(new ModelRef("string"))
					.build(),
				new ParameterBuilder()
					.description("验证码唯一标识")
					.type(new TypeResolver().resolve(String.class))
					.name("randomKey")
					.defaultValue("666666")
					.parameterType("query")
					.parameterAccess("access")
					.required(true)
					.modelRef(new ModelRef("string"))
					.build(),
				new ParameterBuilder()
					.description("验证码")
					.type(new TypeResolver().resolve(String.class))
					.name("code")
					.parameterType("query")
					.parameterAccess("access")
					.required(true)
					.modelRef(new ModelRef("string"))
					.build()
			))
			.responseMessages(Collections.singleton(
				new ResponseMessageBuilder().code(200).message("请求成功")
					.responseModel(new ModelRef(
						"com.albedo.java.common.core.util.Result")
					).build()))
			.build();
		String path = StringUtil.isNotEmpty(applicationSwaggerProperties.getDefaultIncludePattern()) ? applicationSwaggerProperties.getDefaultIncludePattern().replace(".*", "authenticate") : "/authenticate";
		ApiDescription loginApiDescription = new ApiDescription("login", path, "登录接口",
			Arrays.asList(usernamePasswordOperation), false);

		return Arrays.asList(loginApiDescription);

	}

	@Override
	public boolean supports(DocumentationType documentationType) {
		return DocumentationType.SWAGGER_2.equals(documentationType);
	}
}
