package com.albedo.java.common.config;

import com.albedo.java.common.config.locale.AngularCookieLocaleResolver;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.web.interceptor.OperateInterceptor;
import org.springframework.boot.bind.RelaxedPropertyResolver;
import org.springframework.context.EnvironmentAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.env.Environment;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;

import javax.inject.Inject;

@Configuration
public class LocaleConfiguration extends WebMvcConfigurerAdapter implements EnvironmentAware {

	@SuppressWarnings("unused")
	private RelaxedPropertyResolver propertyResolver;
	@Inject
	private AlbedoProperties albedoProperties;

	@Override
	public void setEnvironment(Environment environment) {
		this.propertyResolver = new RelaxedPropertyResolver(environment, "spring.messages.");
	}

	@Bean(name = "localeResolver")
	public LocaleResolver localeResolver() {
		AngularCookieLocaleResolver cookieLocaleResolver = new AngularCookieLocaleResolver();
		cookieLocaleResolver.setCookieName("NG_TRANSLATE_LANG_KEY");
		return cookieLocaleResolver;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
		localeChangeInterceptor.setParamName("language");
		registry.addInterceptor(localeChangeInterceptor);
		registry.addInterceptor(new OperateInterceptor(albedoProperties)).addPathPatterns("/**"); 
		
	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName(PublicUtil.isEmpty(albedoProperties.getDefaultView()) ? PublicUtil.toAppendStr("redirect:", albedoProperties.getAdminPath("/login")) : albedoProperties.getDefaultView());
		registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
		super.addViewControllers(registry);
	}

}
