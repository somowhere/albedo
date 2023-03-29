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

package com.albedo.java.modules.sys.web;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.LoggerContext;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.modules.sys.domain.vo.LoggerVo;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Controller for view and managing Log Level at runtime.
 *
 * @author somewhere
 */
@RestController
@RequestMapping("/management")
@Tag(name = "系统日志")
public class LogsResource {

	@GetMapping("/logs")
	public List<LoggerVo> getList() {
		LoggerContext context = (LoggerContext) LoggerFactory.getILoggerFactory();
		return context.getLoggerList().stream().map(LoggerVo::new).collect(Collectors.toList());
	}

	@PutMapping("/logs")
	public Result<?> changeLevel(@RequestBody LoggerVo jsonLogger) {
		LoggerContext context = (LoggerContext) LoggerFactory.getILoggerFactory();
		context.getLogger(jsonLogger.getName()).setLevel(Level.valueOf(jsonLogger.getLevel()));
		return Result.buildOk("操作成功");
	}

}
