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

package com.albedo.java.common.log.aspect;

import cn.hutool.core.map.MapUtil;
import cn.hutool.json.JSONUtil;
import com.albedo.java.common.core.util.BeanUtil;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.WebUtil;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.core.MethodParameter;
import org.springframework.core.io.InputStreamSource;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * @program: albedo-cloud
 * @description:
 * @author: somewhere
 * @create: 2020-09-20 15:04
 **/
@Aspect
@Slf4j
public class RequestLogAspect {

	public RequestLogAspect() {
	}

	private void parseParams(ProceedingJoinPoint point, Map<String, Object> paramMap) {
		// 参数值
		Object[] argValues = point.getArgs();
		// 参数名称
		MethodSignature ms = (MethodSignature) point.getSignature();
		Method method = ms.getMethod();
		if (argValues != null) {
			for (int i = 0; i < argValues.length; i++) {
				// 读取方法参数
				MethodParameter methodParam = ClassUtil.getMethodParameter(method, i);
				// PathVariable 参数跳过
				PathVariable pathVariable = methodParam.getParameterAnnotation(PathVariable.class);
				if (pathVariable != null) {
					continue;
				}
				RequestBody requestBody = methodParam.getParameterAnnotation(RequestBody.class);
				Object value = argValues[i];
				// 如果是body的json则是对象
				if (requestBody != null && value != null) {
					paramMap.putAll(BeanUtil.beanToMap(value));
					continue;
				}
				// 处理 List
				if (value instanceof List) {
					value = ((List) value).get(0);
				}
				// 处理 参数
				if (value instanceof HttpServletRequest) {
					paramMap.putAll(((HttpServletRequest) value).getParameterMap());
				} else if (value instanceof WebRequest) {
					paramMap.putAll(((WebRequest) value).getParameterMap());
				} else if (value instanceof MultipartFile) {
					MultipartFile multipartFile = (MultipartFile) value;
					String name = multipartFile.getName();
					String fileName = multipartFile.getOriginalFilename();
					paramMap.put(name, fileName);
				} else if (value instanceof HttpServletResponse) {
				} else if (value instanceof InputStream) {
				} else if (value instanceof InputStreamSource) {
				} else {
					// 参数名
					RequestParam requestParam = methodParam.getParameterAnnotation(RequestParam.class);
					String paraName;
					if (requestParam != null && StringUtil.isNotBlank(requestParam.value())) {
						paraName = requestParam.value();
					} else {
						paraName = methodParam.getParameterName();
					}
					paramMap.put(paraName, value);
				}
			}
		}
	}

	@SneakyThrows
	@Around("execution(!static com.albedo.java.common.core.util.Result *(..)) && (@within(org.springframework.stereotype.Controller) || @within(org.springframework.web.bind.annotation.RestController))")
	public Object around(ProceedingJoinPoint point) {
		HttpServletRequest request = WebUtil.getRequest();
		String requestUri = Objects.requireNonNull(request).getRequestURI();
		String requestMethod = request.getMethod();
		// 构建成一条长 日志，避免并发下日志错乱
		StringBuilder beforeReqLog = new StringBuilder(300);
		// 日志参数
		List<Object> beforeReqArgs = new ArrayList<>();
		// 打印路由
		beforeReqLog.append("Request===> {}: {}");
		beforeReqArgs.add(requestMethod);
		beforeReqArgs.add(requestUri);
		// 请求参数处理
		final Map<String, Object> paramMap = new HashMap<>(16);

		parseParams(point, paramMap);

		// 请求参数
		if (MapUtil.isNotEmpty(paramMap)) {
			beforeReqLog.append(" Parameters: {}");
			beforeReqArgs.add(paramMap);
		}
		log.info(beforeReqLog.toString(), beforeReqArgs.toArray());
		// aop 执行后的日志
		StringBuilder afterReqLog = new StringBuilder(200);
		// 日志参数
		List<Object> afterReqArgs = new ArrayList<>();
		long startNs = System.nanoTime();
		Object result = null;
		try {
			result = point.proceed();
			beforeReqLog.append("Request===> {}: {}");
			beforeReqArgs.add(requestMethod);
			beforeReqArgs.add(requestUri);
			// 打印返回结构体
			afterReqLog.append("Response===> {}: {}");
			afterReqArgs.add(requestMethod);
			afterReqArgs.add(requestUri);
		} finally {
			long tookMs = TimeUnit.NANOSECONDS.toMillis(System.nanoTime() - startNs);
			afterReqLog.append(" time ({} ms) Result:{}");
			afterReqArgs.add(tookMs);
			afterReqArgs.add(JSONUtil.toJsonStr(result));
			log.info(afterReqLog.toString(), afterReqArgs.toArray());
		}

		return result;
	}

}
