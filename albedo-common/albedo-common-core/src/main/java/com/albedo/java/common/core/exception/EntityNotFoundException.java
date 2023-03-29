/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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
import org.springframework.util.StringUtils;

/**
 * @author somewhere
 * @date 2018-11-23
 */
public class EntityNotFoundException extends BaseUncheckedException {

	public EntityNotFoundException(Class clazz, String field, String val) {
		super(ResponseCode.ILLEGAL_ARGUMENT_EX.getCode(), EntityNotFoundException.generateMessage(clazz.getSimpleName(), field, val));
	}

	private static String generateMessage(String entity, String field, String val) {
		return StringUtils.capitalize(entity) + " with " + field + " " + val + " does not exist";
	}

	@Override
	public String toString() {
		return "EntityNotFoundException [message=" + getMessage() + ", errorCode=" + getErrorCode() + "]";
	}
}
