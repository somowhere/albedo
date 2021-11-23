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

package com.albedo.java.common.core.util;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.code.ResponseCode;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

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
	/**
	 * 调用是否成功标识，1：成功，0:失败，此时请开发者稍候再试 详情见[ExceptionCode]
	 */
	@ApiModelProperty(value = "响应编码:0/200-请求处理成功")
	private int code = CommonConstants.SUCCESS;

	@Getter
	@Setter
	private T data;
	/**
	 * 结果消息，如果调用成功，消息通常为空T
	 */
	@ApiModelProperty(value = "提示消息")
	@Getter
	@Setter
	private String message;

	@ApiModelProperty(value = "请求路径")
	@Getter
	@Setter
	private String path;
	/**
	 * 附加数据
	 */
	@ApiModelProperty(value = "附加数据")
	@Getter
	@Setter
	private Map<Object, Object> extra;

	/**
	 * 响应时间
	 */
	@ApiModelProperty(value = "响应时间戳")
	@Getter
	private long timestamp = System.currentTimeMillis();

	/**
	 * 系统报错时，抛出的原生信息
	 */
	@ApiModelProperty(value = "异常消息")
	@Getter
	@Setter
	private String errorMsg = "";

	public Result() {
		super();
	}

	public Result(T data) {
		super();
		this.data = data;
	}

	public Result(String message) {
		super();
		this.message = message;
	}

	public Result(T data, String message) {
		super();
		this.data = data;
		this.message = message;
	}

	public Result(T data, int code, String message) {
		super();
		this.data = data;
		this.code = code;
		this.message = message;
	}

	public Result(T data, int code, String message, String errorMsg) {
		super();
		this.data = data;
		this.code = code;
		this.message = message;
		this.errorMsg = errorMsg;
	}


	public Result(Throwable e) {
		super();
		setMessage(e.getMessage());
		this.code = ResponseCode.FAIL.getCode();
	}

	public static Result buildOk(String... messages) {
		return new Result(StringUtil.toAppendStr(messages));
	}

	public static Result buildByFlag(boolean flag) {
		return new Result(flag, flag ? CommonConstants.SUCCESS : ResponseCode.FAIL.getCode(), flag ? "操作成功" : "系统繁忙，请稍候再试");
	}

	public static <T> Result buildOkData(T data, String message) {
		return new Result(data, message);
	}

	public static <T> Result buildOkData(T data) {
		return new Result(data);
	}

	public static <T> Result buildFailData(T data, String message) {
		return new Result(data, ResponseCode.FAIL.getCode(), message);
	}

	public static <T> Result buildFail(String message) {
		return new Result(null, ResponseCode.FAIL.getCode(), message);
	}

	public static <T> Result build(T data, int code, String message) {
		return new Result(data, code, message);
	}

	public static <T> Result build(int code, String message) {
		return new Result(null, code, message);
	}

	public static <T> Result build(int code, String message, String errorMsg) {
		return new Result(null, code, message, errorMsg);
	}


	public static <T> Result timeout() {
		return build(ResponseCode.SYSTEM_TIMEOUT);
	}

	public static Result build(ResponseCode responseCode) {
		return build(responseCode.getCode(), responseCode.getMessage());
	}

	public static Result build(ResponseCode responseCode, String errorMsg) {
		return build(responseCode.getCode(), responseCode.getMessage(), errorMsg);
	}

	public Result<T> putExtra(String key, Object value) {
		if (this.extra == null) {
			this.extra = new HashMap<>(16);
		}
		this.extra.put(key, value);
		return this;
	}

	public Result<T> putAllExtra(Map<Object, Object> extra) {
		if (this.extra == null) {
			this.extra = new HashMap<>(16);
		}
		this.extra.putAll(extra);
		return this;
	}

}
