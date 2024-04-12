package com.albedo.java.common.core.jackson;

import cn.hutool.core.date.DatePattern;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.exception.code.ResponseCode;
import com.albedo.java.common.core.util.MapHelper;
import com.albedo.java.common.core.util.StrPool;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.json.JsonReadFeature;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author somewhere
 */
@Slf4j
public class JacksonUtil {
	private JacksonUtil() {
	}

	public static <T> String toJson(T value) {
		try {
			return getInstance().writeValueAsString(value);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return null;
	}

	public static byte[] toJsonAsBytes(Object object) {
		try {
			return getInstance().writeValueAsBytes(object);
		} catch (JsonProcessingException e) {
			throw new BizException(ResponseCode.JSON_PARSE_ERROR.getCode(), e);
		}
	}

	public static <T> T parse(String content, Class<T> valueType) {
		try {
			return getInstance().readValue(content, valueType);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return null;
	}

	public static <T> T parse(String content, TypeReference<T> typeReference) {
		try {
			return getInstance().readValue(content, typeReference);
		} catch (IOException e) {
			throw new BizException(ResponseCode.JSON_PARSE_ERROR.getCode(), e);
		}
	}

	public static <T> T parse(byte[] bytes, Class<T> valueType) {
		try {
			return getInstance().readValue(bytes, valueType);
		} catch (IOException e) {
			throw new BizException(ResponseCode.JSON_PARSE_ERROR.getCode(), e);
		}
	}

	public static <T> T parse(byte[] bytes, TypeReference<T> typeReference) {
		try {
			return getInstance().readValue(bytes, typeReference);
		} catch (IOException e) {
			throw new BizException(ResponseCode.JSON_PARSE_ERROR.getCode(), e);
		}
	}

	public static <T> T parse(InputStream in, Class<T> valueType) {
		try {
			return getInstance().readValue(in, valueType);
		} catch (IOException e) {
			throw new BizException(ResponseCode.JSON_PARSE_ERROR.getCode(), e);
		}
	}

	public static <T> T parse(InputStream in, TypeReference<T> typeReference) {
		try {
			return getInstance().readValue(in, typeReference);
		} catch (IOException e) {
			throw new BizException(ResponseCode.JSON_PARSE_ERROR.getCode(), e);
		}
	}

	public static <T> List<T> parseArray(String content, Class<T> valueTypeRef) {
		try {
			if (!StrUtil.startWith(content, StrPool.LEFT_SQ_BRACKET)) {
				content = StrPool.LEFT_SQ_BRACKET + content + StrPool.RIGHT_SQ_BRACKET;
			}

			List<Map<String, Object>> list = getInstance().readValue(content, new TypeReference<List<Map<String, Object>>>() {
			});

			return list.stream().map((map) -> toPojo(map, valueTypeRef)).collect(Collectors.toList());
		} catch (IOException e) {
			log.error(e.getMessage(), e);
		}
		return null;
	}

	public static Map<String, Object> toMap(String content) {
		try {
			return getInstance().readValue(content, Map.class);
		} catch (IOException e) {
			log.error(e.getMessage(), e);
		}
		return null;
	}

	public static <T> Map<String, T> toMap(String content, Class<T> valueTypeRef) {
		try {
			Map<String, Map<String, Object>> map = getInstance().readValue(content, new TypeReference<Map<String, Map<String, Object>>>() {
			});
			Map<String, T> result = new HashMap<>(MapHelper.initialCapacity(map.size()));
			map.forEach((key, value) -> result.put(key, toPojo(value, valueTypeRef)));

			return result;
		} catch (IOException e) {
			log.error(e.getMessage(), e);
		}
		return null;
	}

	public static <T> T toPojo(Map fromValue, Class<T> toValueType) {
		return getInstance().convertValue(fromValue, toValueType);
	}


	public static <T> T toPojo(JsonNode resultNode, Class<T> toValueType) {
		return getInstance().convertValue(resultNode, toValueType);
	}

	public static JsonNode readTree(String jsonString) {
		try {
			return getInstance().readTree(jsonString);
		} catch (IOException e) {
			throw new BizException(ResponseCode.JSON_PARSE_ERROR.getCode(), e);
		}
	}

	public static JsonNode readTree(InputStream in) {
		try {
			return getInstance().readTree(in);
		} catch (IOException e) {
			throw new BizException(ResponseCode.JSON_PARSE_ERROR.getCode(), e);
		}
	}

	public static JsonNode readTree(byte[] content) {
		try {
			return getInstance().readTree(content);
		} catch (IOException e) {
			throw new BizException(ResponseCode.JSON_PARSE_ERROR.getCode(), e);
		}
	}

	public static JsonNode readTree(JsonParser jsonParser) {
		try {
			return getInstance().readTree(jsonParser);
		} catch (IOException e) {
			throw new BizException(ResponseCode.JSON_PARSE_ERROR.getCode(), e);
		}
	}

	public static ObjectMapper getInstance() {
		return JacksonHolder.INSTANCE;
	}

	public static ObjectMapper newInstance() {
		return new JacksonObjectMapper();
	}

	private static class JacksonHolder {
		private static final ObjectMapper INSTANCE = new JacksonObjectMapper();
	}

	public static class JacksonObjectMapper extends ObjectMapper {
		private static final long serialVersionUID = 1L;

		public JacksonObjectMapper() {
			super();
			// 参考BaseConfig
			super.setLocale(Locale.CHINA)
				.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false)
				.setTimeZone(TimeZone.getTimeZone(ZoneId.systemDefault()))
				.setDateFormat(new SimpleDateFormat(DatePattern.NORM_DATETIME_PATTERN, Locale.CHINA))
				.configure(JsonReadFeature.ALLOW_UNESCAPED_CONTROL_CHARS.mappedFeature(), true)
				.configure(JsonReadFeature.ALLOW_BACKSLASH_ESCAPING_ANY_CHARACTER.mappedFeature(), true)
				.findAndRegisterModules()
				.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false)
				.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
				.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true)
				.getDeserializationConfig().withoutFeatures(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
			super.registerModule(new CustomModule());
			super.findAndRegisterModules();
		}
	}
}
