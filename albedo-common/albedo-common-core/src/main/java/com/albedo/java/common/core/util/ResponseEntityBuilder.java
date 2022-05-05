/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.core.util;

import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author somewhere
 * @date 2017/3/2
 */
public class ResponseEntityBuilder {

	public static ResponseEntity<Result> buildOk(String message) {
		return new ResponseEntity(Result.buildOk(message), HttpStatus.OK);
	}

	public static ResponseEntity<Result> buildOk(Object data, String message) {
		return new ResponseEntity(Result.buildOkData(data, message), HttpStatus.OK);
	}

	public static ResponseEntity<Result> buildFail(String message) {
		return buildFail(null, message);
	}

	public static ResponseEntity<Result> buildFail(Object data, HttpStatus httpStatus, String message) {
		Result warn = Result.buildFailData(data, message);
		return new ResponseEntity(warn, httpStatus != null ? httpStatus : HttpStatus.OK);

	}

	public static ResponseEntity<Result> buildFail(HttpStatus httpStatus, String message) {

		return buildFail(null, httpStatus, message);
	}

	public static ResponseEntity<Result> buildFailData(Object data, String message) {

		return buildFail(data, HttpStatus.OK, message);
	}

	public static ResponseEntity<Result> buildOkData(Object data) {
		String msg = null;
		if (data instanceof BindingResult) {
			List<String> errorsList = new ArrayList();
			BindingResult bindingResult = (BindingResult) data;
			errorsList.addAll(bindingResult.getAllErrors().stream()
				.map(DefaultMessageSourceResolvable::getDefaultMessage).collect(Collectors.toList()));
			data = null;
			msg = CollUtil.convertToString(errorsList, StrPool.COMMA);
		}
		return buildOk(data, msg);
	}

	public static ResponseEntity<Result> buildObject(Object data) {
		return new ResponseEntity(data, HttpStatus.OK);
	}


}
