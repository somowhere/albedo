package com.albedo.java.common.config.apidoc.customizer;

import springfox.documentation.spring.web.plugins.Docket;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:11
 */
@FunctionalInterface
public interface SwaggerCustomizer {
	/**
	 * customize
	 *
	 * @param var1
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	void customize(Docket var1);
}
