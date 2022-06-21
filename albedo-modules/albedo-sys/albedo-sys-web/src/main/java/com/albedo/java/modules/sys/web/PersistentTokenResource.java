
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

package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.modules.sys.domain.dto.PersistentTokenQueryCriteria;
import com.albedo.java.modules.sys.service.PersistentTokenService;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

/**
 * @author somewhere
 * @date 2018/9/4 getTokenPage 管理
 */
@RestController
@AllArgsConstructor
@RequestMapping("${application.admin-path}/sys/persistent-token")
@Tag(name = "令牌管理")
public class PersistentTokenResource {

	private final PersistentTokenService persistentTokenService;

	/**
	 * 令牌管理
	 *
	 * @param ids
	 * @return
	 */
	@LogOperate(value = "令牌管理删除")
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('sys_persistentToken_del')")
	public Result removeByIds(@RequestBody Set<String> ids) {
		persistentTokenService.removeByIds(ids);
		return Result.buildOk("操作成功");
	}

	/**
	 * 分页查询令牌
	 *
	 * @param pageModel 参数集
	 * @return 令牌集合
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('sys_persistentToken_view')")
	@LogOperate(value = "令牌管理查看")
	public Result findPage(PageModel pageModel, PersistentTokenQueryCriteria persistentTokenQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pageModel, persistentTokenQueryCriteria);
		return Result.buildOkData(persistentTokenService.page(pageModel, wrapper));
	}

}
