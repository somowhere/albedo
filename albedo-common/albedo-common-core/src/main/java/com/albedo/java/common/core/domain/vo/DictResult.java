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

package com.albedo.java.common.core.domain.vo;

import lombok.Data;

/**
 * Copyright 2013 albedo All right reserved Author somewhere Created on 2013-10-23
 * 下午1:55:43
 *
 * @author somewhere
 */
@Data
public class DictResult {

	public static final String F_CODE = "code";

	public static final String F_NAME = "name";

	public static final String F_VAL = "val";

	/*** 名称 */
	private String name;

	/*** 编码 */
	private String code;

	/*** 字典值 */
	private String val;

	public DictResult() {
		super();
	}

	public DictResult(String name, String code, String val) {
		super();
		this.name = name;
		this.code = code;
		this.val = val;
	}

}
