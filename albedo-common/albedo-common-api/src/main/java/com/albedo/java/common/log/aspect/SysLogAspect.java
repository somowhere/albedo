/*
 *  Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
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
import com.albedo.java.common.core.util.Json;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.log.enums.LogType;
import com.albedo.java.common.log.event.SysLogEvent;
import com.albedo.java.common.log.util.SysLogUtils;
import com.albedo.java.modules.sys.domain.LogOperate;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;

/**
 * 操作日志使用spring event异步入库
 *
 * @author L.cm
 */
@Aspect
@Slf4j
public class SysLogAspect {

	@Around("@annotation(log)")
	@SneakyThrows
	public Object around(ProceedingJoinPoint point, com.albedo.java.common.log.annotation.Log log) {
		MethodSignature signature = (MethodSignature) point.getSignature();
		String strClassName = point.getTarget().getClass().getName();
		String strMethodName = point.getSignature().getName();
		SysLogAspect.log.debug("[类名]:{},[方法]:{}", strClassName, strMethodName);
		// 方法路径
		String methodName = point.getTarget().getClass().getName()+"."+signature.getName()+"()";
		StringBuilder params = new StringBuilder("{");
		//参数值
		Object[] argValues = point.getArgs();
		//参数名称
		String[] argNames = ((MethodSignature)point.getSignature()).getParameterNames();
		if(argValues != null){
			for (int i = 0; i < argValues.length; i++) {
				params.append(" ").append(argNames[i]).append(": ").append(Json.toJSONString(argValues[i]));
			}
		}
		LogOperate logOperateVo = SysLogUtils.getSysLog();
		logOperateVo.setTitle(log.value());
		logOperateVo.setMethod(methodName);
		logOperateVo.setParams(params.toString() + " }");
		logOperateVo.setBusinessType(log.businessType().name());
		logOperateVo.setOperatorType(log.operatorType().name());
		Long startTime = System.currentTimeMillis();
		Object obj;
		try {
			obj = point.proceed();
			logOperateVo.setLogType(LogType.INFO.name());
			saveLog(startTime, logOperateVo, log);
		}catch (Exception e){
			logOperateVo.setException(ExceptionUtil.stacktraceToString(e));
			logOperateVo.setLogType(LogType.ERROR.name());
			saveLog(startTime, logOperateVo, log);
			throw e;
		}

		return obj;
	}

	/**
	 * @param startTime
	 * @param logOperateVo
	 * @param log
	 */
	public void saveLog(Long startTime, LogOperate logOperateVo, com.albedo.java.common.log.annotation.Log log) {
		Long endTime = System.currentTimeMillis();
		logOperateVo.setTime(endTime - startTime);
		SysLogAspect.log.debug("[logOperateVo]:{}", logOperateVo);
		// 是否需要保存request，参数和值
		if (log.isSaveRequestData()) {
			// 发送异步日志事件
			SpringContextHolder.publishEvent(new SysLogEvent(logOperateVo));
		}
	}

}
