package com.albedo.java.plugins.cache.utils;

import com.albedo.java.common.core.jackson.JacksonUtil;
import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.jsontype.impl.LaissezFaireSubTypeValidator;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;

/**
 * 此时定义的序列化操作表示可以序列化所有类的对象，当然，这个对象所在的类一定要实现序列化接口
 *
 * @author somewhere
 * @date 2019-08-06 10:42
 */
public class RedisJacksonSerializer extends Jackson2JsonRedisSerializer<Object> {
	public RedisJacksonSerializer() {
		super(Object.class);

		ObjectMapper objectMapper = JacksonUtil.newInstance();
		objectMapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
		objectMapper.activateDefaultTyping(LaissezFaireSubTypeValidator.instance,
			ObjectMapper.DefaultTyping.NON_FINAL,
			JsonTypeInfo.As.WRAPPER_ARRAY);

		this.setObjectMapper(objectMapper);
	}

}
