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

package com.albedo.java.modules.tool.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.data.annotation.Id;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 支付宝配置类
 *
 * @author somewhere
 * @date 2018-12-31
 */
@Data
@TableName("tool_alipay_config")
public class AlipayConfig implements Serializable {

	@Id
	@ApiModelProperty(value = "ID", hidden = true)
	private Long id;

	@NotBlank
	@ApiModelProperty(value = "应用ID")
	private String appId;

	@NotBlank
	@ApiModelProperty(value = "商户私钥")
	private String privateKey;

	@NotBlank
	@ApiModelProperty(value = "支付宝公钥")
	private String publicKey;

	@ApiModelProperty(value = "签名方式")
	private String signType = "RSA2";

	@ApiModelProperty(value = "支付宝开放安全地址", hidden = true)
	private String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

	@ApiModelProperty(value = "编码", hidden = true)
	private String charset = "utf-8";

	@NotBlank
	@ApiModelProperty(value = "异步通知地址")
	private String notifyUrl;

	@NotBlank
	@ApiModelProperty(value = "订单完成后返回的页面")
	private String returnUrl;

	@ApiModelProperty(value = "类型")
	private String format = "JSON";

	@NotBlank
	@ApiModelProperty(value = "商户号")
	private String sysServiceProviderId;

}
