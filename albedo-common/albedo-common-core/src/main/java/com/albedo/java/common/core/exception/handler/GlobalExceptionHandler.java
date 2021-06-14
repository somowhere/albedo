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

package com.albedo.java.common.core.exception.handler;

import cn.hutool.core.exceptions.ExceptionUtil;
import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.exception.BadRequestException;
import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.exception.EntityNotFoundException;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.BeanValidators;
import com.albedo.java.common.core.util.ResponseEntityBuilder;
import com.albedo.java.common.core.util.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.List;

import static org.springframework.http.HttpStatus.BAD_REQUEST;
import static org.springframework.http.HttpStatus.NOT_FOUND;

/**
 * @author somewhere
 * @date 2019/2/1 全局的的异常处理器
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

	/**
	 * 全局异常.
	 *
	 * @param e the e
	 * @return R
	 */
	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public Result exception(Exception e) {
		log.error("全局异常信息 ex={}", e);
		return Result.buildFail(e.getMessage());
	}

	/**
	 * validation Exception
	 *
	 * @param exception
	 * @return R
	 */
	@ExceptionHandler({AccessDeniedException.class})
	@ResponseStatus(HttpStatus.FORBIDDEN)
	public Result bodyValidExceptionHandler(AccessDeniedException exception) {
		log.warn("AccessDeniedException:{}", exception);
		return Result.buildFail("权限不足");
	}

	/**
	 * validation Exception
	 *
	 * @param exception
	 * @return R
	 */
	@ExceptionHandler({MethodArgumentNotValidException.class, BindException.class})
	@ResponseStatus(BAD_REQUEST)
	public Result bodyValidExceptionHandler(MethodArgumentNotValidException exception) {
		List<String> messages = BeanValidators.extractPropertyAndMessageAsList(exception);
		log.warn("Valid Error:" + messages);
		return Result.buildFail(ArrayUtil.toArray(messages, String.class));
	}

	/**
	 * RuntimeMsgException
	 *
	 * @param exception
	 * @return R
	 */
	@ExceptionHandler({RuntimeMsgException.class})
	public Result bodyRuntimeMsgExceptionHandler(RuntimeMsgException exception) {
		log.error("runtime msg={}", exception.getMessage(), exception);
		return Result.buildFail(exception.getMessage());
	}

	/**
	 * 处理 badException
	 */
	@ExceptionHandler(value = {BadRequestException.class, EntityExistException.class, IllegalArgumentException.class})
	public ResponseEntity<Result> badException(Exception e) {
		// 打印堆栈信息
		log.error(ExceptionUtil.stacktraceToString(e));
		return ResponseEntityBuilder.buildFail(BAD_REQUEST, e.getMessage());
	}

	/**
	 * 处理 EntityNotFound
	 */
	@ExceptionHandler(value = EntityNotFoundException.class)
	public ResponseEntity<Result> entityNotFoundException(EntityNotFoundException e) {
		// 打印堆栈信息
		log.error(ExceptionUtil.stacktraceToString(e));
		return ResponseEntityBuilder.buildFail(NOT_FOUND, e.getMessage());
	}

}
