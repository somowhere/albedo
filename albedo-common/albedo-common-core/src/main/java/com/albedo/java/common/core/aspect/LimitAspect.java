/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.core.aspect;

import com.albedo.java.common.core.annotation.Limit;
import com.albedo.java.common.core.exception.ArgumentException;
import com.albedo.java.common.core.util.RequestHolder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.WebUtil;
import com.google.common.collect.ImmutableList;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.data.redis.core.script.RedisScript;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;

/**
 * @author /
 */
@Aspect
@Component
public class LimitAspect {

	private static final Logger logger = LoggerFactory.getLogger(LimitAspect.class);

	private final RedisTemplate<Object, Object> redisTemplate;

	public LimitAspect(RedisTemplate<Object, Object> redisTemplate) {
		this.redisTemplate = redisTemplate;
	}

	@Pointcut("@annotation(com.albedo.java.common.core.annotation.Limit)")
	public void pointcut() {
	}

	@Around("pointcut()")
	public Object around(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpServletRequest request = RequestHolder.getHttpServletRequest();
		MethodSignature signature = (MethodSignature) joinPoint.getSignature();
		Method signatureMethod = signature.getMethod();
		Limit limit = signatureMethod.getAnnotation(Limit.class);
		LimitType limitType = limit.limitType();
		String key = limit.key();
		if (StringUtil.isEmpty(key)) {
			if (limitType == LimitType.IP) {
				key = WebUtil.getIp(request);
			} else {
				key = signatureMethod.getName();
			}
		}

		ImmutableList<Object> keys = ImmutableList.of(StringUtil.join(limit.prefix(), "_", key, "_",
			request.getRequestURI().replaceAll(StringUtil.SLASH, "_")));

		String luaScript = buildLuaScript();
		RedisScript<Number> redisScript = new DefaultRedisScript<>(luaScript, Number.class);
		Number count = redisTemplate.execute(redisScript, keys, limit.count(), limit.period());
		if (null != count && count.intValue() <= limit.count()) {
			logger.info("第{}次访问key为 {}，描述为 [{}] 的接口", count, keys, limit.name());
			return joinPoint.proceed();
		} else {
			throw new ArgumentException("访问次数受限制");
		}
	}

	/**
	 * 限流脚本
	 */
	private String buildLuaScript() {
		return "local c" + "\nc = redis.call('get',KEYS[1])" + "\nif c and tonumber(c) > tonumber(ARGV[1]) then"
			+ "\nreturn c;" + "\nend" + "\nc = redis.call('incr',KEYS[1])" + "\nif tonumber(c) == 1 then"
			+ "\nredis.call('expire',KEYS[1],ARGV[2])" + "\nend" + "\nreturn c;";
	}

}
