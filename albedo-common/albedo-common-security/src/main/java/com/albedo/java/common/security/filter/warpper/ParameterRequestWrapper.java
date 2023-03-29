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

package com.albedo.java.common.security.filter.warpper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.util.Enumeration;
import java.util.Map;
import java.util.Vector;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:09
 */
public class ParameterRequestWrapper extends HttpServletRequestWrapper {

	/**
	 * 定义参数集合
	 */
	private Map<String, String> params;

	/**
	 * 需要一个request和 篡改之后的参数进行实例化
	 */
	public ParameterRequestWrapper(HttpServletRequest request, Map<String, String> params) {
		super(request);
		this.params = params;
	}

	/**
	 * 查找自定的Map进行返回
	 *
	 * @param name
	 * @return
	 */
	@Override
	public String getParameter(String name) {
		Object v = params.get(name);
		if (v == null) {
			return null;
			// 一个name可能对应多个value， 返回第一个
		} else if (v instanceof String[]) {
			String[] strArr = (String[]) v;
			if (strArr.length > 0) {
				return strArr[0];
			} else {
				return null;
			}
		} else if (v instanceof String) {
			return (String) v;
		} else {
			return v.toString();
		}
	}

	@Override
	public Map getParameterMap() {
		return params;
	}

	@Override
	public Enumeration getParameterNames() {
		return new Vector(params.keySet()).elements();
	}

	@Override
	public String[] getParameterValues(String name) {
		Object v = params.get(name);
		if (v == null) {
			return null;
		} else if (v instanceof String[]) {
			return (String[]) v;
		} else if (v instanceof String) {
			return new String[]{(String) v};
		} else {
			return new String[]{v.toString()};
		}
	}

}
