/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
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

package com.albedo.java.modules;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.convert.Convert;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.util.URLUtil;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.hamcrest.Description;
import org.hamcrest.TypeSafeDiagnosingMatcher;
import org.springframework.format.datetime.standard.DateTimeFormatterRegistrar;
import org.springframework.format.support.DefaultFormattingConversionService;
import org.springframework.format.support.FormattingConversionService;
import org.springframework.http.MediaType;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.time.ZonedDateTime;
import java.time.format.DateTimeParseException;
import java.util.Collection;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Utility class for testing REST controllers.
 */
public final class TestUtil {

	public static final String ADMIN_PATH = "application.admin-path";

	public static final String USER_ADMIN = "sys";

	public static final String USER_ADMIN_PASSWORD = "111111";

	/**
	 * MediaType for JSON UTF8
	 */
	public static final MediaType APPLICATION_JSON_UTF8 = new MediaType(MediaType.APPLICATION_JSON.getType(),
		MediaType.APPLICATION_JSON.getSubtype(), StandardCharsets.UTF_8);

	private static final ObjectMapper mapper = createObjectMapper();

	private TestUtil() {
	}

	public static ObjectMapper createObjectMapper() {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(SerializationFeature.WRITE_DURATIONS_AS_TIMESTAMPS, false);
		mapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);
		mapper.registerModule(new JavaTimeModule());
		return mapper;
	}

	/**
	 * Convert an object to JSON byte array.
	 *
	 * @param object the object to convert.
	 * @return the JSON byte array.
	 * @throws IOException
	 */
	public static byte[] convertObjectToJsonBytes(Object object) throws IOException {

		return mapper.writeValueAsBytes(object);
	}

	/**
	 * Convert an object to userParams
	 *
	 * @param object the object to convert.
	 * @return the JSON byte array.
	 * @throws IOException
	 */
	public static String convertObjectToUrlParams(Object object) throws IOException {
		String s = mapper.writeValueAsString(object);
		return toParams(mapper.readValue(s, Map.class));
	}

	public static String toParams(Map<String, ?> paramMap) {
		if (MapUtil.isEmpty(paramMap)) {
			return StrUtil.EMPTY;
		}
		Charset charset = CharsetUtil.CHARSET_UTF_8;

		final StringBuilder sb = new StringBuilder();
		boolean isFirst = true, isFristTwo = true;
		String key;
		Object value;
		for (Map.Entry<String, ?> item : paramMap.entrySet()) {
			if (isFirst) {
				isFirst = false;
			} else {
				sb.append("&");
			}
			key = item.getKey();
			if (StrUtil.isNotEmpty(key)) {
				value = item.getValue();
				if (value instanceof Collection) {
					for (Object obj : (Collection) value) {
						if (isFristTwo) {
							isFristTwo = false;
						} else {
							sb.append("&");
						}
						appendUrl(sb, obj, key, charset);
					}
				} else {
					appendUrl(sb, value, key, charset);
				}

			}
		}
		return sb.toString();
	}

	private static void appendUrl(StringBuilder sb, Object value, String key, Charset charset) {
		String valueStr = Convert.toStr(value);
		sb.append(URLUtil.encodeAll(key, charset)).append("=");
		if (StrUtil.isNotEmpty(valueStr)) {
			sb.append(URLUtil.encodeAll(valueStr, charset));
		}
	}

	/**
	 * Create a byte array with a specific size filled with specified data.
	 *
	 * @param size the size of the byte array.
	 * @param data the data to put in the byte array.
	 * @return the JSON byte array.
	 */
	public static byte[] createByteArray(int size, String data) {
		byte[] byteArray = new byte[size];
		for (int i = 0; i < size; i++) {
			byteArray[i] = Byte.parseByte(data, 2);
		}
		return byteArray;
	}

	/**
	 * Creates a matcher that matches when the examined string represents the same instant
	 * as the reference datetime.
	 *
	 * @param date the reference datetime against which the examined string is checked.
	 */
	public static ZonedDateTimeMatcher sameInstant(ZonedDateTime date) {
		return new ZonedDateTimeMatcher(date);
	}

	/**
	 * Verifies the equals/hashcode contract on the domain object.
	 */
	public static <T> void equalsVerifier(Class<T> clazz) throws Exception {
		T domainObject1 = clazz.getConstructor().newInstance();
		assertThat(domainObject1.toString()).isNotNull();
		assertThat(domainObject1).isEqualTo(domainObject1);
		assertThat(domainObject1.hashCode()).isEqualTo(domainObject1.hashCode());
		// Test with an instance of another class
		Object testOtherObject = new Object();
		assertThat(domainObject1).isNotEqualTo(testOtherObject);
		assertThat(domainObject1).isNotEqualTo(null);
		// Test with an instance of the same class
		T domainObject2 = clazz.getConstructor().newInstance();
		assertThat(domainObject1).isNotEqualTo(domainObject2);
		// HashCodes are equals because the objects are not persisted yet
		assertThat(domainObject1.hashCode()).isEqualTo(domainObject2.hashCode());
	}

	/**
	 * Create a {@link FormattingConversionService} which use ISO date format, instead of
	 * the localized one.
	 *
	 * @return the {@link FormattingConversionService}.
	 */
	public static FormattingConversionService createFormattingConversionService() {
		DefaultFormattingConversionService dfcs = new DefaultFormattingConversionService();
		DateTimeFormatterRegistrar registrar = new DateTimeFormatterRegistrar();
		registrar.setUseIsoFormat(true);
		registrar.registerFormatters(dfcs);
		return dfcs;
	}

	/**
	 * A matcher that tests that the examined string represents the same instant as the
	 * reference datetime.
	 */
	public static class ZonedDateTimeMatcher extends TypeSafeDiagnosingMatcher<String> {

		private final ZonedDateTime date;

		public ZonedDateTimeMatcher(ZonedDateTime date) {
			this.date = date;
		}

		@Override
		protected boolean matchesSafely(String item, Description mismatchDescription) {
			try {
				if (!date.isEqual(ZonedDateTime.parse(item))) {
					mismatchDescription.appendText("was ").appendValue(item);
					return false;
				}
				return true;
			} catch (DateTimeParseException e) {
				mismatchDescription.appendText("was ").appendValue(item)
					.appendText(", which could not be parsed as a ZonedDateTime");
				return false;
			}

		}

		@Override
		public void describeTo(Description description) {
			description.appendText("a String representing the same Instant as ").appendValue(date);
		}

	}

}
