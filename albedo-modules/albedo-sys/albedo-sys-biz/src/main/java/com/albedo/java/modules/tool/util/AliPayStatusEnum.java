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

package com.albedo.java.modules.tool.util;

/**
 * 支付状态
 *
 * @author zhengjie
 * @date 2018/08/01 16:45:43
 */
public enum AliPayStatusEnum {

	/**
	 * 交易成功
	 */
	FINISHED("交易成功", "TRADE_FINISHED"),

	/**
	 * 支付成功
	 */
	SUCCESS("支付成功", "TRADE_SUCCESS"),

	/**
	 * 交易创建
	 */
	BUYER_PAY("交易创建", "WAIT_BUYER_PAY"),

	/**
	 * 交易关闭
	 */
	CLOSED("交易关闭", "TRADE_CLOSED");

	private String value;

	AliPayStatusEnum(String name, String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

}
