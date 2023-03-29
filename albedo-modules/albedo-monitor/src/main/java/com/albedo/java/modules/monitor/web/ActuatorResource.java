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

package com.albedo.java.modules.monitor.web;

import cn.hutool.json.JSONArray;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.modules.monitor.domain.RedisInfo;
import com.albedo.java.modules.monitor.domain.ReportSearchType;
import com.albedo.java.modules.monitor.service.MonitorService;
import com.albedo.java.modules.monitor.service.RedisService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author somewhere
 * @date 2020-05-02
 */
@RestController
@RequiredArgsConstructor
@Tag(name = "服务监控")
@RequestMapping("${application.admin-path}/actuator/")
public class ActuatorResource {

	private final MonitorService monitorService;

	private final RedisService redisService;

	@GetMapping("system")
	@Operation(summary = "查询服务监控")
	public Result getServers() {
		return Result.buildOkData(monitorService.getServers());
	}

	/**
	 * Redis详细信息
	 *
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/redis/detail")
	public Result<IPage<RedisInfo>> getRedisInfo() {
		return Result.buildOkData(redisService.getRedisInfo());
	}

	/**
	 * 获取redis key数量 for 报表
	 *
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/redis/keys-size-report")
	public Result<Map<String, JSONArray>> getKeysSizeReport() {
		return Result.buildOkData(redisService.getMapForReport(ReportSearchType.KEY));
	}

	/**
	 * 获取redis 内存 for 报表
	 *
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/redis/memory-report")
	public Result<Map<String, JSONArray>> memoryForReport() {
		return Result.buildOkData(redisService.getMapForReport(ReportSearchType.RAM));
	}

	/**
	 * 获取redis 全部信息 for 报表
	 *
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/redis/info-report")
	public Result<Map<String, JSONArray>> infoForReport() {

		return Result.buildOkData(redisService.getMapForReport(ReportSearchType.INFO));

	}

}
