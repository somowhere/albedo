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

package com.albedo.java.common.core.jackson;

import com.albedo.java.common.core.converter.EnumSerializer;
import com.albedo.java.common.core.enumeration.BaseEnum;
import com.albedo.java.common.core.jackson.databind.LocalDateTimeDeserializer;
import com.albedo.java.common.core.jackson.databind.LocalDateTimeSerializer;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.time.LocalDateTime;

/**
 * java 8 时间默认序列化
 *
 * @author somewhere
 * @author lishanbu
 */

public class CustomModule extends SimpleModule {

	public CustomModule() {
		this.addSerializer(LocalDateTime.class, LocalDateTimeSerializer.INSTANCE);
		this.addDeserializer(LocalDateTime.class, LocalDateTimeDeserializer.INSTANCE);
		this.addSerializer(BigInteger.class, ToStringSerializer.instance);
		this.addSerializer(BigDecimal.class, ToStringSerializer.instance);
		this.addSerializer(Long.class, ToStringSerializer.instance);
		this.addSerializer(BaseEnum.class, EnumSerializer.INSTANCE);
	}

}
