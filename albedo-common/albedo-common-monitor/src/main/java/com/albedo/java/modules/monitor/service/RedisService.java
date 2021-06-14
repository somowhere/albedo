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

package com.albedo.java.modules.monitor.service;

import com.albedo.java.modules.monitor.domain.RedisInfo;
import com.albedo.java.modules.monitor.domain.ReportSearchType;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.Map;

/**
 * @author somewhere
 * @date 2021-03-08
 */
public interface RedisService {

	/**
	 * 获取 redis 的详细信息
	 *
	 * @return List
	 */
	IPage<RedisInfo> getRedisInfo();

	/**
	 * 获取 redis key 数量
	 *
	 * @return Map
	 */
	Long getKeySize();

	/**
	 * 获取 redis 内存信息
	 *
	 * @return Map
	 */
	String getUsedMemory();

	/**
	 * 获取 报表需要个redis信息
	 *
	 * @param reportSearchType
	 * @return Map
	 */
	Map<String, JSONArray> getMapForReport(ReportSearchType reportSearchType);
}
