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

import cn.hutool.core.util.ArrayUtil;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * @author somewhere
 * @date 2017/3/2
 */
public class ResponseEntityBuilder {

	public static ResponseEntity<Result> buildOk(String... messages) {
		return new ResponseEntity(Result.buildOk(messages), HttpStatus.OK);
	}

	public static ResponseEntity<Result> buildOk(Object data, String... messages) {
		return new ResponseEntity(Result.buildOkData(data, messages), HttpStatus.OK);
	}

	public static ResponseEntity<Result> buildFail(String... messages) {
		return buildFail(null, messages);
	}

	public static ResponseEntity<Result> buildFail(Object data, HttpStatus httpStatus, String... messages) {
		if (ArrayUtil.isEmpty(messages)) {
			messages = new String[]{"failed"};
		}
		Result warn = Result.buildFailData(data, messages);
		return new ResponseEntity(warn, httpStatus != null ? httpStatus : HttpStatus.OK);

	}

	public static ResponseEntity<Result> buildFail(HttpStatus httpStatus, String... messages) {

		return buildFail(null, httpStatus, messages);
	}

	public static ResponseEntity<Result> buildFailData(Object data, String... messages) {

		return buildFail(data, HttpStatus.OK, messages);
	}

	public static ResponseEntity<Result> buildOkData(Object data) {
		String[] msg;
		if (data instanceof BindingResult) {
			List<String> errorsList = new ArrayList();
			BindingResult bindingResult = (BindingResult) data;
			errorsList.addAll(bindingResult.getAllErrors().stream()
				.map(DefaultMessageSourceResolvable::getDefaultMessage).collect(Collectors.toList()));
			data = null;
			msg = new String[errorsList.size()];
			msg = errorsList.toArray(msg);
		} else {
			msg = new String[0];
		}
		return buildOk(data, msg);
	}

	public static ResponseEntity<Result> buildObject(Object data) {
		return new ResponseEntity(data, HttpStatus.OK);
	}

	public static <X> ResponseEntity<X> wrapOrNotFound(Optional<X> maybeResponse) {
		return wrapOrNotFound(maybeResponse, null);
	}

	public static <X> ResponseEntity<X> wrapOrNotFound(Optional<X> maybeResponse, HttpHeaders header) {
		return (ResponseEntity) maybeResponse
			.map((response) -> ResponseEntity.ok().headers(header).body(Result.buildOkData(response)))
			.orElse(new ResponseEntity(HttpStatus.NOT_FOUND));
	}

}
