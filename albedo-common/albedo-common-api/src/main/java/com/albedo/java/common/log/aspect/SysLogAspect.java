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

package com.albedo.java.common.log.aspect;

import cn.hutool.core.exceptions.ExceptionUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.context.ThreadLocalParam;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.StrPool;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.event.listener.SysLogOperateEvent;
import com.albedo.java.common.log.enums.LogType;
import com.albedo.java.common.log.util.SysLogUtils;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.sys.domain.LogOperate;
import io.swagger.annotations.Api;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.core.DefaultParameterNameDiscoverer;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.Expression;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;

/**
 * 操作日志使用spring event异步入库
 *
 * @author somewhere
 */
@Aspect
@Slf4j
public class SysLogAspect {

	/**
	 * 用于获取方法参数定义名字.
	 */
	private final DefaultParameterNameDiscoverer nameDiscoverer = new DefaultParameterNameDiscoverer();

	/**
	 * 用于SpEL表达式解析.
	 */
	private final SpelExpressionParser spelExpressionParser = new SpelExpressionParser();

	@Around("@annotation(logOperate)")
	@SneakyThrows
	public Object around(ProceedingJoinPoint point, com.albedo.java.common.log.annotation.LogOperate logOperate) {
		MethodSignature signature = (MethodSignature) point.getSignature();
		String strClassName = point.getTarget().getClass().getName();
		String strMethodName = point.getSignature().getName();
		SysLogAspect.log.debug("[类名]:{},[方法]:{}", strClassName, strMethodName);
		// 方法路径
		String methodName = point.getTarget().getClass().getName() + StringUtil.DOT + signature.getName() + "()";
		StringBuilder params = new StringBuilder("{");
		// 参数值
		Object[] argValues = point.getArgs();
		// 参数名称
		String[] argNames = ((MethodSignature) point.getSignature()).getParameterNames();
		if (argValues != null) {
			for (int i = 0; i < argValues.length; i++) {
				params.append(" ").append(argNames[i]).append(": ").append(argValues[i]);
			}
		}
		LogOperate logOperateVo = SysLogUtils.getSysLogOperate();
		logOperateVo.setTitle(logOperate.value());
		logOperateVo.setMethod(methodName);
		logOperateVo.setParams(params + " }");
		logOperateVo.setOperatorType(logOperate.operatorType().name());
		setDescription(point, logOperate, logOperateVo);
		Long startTime = System.currentTimeMillis();
		Object obj;
		try {
			obj = point.proceed();
			logOperateVo.setLogType(LogType.INFO.name());
		} catch (Exception e) {
			logOperateVo.setDescription(e.getMessage());
			if (e instanceof BizException) {
				logOperateVo.setLogType(LogType.WARN.name());
			} else {
				logOperateVo.setException(ExceptionUtil.stacktraceToString(e));
				logOperateVo.setLogType(LogType.ERROR.name());
			}
			throw e;
		} finally {
			saveLog(System.currentTimeMillis() - startTime, logOperateVo, logOperate);
		}

		return obj;
	}


	private void setDescription(JoinPoint joinPoint, com.albedo.java.common.log.annotation.LogOperate logOperate,
								LogOperate logOperateVo) {
		String controllerDescription = "";
		Api api = joinPoint.getTarget().getClass().getAnnotation(Api.class);
		if (api != null) {
			String[] tags = api.tags();
			if (ArrayUtil.isNotEmpty(tags)) {
				controllerDescription = tags[0];
			}
		}

		String controllerMethodDescription = logOperate.value();

		if (StrUtil.isNotEmpty(controllerMethodDescription) && StrUtil.contains(controllerMethodDescription, StrPool.HASH)) {
			//获取方法参数值
			Object[] args = joinPoint.getArgs();

			MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
			controllerMethodDescription = getValBySpEl(controllerMethodDescription, methodSignature, args);
		}

		if (StrUtil.isEmpty(controllerDescription)) {
			logOperateVo.setDescription(controllerMethodDescription);
		} else {
			if (logOperate.controllerApiValue()) {
				logOperateVo.setDescription(controllerDescription + "-" + controllerMethodDescription);
			} else {
				logOperateVo.setDescription(controllerMethodDescription);
			}
		}
	}

	/**
	 * 解析spEL表达式
	 */
	private String getValBySpEl(String spEl, MethodSignature methodSignature, Object[] args) {
		try {
			//获取方法形参名数组
			String[] paramNames = nameDiscoverer.getParameterNames(methodSignature.getMethod());
			if (paramNames != null && paramNames.length > 0) {
				Expression expression = spelExpressionParser.parseExpression(spEl);
				// spring的表达式上下文对象
				EvaluationContext context = new StandardEvaluationContext();
				// 给上下文赋值
				for (int i = 0; i < args.length; i++) {
					context.setVariable(paramNames[i], args[i]);
					context.setVariable("p" + i, args[i]);
				}
				context.setVariable("threadLocal", ThreadLocalParam.builder()
					.tenant(ContextUtil.getTenant()).userId(ContextUtil.getUserId())
					.username(SecurityUtil.getUser().getUsername()).build());
				Object value = expression.getValue(context);
				return value == null ? spEl : value.toString();
			}
		} catch (Exception e) {
			log.warn("解析操作日志的el表达式出错", e);
		}
		return spEl;
	}


	/**
	 * @param tookMs
	 * @param logOperateVo
	 * @param logOperate
	 */
	public void saveLog(Long tookMs, LogOperate logOperateVo,
						com.albedo.java.common.log.annotation.LogOperate logOperate) {
		logOperateVo.setTime(tookMs);
		log.debug("[logOperateVo]:{}", logOperateVo);
		// 是否需要保存request，参数和值
		if (logOperate.isSaveRequestData()) {
			// 发送异步日志事件
			SpringContextHolder.publishEvent(new SysLogOperateEvent(logOperateVo));
		}
	}

}
