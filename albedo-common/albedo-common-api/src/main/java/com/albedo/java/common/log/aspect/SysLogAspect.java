
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

package com.albedo.java.common.log.aspect;

import cn.hutool.core.exceptions.ExceptionUtil;
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
import com.albedo.java.modules.sys.domain.LogOperateDo;
import io.swagger.v3.oas.annotations.tags.Tag;
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
		SysLogAspect.log.debug("[Class]:{},[Method]:{}", strClassName, strMethodName);
		// 方法路径
		String methodName = point.getTarget().getClass().getName() + StrPool.DOT + signature.getName() + "()";
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
		LogOperateDo logOperateDoVo = SysLogUtils.getSysLogOperate();
		logOperateDoVo.setTitle(logOperate.value());
		logOperateDoVo.setMethod(methodName);
		logOperateDoVo.setParams(params + " }");
		logOperateDoVo.setOperatorType(logOperate.operatorType().name());
		setDescription(point, logOperate, logOperateDoVo);
		Long startTime = System.currentTimeMillis();
		Object obj;
		try {
			obj = point.proceed();
			logOperateDoVo.setLogType(LogType.INFO.name());
		} catch (Exception e) {
			logOperateDoVo.setDescription(e.getMessage());
			if (e instanceof BizException) {
				logOperateDoVo.setLogType(LogType.WARN.name());
			} else {
				logOperateDoVo.setException(ExceptionUtil.stacktraceToString(e));
				logOperateDoVo.setLogType(LogType.ERROR.name());
			}
			throw e;
		} finally {
			saveLog(System.currentTimeMillis() - startTime, logOperateDoVo, logOperate);
		}

		return obj;
	}


	private void setDescription(JoinPoint joinPoint, com.albedo.java.common.log.annotation.LogOperate logOperate,
								LogOperateDo logOperateDoVo) {
		String controllerDescription = "";
		Tag api = joinPoint.getTarget().getClass().getAnnotation(Tag.class);
		if (api != null) {
			String tag = api.name();
			if (StringUtil.isNotEmpty(tag)) {
				controllerDescription = tag;
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
			logOperateDoVo.setDescription(controllerMethodDescription);
		} else {
			if (logOperate.controllerApiValue()) {
				logOperateDoVo.setDescription(controllerDescription + "-" + controllerMethodDescription);
			} else {
				logOperateDoVo.setDescription(controllerMethodDescription);
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
	 * @param logOperateDoVo
	 * @param logOperate
	 */
	public void saveLog(Long tookMs, LogOperateDo logOperateDoVo,
						com.albedo.java.common.log.annotation.LogOperate logOperate) {
		logOperateDoVo.setTime(tookMs);
		log.debug("[logOperateVo]:{}", logOperateDoVo);
		// 是否需要保存request，参数和值
		if (logOperate.isSaveRequestData()) {
			// 发送异步日志事件
			SpringContextHolder.publishEvent(new SysLogOperateEvent(logOperateDoVo));
		}
	}

}
