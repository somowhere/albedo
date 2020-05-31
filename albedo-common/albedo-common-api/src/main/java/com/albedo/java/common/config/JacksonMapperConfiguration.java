package com.albedo.java.common.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

/**
* @Description:
* @Author: somewhere
* @Date: 2020/5/30 11:25 下午
*/
@Configuration
public class JacksonMapperConfiguration {

	@Bean
	public ObjectMapper myObjectMapper(Jackson2ObjectMapperBuilder builder) {
		return builder.createXmlMapper(false).modules(new CustomFieldModule()).build();
	}

}
