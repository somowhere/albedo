
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

package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.AppendixVo;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.file.service.AppendixService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@RestController
@RequestMapping("${application.admin-path}/sys/appendix")
@AllArgsConstructor
@Api(tags = "附件管理")
public class AppendixResource extends BaseResource {

	private final AppendixService appendixService;

	/**
	 * 根据业务id 和 业务类型查询附件信息
	 *
	 * @param bizId   业务id
	 * @param bizType 业务类型
	 */
	@ApiOperation(value = "根据业务id 和 业务类型查询附件信息", notes = "根据业务id 和 业务类型查询附件信息")
	@PostMapping(value = "/listByBizId")
	@LogOperate("根据业务id 和 业务类型查询附件信息")
	public Result<List<AppendixVo>> listByBizId(@RequestParam Long bizId, @RequestParam(required = false) String bizType) {
		return Result.buildOkData(appendixService.listByBizIdAndBizType(bizId, bizType));
	}

}
