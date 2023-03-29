/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.config;

import com.fasterxml.jackson.databind.BeanDescription;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.Module;
import com.fasterxml.jackson.databind.SerializationConfig;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.BeanSerializerModifier;
import com.fasterxml.jackson.databind.ser.std.BeanSerializerBase;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:07
 */
public class CustomFieldModule extends SimpleModule {

	@Override
	public void setupModule(Module.SetupContext context) {
		super.setupModule(context);
		context.addBeanSerializerModifier(new BeanSerializerModifier() {

			@Override
			public JsonSerializer<?> modifySerializer(SerializationConfig config, BeanDescription beanDesc,
													  JsonSerializer<?> serializer) {
				if (serializer instanceof BeanSerializerBase) {
					return new ExtraFieldSerializer((BeanSerializerBase) serializer);
				}
				return serializer;

			}
		});

	}

}
