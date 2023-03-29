
/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.tool.service.impl;

import cn.hutool.core.lang.Dict;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.extra.mail.Mail;
import cn.hutool.extra.mail.MailAccount;
import cn.hutool.extra.template.Template;
import cn.hutool.extra.template.TemplateConfig;
import cn.hutool.extra.template.TemplateEngine;
import cn.hutool.extra.template.TemplateUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.exception.ArgumentException;
import com.albedo.java.common.core.util.EncryptUtil;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.tool.domain.EmailConfigDo;
import com.albedo.java.modules.tool.domain.vo.EmailVo;
import com.albedo.java.modules.tool.feign.RemoteEmailService;
import com.albedo.java.modules.tool.repository.EmailConfigRepository;
import com.albedo.java.modules.tool.service.EmailService;
import com.albedo.java.plugins.database.mybatis.service.impl.BaseServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.concurrent.TimeUnit;

/**
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@AllArgsConstructor
public class EmailServiceImpl extends BaseServiceImpl<EmailConfigRepository, EmailConfigDo> implements EmailService, RemoteEmailService {

	private final EmailConfigRepository emailRepository;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public EmailConfigDo config(EmailConfigDo emailConfigDo, EmailConfigDo old) throws Exception {
		emailConfigDo.setId(1L);
		if (!emailConfigDo.getPass().equals(old.getPass())) {
			// 对称加密
			emailConfigDo.setPass(EncryptUtil.desEncrypt(emailConfigDo.getPass()));
		}
		saveOrUpdate(emailConfigDo);
		return emailConfigDo;
	}

	@Override
	public EmailConfigDo find() {
		EmailConfigDo emailConfigDo = emailRepository.selectById(1L);
		return emailConfigDo == null ? new EmailConfigDo() : emailConfigDo;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void send(EmailVo emailVo, EmailConfigDo emailConfigDo) {
		if (emailConfigDo == null || emailConfigDo.getId() == null) {
			throw new ArgumentException("请先配置，再操作");
		}
		// 封装
		MailAccount account = new MailAccount();
		account.setHost(emailConfigDo.getHost());
		account.setPort(Integer.parseInt(emailConfigDo.getPort()));
		account.setAuth(true);
		try {
			// 对称解密
			account.setPass(EncryptUtil.desDecrypt(emailConfigDo.getPass()));
		} catch (Exception e) {
			throw new ArgumentException(e.getMessage());
		}
		account.setFrom(emailConfigDo.getUser() + "<" + emailConfigDo.getFromUser() + ">");
		// ssl方式发送
		account.setSslEnable(true);
		// 使用STARTTLS安全连接
		account.setStarttlsEnable(true);
		String content = emailVo.getContent();
		// 发送
		try {
			int size = emailVo.getTos().size();
			Mail.create(account).setTos(emailVo.getTos().toArray(new String[size])).setTitle(emailVo.getSubject())
				.setContent(content).setHtml(true)
				// 关闭session
				.setUseGlobalSession(false).send();
		} catch (Exception e) {
			throw new ArgumentException(e.getMessage());
		}
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public EmailVo sendEmail(String email, String key) {
		EmailVo emailVo;
		String content;
		String redisKey = ContextUtil.getTenant() + key + email;
		// 如果不存在有效的验证码，就创建一个新的
		TemplateEngine engine = TemplateUtil
			.createEngine(new TemplateConfig("templates/codet/templates", TemplateConfig.ResourceMode.CLASSPATH));
		Template template = engine.getTemplate("email/email.ftl");
		Object oldCode = RedisUtil.getCacheString(redisKey);
		if (oldCode == null) {
			String code = RandomUtil.randomNumbers(6);
			// 存入缓存
			RedisUtil.setCacheString(redisKey, code, CommonConstants.DEFAULT_IMAGE_EXPIRE, TimeUnit.SECONDS);
			content = template.render(Dict.create().set("code", code));
			// 存在就再次发送原来的验证码
		} else {
			content = template.render(Dict.create().set("code", oldCode));
		}
		emailVo = new EmailVo(Collections.singletonList(email), "Albedo后台管理系统", content);
		return emailVo;
	}

	@Override
	public void validated(String key, String code) {
		Object value = RedisUtil.getCacheString(ContextUtil.getTenant() + key);
		if (value == null || !value.toString().equals(code)) {
			throw new ArgumentException("无效验证码");
		} else {
			RedisUtil.delete(ContextUtil.getTenant() + key);
		}
	}

	@Override
	public void send(EmailVo emailVo) {
		send(emailVo, find());
	}
}
