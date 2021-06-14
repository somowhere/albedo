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

package com.albedo.java.common.core.util;

import cn.hutool.core.net.NetUtil;
import cn.hutool.http.HttpUtil;
import com.albedo.java.common.core.config.ApplicationConfig;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;

/**
 * 获取地址类
 *
 * @author somewhere
 */
@Slf4j
public class AddressUtil {

	public static final String IP_URL = "http://ip.taobao.com/service/getIpInfo.php";

	public static final String LOCAL_IP = "0:0:0:0:0:0:0:1";

	public static String getRealAddressByIp(String ip) {
		String address = "XX XX";

		// 内网不查询
		if (LOCAL_IP.equals(ip) || NetUtil.isInnerIP(ip)) {
			return "内网IP";
		}
		if (ApplicationConfig.isAddressEnabled()) {
			String rspStr = HttpUtil.post(IP_URL, "ip=" + ip);
			if (StringUtil.isEmpty(rspStr)) {
				log.error("获取地理位置异常 {}", ip);
				return address;
			}
			JSONObject obj;
			try {
				obj = JSON.parseObject(rspStr, JSONObject.class);
				JSONObject data = obj.getJSONObject("data");
				String region = data.getString("region");
				String city = data.getString("city");
				address = region + " " + city;
			} catch (Exception e) {
				log.error("获取地理位置异常 {}", ip);
			}
		}
		return address;
	}

}
