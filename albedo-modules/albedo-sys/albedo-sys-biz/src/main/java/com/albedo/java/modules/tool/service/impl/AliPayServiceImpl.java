
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

package com.albedo.java.modules.tool.service.impl;

import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.modules.tool.domain.AlipayConfigDo;
import com.albedo.java.modules.tool.domain.vo.TradeVo;
import com.albedo.java.modules.tool.repository.AliPayConfigRepository;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.plugins.database.mybatis.service.impl.BaseServiceImpl;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@AllArgsConstructor
public class AliPayServiceImpl extends BaseServiceImpl<AliPayConfigRepository, AlipayConfigDo> implements AliPayService {

	private final AliPayConfigRepository alipayRepository;

	@Override
	public AlipayConfigDo find() {
		AlipayConfigDo alipayConfigDo = alipayRepository.selectById(1L);
		return alipayConfigDo == null ? new AlipayConfigDo() : alipayConfigDo;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public AlipayConfigDo config(AlipayConfigDo alipayConfigDo) {
		alipayConfigDo.setId(1L);
		saveOrUpdate(alipayConfigDo);
		return alipayConfigDo;
	}

	@Override
	public String toPayAsPc(AlipayConfigDo alipay, TradeVo trade) throws Exception {
		ArgumentAssert.notNull(alipay.getId(), () -> new BizException("请先添加相应配置，再操作"));
		AlipayClient alipayClient = new DefaultAlipayClient(alipay.getGatewayUrl(), alipay.getAppId(),
			alipay.getPrivateKey(), alipay.getFormat(), alipay.getCharset(), alipay.getPublicKey(),
			alipay.getSignType());

		// 创建API对应的request(电脑网页版)
		AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();

		// 订单完成后返回的页面和异步通知地址
		request.setReturnUrl(alipay.getReturnUrl());
		request.setNotifyUrl(alipay.getNotifyUrl());
		// 填充订单参数
		request.setBizContent("{" + "    \"out_trade_no\":\"" + trade.getOutTradeNo() + "\","
			+ "    \"product_code\":\"FAST_INSTANT_TRADE_PAY\"," + "    \"total_amount\":" + trade.getTotalAmount()
			+ "," + "    \"subject\":\"" + trade.getSubject() + "\"," + "    \"body\":\"" + trade.getBody() + "\","
			+ "    \"extend_params\":{" + "    \"sys_service_provider_id\":\"" + alipay.getSysServiceProviderId()
			+ "\"" + "    }" + "  }");// 填充业务参数
		// 调用SDK生成表单, 通过GET方式，口可以获取url
		return alipayClient.pageExecute(request, "GET").getBody();

	}

	@Override
	public String toPayAsWeb(AlipayConfigDo alipay, TradeVo trade) throws Exception {
		ArgumentAssert.notNull(alipay.getId(), () -> new BizException("请先添加相应配置，再操作"));
		AlipayClient alipayClient = new DefaultAlipayClient(alipay.getGatewayUrl(), alipay.getAppId(),
			alipay.getPrivateKey(), alipay.getFormat(), alipay.getCharset(), alipay.getPublicKey(),
			alipay.getSignType());

		double money = Double.parseDouble(trade.getTotalAmount());
		double maxMoney = 5000;
		if (money <= 0 || money >= maxMoney) {
			throw new BizException("测试金额过大");
		}
		// 创建API对应的request(手机网页版)
		AlipayTradeWapPayRequest request = new AlipayTradeWapPayRequest();
		request.setReturnUrl(alipay.getReturnUrl());
		request.setNotifyUrl(alipay.getNotifyUrl());
		request.setBizContent("{" + "    \"out_trade_no\":\"" + trade.getOutTradeNo() + "\","
			+ "    \"product_code\":\"FAST_INSTANT_TRADE_PAY\"," + "    \"total_amount\":" + trade.getTotalAmount()
			+ "," + "    \"subject\":\"" + trade.getSubject() + "\"," + "    \"body\":\"" + trade.getBody() + "\","
			+ "    \"extend_params\":{" + "    \"sys_service_provider_id\":\"" + alipay.getSysServiceProviderId()
			+ "\"" + "    }" + "  }");
		return alipayClient.pageExecute(request, "GET").getBody();
	}

}
