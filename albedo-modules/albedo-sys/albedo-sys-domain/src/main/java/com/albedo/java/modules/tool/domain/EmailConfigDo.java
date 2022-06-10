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

package com.albedo.java.modules.tool.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.springframework.data.annotation.Id;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 邮件配置类，数据存覆盖式存入数据存
 *
 * @author somewhere
 * @date 2018-12-26
 */
@Data
@TableName("tool_email_config")
public class EmailConfigDo implements Serializable {

	@Id
	@Schema(name = "ID", hidden = true)
	private Long id;

	@NotBlank
	@Schema(name = "邮件服务器SMTP地址")
	private String host;

	@NotBlank
	@Schema(name = "邮件服务器 SMTP 端口")
	private String port;

	@NotBlank
	@Schema(name = "发件者用户名")
	private String user;

	@NotBlank
	@Schema(name = "密码")
	private String pass;

	@NotBlank
	@Schema(name = "收件人")
	private String fromUser;

}
