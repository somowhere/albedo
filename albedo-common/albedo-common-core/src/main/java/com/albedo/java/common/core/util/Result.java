/*
 *  Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.core.util;

import com.albedo.java.common.core.constant.CommonConstants;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;
import org.springframework.util.ObjectUtils;

import java.io.Serializable;


/**
 * 响应信息主体
 *
 * @param <T>
 * @author somewhere
 */
@ToString
@Accessors(chain = true)
@AllArgsConstructor
public class Result<T> implements Serializable {
	private static final long serialVersionUID = 1L;

	@Getter
	@Setter
	private int code = CommonConstants.SUCCESS;

	@Getter
	@Setter
	private T data;


	private String[] messages = {};


	public Result() {
		super();
	}

	public Result(T data) {
		super();
		this.data = data;
	}

	public Result(String... msg) {
		super();
		this.messages = msg;
	}

	public Result(T data, String... msg) {
		super();
		this.data = data;
		this.messages = msg;
	}

	public Result(T data, int code, String... msg) {
		super();
		this.data = data;
		this.code = code;
		this.messages = msg;
	}

	public Result(Throwable e) {
		super();
		setMessage(e.getMessage());
		this.code = CommonConstants.FAIL;
	}

	public static Result buildOk(String... messages) {
		return new Result(messages);
	}

	public static Result buildByFlag(boolean flag) {
		return new Result(flag, flag ? CommonConstants.SUCCESS : CommonConstants.FAIL, flag ? "操作成功" : "操作失败");
	}

	public static <T> Result buildOkData(T data, String... messages) {
		return new Result(data, messages);
	}

	public static <T> Result buildFailData(T data, String... messages) {
		return new Result(data, CommonConstants.FAIL, messages);
	}

	public static <T> Result buildFail(String... messages) {
		return new Result(null, CommonConstants.FAIL, messages);
	}

	public static <T> Result build(T data, int code, String... messages) {
		return new Result(data, code, messages);
	}

	public static <T> Result build(int code, String... messages) {
		return new Result(null, code, messages);
	}

	public String getMessage() {
		return readMessages();
	}

	public void setMessage(String message) {
		addMessage(message);
	}

	public String readMessages() {
		StringBuilder sb = new StringBuilder();
		for (String message : messages) {
			sb.append(message);
		}
		return sb.toString();
	}

	public void addMessage(String message) {
		this.messages = ObjectUtils.addObjectToArray(messages, message);
	}

}
