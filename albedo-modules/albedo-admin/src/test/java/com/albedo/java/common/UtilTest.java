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

package com.albedo.java.common;


import cn.hutool.core.util.EscapeUtil;
import cn.hutool.http.HtmlUtil;
import com.albedo.java.common.core.util.Json;
import com.albedo.java.common.core.util.StringUtil;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

public class UtilTest {
	public static void main(String[] args) throws UnsupportedEncodingException {
		String rs = "Webhook \u7684 payload POST \u65f6\u5fc5\u987b\u662f JSON \u5b57\u7b26\u4e32";
		System.out.println(EscapeUtil.unescapeHtml4(rs));
		System.out.println(HtmlUtil.escape("测试"));
		String s = "%5B%7B%22format%22:%22%22,%22fieldName%22:%22a.username%22,%22attrType%22:%22String%22,%22fieldNode%22:%22%22,%22operate%22:%22like%22,%22weight%22:0,%22value%22:%22%E5%86%9C%E4%BF%A1%22,%22endValue%22:%22%22%7D%5D";
		System.out.println(EscapeUtil.unescape(s));
		System.out.println(URLDecoder.decode(s, "utf-8"));
		System.out.println(Json.toJSONString("utf-8".split(StringUtil.SPLIT_DEFAULT)));
	}
}
