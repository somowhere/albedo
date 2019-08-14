package com.albedo.java.common.config.apidoc.customizer;

import springfox.documentation.spring.web.plugins.Docket;

@FunctionalInterface
public interface SwaggerCustomizer {
	void customize(Docket var1);
}
