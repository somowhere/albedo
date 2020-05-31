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

package com.albedo.java.modules.tool.service;


import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.tool.domain.EmailConfig;
import com.albedo.java.modules.tool.domain.vo.EmailVo;

/**
 * @author somewhere
 * @since 2019/2/1
 */
public interface EmailService extends BaseService<EmailConfig> {
	/**
	 * 更新邮件配置
	 *
	 * @param emailConfig 邮件配置
	 * @param old         旧的配置
	 * @return EmailConfig
	 * @throws Exception
	 */
	EmailConfig config(EmailConfig emailConfig, EmailConfig old) throws Exception;

	/**
	 * 查询配置
	 *
	 * @return EmailConfig 邮件配置
	 */
	EmailConfig find();

	/**
	 * 发送邮件
	 *
	 * @param emailVo     邮件发送的内容
	 * @param emailConfig 邮件配置
	 * @throws Exception /
	 */
	void send(EmailVo emailVo, EmailConfig emailConfig);


	/**
	 * 发送验证码
	 *
	 * @param email /
	 * @param key   /
	 * @return /
	 */
	EmailVo sendEmail(String email, String key);


	/**
	 * 验证
	 *
	 * @param code /
	 * @param key  /
	 */
	void validated(String key, String code);
}
