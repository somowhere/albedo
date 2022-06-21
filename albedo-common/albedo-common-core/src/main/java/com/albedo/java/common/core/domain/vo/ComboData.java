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

package com.albedo.java.common.core.domain.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:07
 */
@Data
public class ComboData implements Serializable {

	public static final String F_LABEL = "label";

	public static final String F_VALUE = "value";

	public static final String F_PID = "pId";

	private static final long serialVersionUID = 1L;

	private String value;

	private String label;

	private String pId;

	public ComboData() {
	}

	public ComboData(String value, String label) {
		this.value = value;
		this.label = label;
	}

	public ComboData(String value, String label, String pId) {
		this.value = value;
		this.label = label;
		this.pId = pId;
	}

}
