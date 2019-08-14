/*
 *  Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.modules.sys.service.PersistentTokenService;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * @author somewhere
 * @date 2018/9/4
 * getTokenPage 管理
 */
@RestController
@AllArgsConstructor
@RequestMapping("${application.admin-path}/sys/persistent-token")
public class PersistentTokenResource {
	private final PersistentTokenService persistentTokenService;

	/**
	 * 令牌管理
	 *
	 * @param ids
	 * @return
	 */
	@Log(value = "令牌管理", businessType = BusinessType.DELETE)
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_persistentToken_del')")
	public R removeByIds(@PathVariable String ids) {
		persistentTokenService.removeByIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.buildOk("操作成功");
	}

	/**
	 * 分页查询令牌
	 *
	 * @param pm 参数集
	 * @return 令牌集合
	 */
	@GetMapping("/")
	@PreAuthorize("@pms.hasPermission('sys_persistentToken_view')")
	public R getUserPage(PageModel pm) {
		return R.buildOkData(persistentTokenService.findPage(pm));
	}

}
