/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.core.util;

import cn.hutool.core.net.NetUtil;
import lombok.extern.slf4j.Slf4j;
import net.dreamlu.mica.ip2region.core.Ip2regionSearcher;

/**
 * 获取地址类
 *
 * @author somewhere
 */
@Slf4j
public class AddressUtil {

	public static final String LOCAL_IP = "0:0:0:0:0:0:0:1";

	public static final Ip2regionSearcher IP2_REGION_SEARCHER = SpringContextHolder.getBean(Ip2regionSearcher.class);

	private AddressUtil() {
	}

	/**
	 * 解析IP
	 *
	 * @param ip ip
	 * @return 地区
	 */
	public static String getRegion(String ip) {
		// 内网不查询
		if (LOCAL_IP.equals(ip) || NetUtil.isInnerIP(ip)) {
			return "内网IP";
		}

		return IP2_REGION_SEARCHER.getAddressAndIsp(ip);
	}


}
