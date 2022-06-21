/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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

package com.albedo.java.common;

import com.albedo.java.common.config.ExtraFieldSerializer;
import com.albedo.java.common.core.domain.vo.DataVo;
import com.fasterxml.jackson.databind.BeanDescription;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationConfig;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.BeanSerializerModifier;
import com.fasterxml.jackson.databind.ser.std.BeanSerializerBase;
import com.google.common.collect.Lists;
import lombok.Data;
import org.junit.jupiter.api.Test;

public class JacksonTest {

	@Test
	public void testAddExtraField() throws Exception {
		ObjectMapper mapper = new ObjectMapper();

		mapper.registerModule(new SimpleModule() {

			public void setupModule(SetupContext context) {
				super.setupModule(context);

				context.addBeanSerializerModifier(new BeanSerializerModifier() {

					public JsonSerializer<?> modifySerializer(SerializationConfig config, BeanDescription beanDesc,
															  JsonSerializer<?> serializer) {
						if (serializer instanceof BeanSerializerBase) {
							return new ExtraFieldSerializer((BeanSerializerBase) serializer);
						}
						return serializer;

					}
				});
			}
		});

		mapper.writeValue(System.out, Lists.newArrayList(new MyClass1(), new MyClass2()));
		// prints {"classField":"classFieldValue","extraField":"extraFieldValue"}
	}

	@Data
	class MyClass1 extends DataVo<String> {

		private String classField = "classFieldValue1";

		private Integer available = 1;

	}

	@Data
	class MyClass2 {

		private String classField = "classFieldValue2";

	}

}
