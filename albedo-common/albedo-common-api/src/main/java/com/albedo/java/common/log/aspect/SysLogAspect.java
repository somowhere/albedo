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

import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.log.event.SysLogEvent;
import com.albedo.java.common.log.util.SysLogUtils;
import com.albedo.java.modules.sys.domain.LogOperate;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

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
		String strClassName = point.getTarget().getClass().getName();
		String strMethodName = point.getSignature().getName();
		SysLogAspect.log.debug("[类名]:{},[方法]:{}", strClassName, strMethodName);

		LogOperate logOperateVo = SysLogUtils.getSysLog();
		logOperateVo.setTitle(log.value());
		logOperateVo.setBusinessType(log.businessType().ordinal());
		logOperateVo.setOperatorType(log.operatorType().ordinal());
		Long startTime = System.currentTimeMillis();
		Object obj = point.proceed();
		Long endTime = System.currentTimeMillis();
		logOperateVo.setTime(endTime - startTime);
		SysLogAspect.log.debug("[logOperateVo]:{}", logOperateVo);
		// 是否需要保存request，参数和值
		if (log.isSaveRequestData()) {
			// 发送异步日志事件
			SpringContextHolder.publishEvent(new SysLogEvent(logOperateVo));
		}
		return obj;
	}

}
