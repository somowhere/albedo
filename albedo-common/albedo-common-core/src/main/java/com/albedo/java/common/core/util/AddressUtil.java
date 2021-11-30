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

import cn.hutool.core.io.resource.ResourceUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.lionsoul.ip2region.DataBlock;
import org.lionsoul.ip2region.DbConfig;
import org.lionsoul.ip2region.DbSearcher;
import org.lionsoul.ip2region.Util;

import java.io.File;
import java.io.InputStream;
import java.lang.reflect.Method;

/**
 * 获取地址类
 *
 * @author somewhere
 */
@Slf4j
public class AddressUtil {

	private static final String JAVA_TEMP_DIR = "java.io.tmpdir";
	private static DbConfig config = null;
	private static DbSearcher searcher = null;

	static {
		try {
			String dbPath = AddressUtil.class.getResource("/ip2region/ip2region.db").getPath();
			File file = new File(dbPath);
			if (!file.exists()) {
				String tmpDir = System.getProperties().getProperty(JAVA_TEMP_DIR);
				dbPath = tmpDir + "ip2region.db";
				file = new File(dbPath);
				String classPath = "classpath*:ip2region/ip2region.db";
				InputStream resourceAsStream = ResourceUtil.getStreamSafe(classPath);
				if (resourceAsStream != null) {
					FileUtil.copyInputStreamToFile(resourceAsStream, file);
				}
			}
			config = new DbConfig();
			searcher = new DbSearcher(config, dbPath);
			log.info("bean [{}]", config);
			log.info("bean [{}]", searcher);
		} catch (Exception e) {
			log.error("init ip region error", e);
		}
	}

	private AddressUtil() {
	}

	/**
	 * 解析IP
	 *
	 * @param ip ip
	 * @return 地区
	 */
	public static String getRegion(String ip) {
		try {
			//db
			if (searcher == null || StrUtil.isEmpty(ip)) {
				log.error("DbSearcher is null");
				return StrUtil.EMPTY;
			}
			long startTime = System.currentTimeMillis();
			//查询算法
			Method method = searcher.getClass().getMethod("memorySearch", String.class);

			DataBlock dataBlock;
			if (!Util.isIpAddress(ip)) {
				log.warn("warning: Invalid ip address");
			}

			dataBlock = (DataBlock) method.invoke(searcher, ip);
			String result = dataBlock != null ? dataBlock.getRegion() : StrUtil.EMPTY;
			long endTime = System.currentTimeMillis();
			log.debug("region use time[{}] result[{}]", endTime - startTime, result);
			return result;

		} catch (Exception e) {
			log.error("根据ip查询地区失败:", e);
		}
		return StrUtil.EMPTY;
	}


}
