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
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.exception.EntityNotFoundException;
import com.albedo.java.common.core.exception.ForbiddenException;
import com.albedo.java.common.core.exception.code.ResponseCode;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.StrPool;
import com.albedo.java.common.core.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.exceptions.PersistenceException;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.support.MissingServletRequestPartException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.sql.SQLException;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import static org.springframework.http.HttpStatus.BAD_REQUEST;
import static org.springframework.http.HttpStatus.NOT_FOUND;

/**
 * @author somewhere
 * @date 2019/2/1 全局的的异常处理器
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

	private String getPath() {
		String path = StrPool.EMPTY;
		RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
		if (requestAttributes != null) {
			HttpServletRequest request = ((ServletRequestAttributes) requestAttributes).getRequest();
			path = request.getRequestURI();
		}
		return path;
	}

	private void setContentType(String contentType){
		if(StringUtil.isNotEmpty(contentType)){
			RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
			if (requestAttributes != null) {
				HttpServletResponse response = ((ServletRequestAttributes) requestAttributes).getResponse();
				if(response.getContentType() != contentType){
					response.setContentType(contentType);
				}
			}
		}
	}

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
		return Result.build(ResponseCode.SYSTEM_BUSY).setPath(getPath());
	}


	/**
	 * AccessDenied Exception
	 *
	 * @param exception
	 * @return R
	 */
	@ExceptionHandler({AccessDeniedException.class})
	@ResponseStatus(HttpStatus.UNAUTHORIZED)
	public Result bodyValidExceptionHandler(AccessDeniedException exception) {
		log.warn("AccessDeniedException:{}", exception);
		return Result.build(ResponseCode.UNAUTHORIZED.getCode(), "权限不足").setPath(getPath());
	}

	@ExceptionHandler(HttpMessageNotReadableException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result httpMessageNotReadableException(HttpMessageNotReadableException ex) {
		log.warn("HttpMessageNotReadableException:", ex);
		String exMessage = ex.getMessage();
		if (StrUtil.containsAny(exMessage, "Could not read document:")) {
			String message = String.format("无法正确的解析json类型的参数：%s", StrUtil.subBetween(exMessage, "Could not read document:", " at "));
			return Result.build(ResponseCode.PARAM_EX.getCode(), message, ex.getMessage()).setPath(getPath());
		}
		return Result.build(ResponseCode.PARAM_EX, ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(BindException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result bindException(BindException ex) {
		log.warn("BindException:", ex);
		try {
			String message = Objects.requireNonNull(ex.getBindingResult().getFieldError()).getDefaultMessage();
			if (StrUtil.isNotEmpty(message)) {
				return Result.build(ResponseCode.PARAM_EX.getCode(), message, ex.getMessage()).setPath(getPath());
			}
		} catch (Exception ee) {
			log.debug("获取异常描述失败", ee);
		}
		StringBuilder message = new StringBuilder();
		List<FieldError> fieldErrors = ex.getFieldErrors();
		fieldErrors.forEach((oe) ->
			message.append("参数:[").append(oe.getObjectName())
				.append(".").append(oe.getField())
				.append("]的传入值:[").append(oe.getRejectedValue()).append("]与预期的字段类型不匹配.")
		);
		return Result.build(ResponseCode.PARAM_EX.getCode(), message.toString(), ex.getMessage()).setPath(getPath());
	}


	@ExceptionHandler(MethodArgumentTypeMismatchException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result methodArgumentTypeMismatchException(MethodArgumentTypeMismatchException ex) {
		log.warn("MethodArgumentTypeMismatchException:", ex);
		String message = "参数：[" + ex.getName() + "]的传入值：[" + ex.getValue() +
			"]与预期的字段类型：[" + Objects.requireNonNull(ex.getRequiredType()).getName() + "]不匹配";
		return Result.build(ResponseCode.PARAM_EX.getCode(), message, ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(IllegalStateException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result illegalStateException(IllegalStateException ex) {
		log.warn("IllegalStateException:", ex);
		return Result.build(ResponseCode.ILLEGAL_ARGUMENT_EX, ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(MissingServletRequestParameterException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result missingServletRequestParameterException(MissingServletRequestParameterException ex) {
		log.warn("MissingServletRequestParameterException:", ex);
		return Result.build(ResponseCode.ILLEGAL_ARGUMENT_EX.getCode(), "缺少必须的[" + ex.getParameterType() + "]类型的参数[" + ex.getParameterName() + "]", ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(NullPointerException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result nullPointerException(NullPointerException ex) {
		log.warn("NullPointerException:", ex);
		return Result.build(ResponseCode.NULL_POINT_EX, ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(IllegalArgumentException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result illegalArgumentException(IllegalArgumentException ex) {
		log.warn("IllegalArgumentException:", ex);
		return Result.build(ResponseCode.ILLEGAL_ARGUMENT_EX, ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(HttpMediaTypeNotSupportedException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result httpMediaTypeNotSupportedException(HttpMediaTypeNotSupportedException ex) {
		log.warn("HttpMediaTypeNotSupportedException:", ex);
		MediaType contentType = ex.getContentType();
		if (contentType != null) {
			return Result.build(ResponseCode.MEDIA_TYPE_EX.getCode(), "请求类型(Content-Type)[" + contentType + "] 与实际接口的请求类型不匹配", ex.getMessage()).setPath(getPath());
		}
		return Result.build(ResponseCode.MEDIA_TYPE_EX.getCode(), "无效的Content-Type类型", ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(MissingServletRequestPartException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result missingServletRequestPartException(MissingServletRequestPartException ex) {
		log.warn("MissingServletRequestPartException:", ex);
		return Result.build(ResponseCode.REQUIRED_FILE_PARAM_EX, ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(ServletException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result servletException(ServletException ex) {
		log.warn("ServletException:", ex);
		String message = "UT010016: Not a multi part request";
		if (message.equalsIgnoreCase(ex.getMessage())) {
			return Result.build(ResponseCode.REQUIRED_FILE_PARAM_EX, ex.getMessage());
		}
		return Result.build(ResponseCode.SYSTEM_BUSY.getCode(), ex.getMessage(), ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(MultipartException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result multipartException(MultipartException ex) {
		log.warn("MultipartException:", ex);
		return Result.build(ResponseCode.REQUIRED_FILE_PARAM_EX, ex.getMessage()).setPath(getPath());
	}

	/**
	 * jsr 规范中的验证异常
	 */
	@ExceptionHandler(ConstraintViolationException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result constraintViolationException(ConstraintViolationException ex) {
		log.warn("ConstraintViolationException:", ex);
		Set<ConstraintViolation<?>> violations = ex.getConstraintViolations();
		String message = violations.stream().map(ConstraintViolation::getMessage).collect(Collectors.joining(";"));

		return Result.build(ResponseCode.BASE_VALID_PARAM.getCode(), message, ex.getMessage()).setPath(getPath());
	}

	/**
	 * spring 封装的参数验证异常， 在controller中没有写result参数时，会进入
	 */
	@ExceptionHandler(MethodArgumentNotValidException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result methodArgumentNotValidException(MethodArgumentNotValidException ex) {
		log.warn("MethodArgumentNotValidException:", ex);
		return Result.build(ResponseCode.BASE_VALID_PARAM.getCode(), Objects.requireNonNull(ex.getBindingResult().getFieldError()).getDefaultMessage(), ex.getMessage()).setPath(getPath());
	}

	/**
	 * BizException
	 *
	 * @param ex
	 * @return Result
	 */
	@ExceptionHandler({BizException.class})
	public Result bodyBizExceptionHandler(BizException ex) {
		setContentType("application/json; charset=utf-8");
		log.warn("BizException={}", ex.getMessage());
		return Result.build(ex.getErrorCode(), ex.getMessage()).setPath(getPath());
	}

	/**
	 * 处理 badException
	 *
	 * @return Result
	 */
	@ResponseStatus(BAD_REQUEST)
	@ExceptionHandler(value = {EntityExistException.class})
	public Result badException(EntityExistException ex) {
		// 打印堆栈信息
		log.error(ExceptionUtil.stacktraceToString(ex));
		return Result.build(ex.getErrorCode(), ex.getMessage()).setPath(getPath());
	}

	/**
	 * 处理 EntityNotFound
	 *
	 * @return Result
	 */
	@ResponseStatus(NOT_FOUND)
	@ExceptionHandler(value = EntityNotFoundException.class)
	public Result entityNotFoundException(EntityNotFoundException ex) {
		// 打印堆栈信息
		log.error(ExceptionUtil.stacktraceToString(ex));
		return Result.build(ex.getErrorCode(), ex.getMessage());
	}

	/**
	 * @param ex
	 * @return Result
	 */
	@ExceptionHandler(ForbiddenException.class)
	@ResponseStatus(HttpStatus.FORBIDDEN)
	public Result forbiddenException(ForbiddenException ex) {
		log.warn("ForbiddenException:", ex);
		return Result.build(ex.getErrorCode(), ex.getMessage(), ex.getLocalizedMessage()).setPath(getPath());
	}

	/**
	 * 返回状态码:405
	 */
	@ExceptionHandler({HttpRequestMethodNotSupportedException.class})
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result handleHttpRequestMethodNotSupportedException(HttpRequestMethodNotSupportedException ex) {
		log.warn("HttpRequestMethodNotSupportedException:", ex);
		return Result.build(ResponseCode.METHOD_NOT_ALLOWED, ex.getMessage()).setPath(getPath());
	}


	@ExceptionHandler(PersistenceException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result persistenceException(PersistenceException ex) {
		log.warn("PersistenceException:", ex);
		if (ex.getCause() instanceof BizException) {
			BizException cause = (BizException) ex.getCause();
			return Result.build(cause.getErrorCode(), cause.getMessage());
		}
		return Result.build(ResponseCode.SQL_EX, ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(MyBatisSystemException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result myBatisSystemException(MyBatisSystemException ex) {
		log.warn("PersistenceException:", ex);
		if (ex.getCause() instanceof PersistenceException) {
			return this.persistenceException((PersistenceException) ex.getCause());
		}
		return Result.build(ResponseCode.SQL_EX, ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(SQLException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result sqlException(SQLException ex) {
		log.warn("SQLException:", ex);
		return Result.build(ResponseCode.SQL_EX, ex.getMessage()).setPath(getPath());
	}

	@ExceptionHandler(DataIntegrityViolationException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result dataIntegrityViolationException(DataIntegrityViolationException ex) {
		log.warn("DataIntegrityViolationException:", ex);
		return Result.build(ResponseCode.SQL_EX, ex.getMessage()).setPath(getPath());
	}
}
