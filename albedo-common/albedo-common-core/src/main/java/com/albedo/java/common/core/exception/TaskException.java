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

package com.albedo.java.common.core.exception;

import com.albedo.java.common.core.exception.code.ResponseCode;

/**
 * 计划策略异常
 *
 * @author somewhere
 */
public class TaskException extends BaseUncheckedException {

	private static final long serialVersionUID = 1L;

	private Code code;

	public TaskException(String msg, Code code) {
		this(msg, code, null);
	}

	public TaskException(String msg, Code code, Exception nestedEx) {
		super(ResponseCode.FAIL.getCode(), msg, nestedEx);
		this.code = code;
	}

	public Code getCode() {
		return code;
	}

	@Override
	public String toString() {
		return "TaskException [message=" + getMessage() + ", errorCode=" + getErrorCode() + "]";
	}

	public enum Code {

		/**
		 * TASK_EXISTS
		 */
		TASK_EXISTS,
		/**
		 * NO_TASK_EXISTS
		 */
		NO_TASK_EXISTS,
		/**
		 * TASK_ALREADY_STARTED
		 */
		TASK_ALREADY_STARTED,
		/**
		 * UNKNOWN
		 */
		UNKNOWN,
		/**
		 * CONFIG_ERROR
		 */
		CONFIG_ERROR,
		/**
		 * TASK_NODE_NOT_AVAILABLE
		 */
		TASK_NODE_NOT_AVAILABLE

	}

}
