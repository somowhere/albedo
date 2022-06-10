/*
 *  Copyright (c) 2019-2020, somowhere (somewhere0813@gmail.com).
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
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.log.enums.LogType;
import com.albedo.java.common.log.enums.OperatorType;
import com.albedo.java.common.log.event.SysLogOperateEvent;
import com.albedo.java.common.log.util.SysLogUtils;
import com.albedo.java.modules.sys.domain.LogOperateDo;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;

/**
 * 操作日志使用spring event异步入库
 *
 * @author L.cm
 */
@Aspect
@Slf4j
public class SysLogAspect {


	@Around("@annotation(logOperate)")
	public Object around(ProceedingJoinPoint point, com.albedo.java.common.log.annotation.LogOperate logOperate) {
		return process(point, logOperate.value(), logOperate.operatorType(), logOperate.saveRequestData());
	}

	@SneakyThrows
	public Object process(ProceedingJoinPoint point, String title, OperatorType operatorType, Boolean saveRequestData) {
		MethodSignature signature = (MethodSignature) point.getSignature();
		String strClassName = point.getTarget().getClass().getName();
		String strMethodName = point.getSignature().getName();
		log.debug("[类名]:{},[方法]:{}", strClassName, strMethodName);
		// 方法路径
		String methodName = point.getTarget().getClass().getName() + StringUtil.DOT + signature.getName() + "()";
		StringBuilder params = new StringBuilder("{");
		//参数值
		Object[] argValues = point.getArgs();
		//参数名称
		String[] argNames = ((MethodSignature) point.getSignature()).getParameterNames();
		if (argValues != null) {
			for (int i = 0; i < argValues.length; i++) {
				params.append(" ").append(argNames[i]).append(": ").append(argValues[i]);
			}
		}
		LogOperateDo logOperateVo = SysLogUtils.getSysLogOperate();
		logOperateVo.setTitle(title);
		logOperateVo.setMethod(methodName);
		logOperateVo.setParams(params + " }");
		logOperateVo.setOperatorType(operatorType.name());
		Long startTime = System.currentTimeMillis();
		Object obj;
		try {
			obj = point.proceed();
			logOperateVo.setLogType(LogType.INFO.name());
		} catch (Exception e) {
			logOperateVo.setException(ExceptionUtil.stacktraceToString(e));
			if (e instanceof BizException) {
				logOperateVo.setLogType(LogType.WARN.name());
			} else {
				logOperateVo.setLogType(LogType.ERROR.name());
			}
			throw e;
		} finally {
			saveLog(startTime, logOperateVo, saveRequestData);
		}
		return obj;
	}


	/**
	 * @param startTime
	 * @param logOperateVo
	 * @param saveRequestData
	 */
	public void saveLog(Long startTime, LogOperateDo logOperateVo, Boolean saveRequestData) {
		Long endTime = System.currentTimeMillis();
		logOperateVo.setTime(endTime - startTime);
		if (log.isTraceEnabled()) {
			log.trace("[logOperateVo]:{}", logOperateVo);
		}
		// 是否需要保存request，参数和值
		if (saveRequestData) {
			// 发送异步日志事件
			SpringContextHolder.publishEvent(new SysLogOperateEvent(logOperateVo));
		}
	}

}
