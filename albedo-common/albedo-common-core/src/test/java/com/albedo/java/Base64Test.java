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

package com.albedo.java;

import cn.hutool.core.codec.Base64;
import org.junit.jupiter.api.Test;

import java.nio.charset.StandardCharsets;

public class Base64Test {


	@Test
	/**
	 * YWxiZWRvOmFsYmVkbw==
	 */
	public void encode() {


		System.out.println(Base64.encode("albedo:albedo"));

	}

	/**
	 * c3dhZ2dlcjpzd2FnZ2Vy
	 *
	 * @throws Exception
	 */
	@Test
	public void decode() throws Exception {
		String encode = Base64.encode("swagger:swagger");
		System.out.println(encode);
		byte[] base64Token = encode.getBytes(StandardCharsets.UTF_8);
		byte[] decoded = Base64.decode(base64Token);
		String token = new String(decoded, StandardCharsets.UTF_8);
		System.out.println(token);

	}
}
