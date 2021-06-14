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

package com.albedo.java.modules.gen.web;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.CharUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.gen.domain.dto.*;
import com.albedo.java.modules.gen.service.SchemeService;
import com.albedo.java.modules.gen.service.TableService;
import com.albedo.java.modules.sys.domain.dto.GenSchemeDto;
import com.albedo.java.modules.sys.service.MenuService;
import io.swagger.annotations.Api;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;
import java.util.Set;

/**
 * 生成方案Controller
 *
 * @author somewhere
 */
@RestController
@RequestMapping("${application.admin-path}/gen/scheme")
@AllArgsConstructor
@Api(tags = "生成方案")
public class SchemeResource extends BaseResource {

	private final SchemeService schemeService;
	private final TableService tableService;
	private final MenuService menuService;

	/**
	 * @param pageModel
	 * @return
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	@LogOperate(value = "生成方案查看")
	public Result getPage(PageModel pageModel, SchemeQueryCriteria schemeQueryCriteria) {
		return Result.buildOkData(schemeService.getSchemeVoPage(pageModel, schemeQueryCriteria));
	}

	@GetMapping(value = "/preview" + CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	public Result preview(@PathVariable String id) {
		String username = SecurityUtil.getUser().getUsername();
		Map<String, Object> formData = schemeService.previewCode(id, username);
		return Result.buildOkData(formData);
	}

	@GetMapping(value = "/form-data")
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	public Result formData(SchemeDto schemeDto) {
		String username = SecurityUtil.getUser().getUsername();
		Map<String, Object> formData = schemeService.findFormData(schemeDto, username);
		return Result.buildOkData(formData);
	}

	@LogOperate(value = "方案生成代码")
	@PutMapping(value = "/gen-code")
	@PreAuthorize("@pms.hasPermission('gen_scheme_code')")
	public Result genCode(@Valid @RequestBody GenCodeDto genCodeDto) {
		SchemeDto genSchemeDto = schemeService.getOneDto(genCodeDto.getId());
		Assert.isTrue(genSchemeDto != null, "无法获取代码生成方案信息");
		genSchemeDto.setReplaceFile(genCodeDto.getReplaceFile());
		schemeService.generateCode(genSchemeDto);
		return Result.buildOk("生成", genSchemeDto.getName(), "代码成功");
	}

	@LogOperate(value = "生成方案编辑")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('gen_scheme_edit')")
	public Result save(@Valid @RequestBody SchemeDto schemeDto) {
		schemeService.saveOrUpdate(schemeDto);
		// 生成代码
		if (schemeDto.getGenCode()) {
			schemeService.generateCode(schemeDto);
		}
		return Result.buildOk("保存", schemeDto.getName(), "成功");
	}

	@LogOperate(value = "生成方案编辑")
	@PostMapping("/gen-menu")
	@PreAuthorize("@pms.hasPermission('gen_scheme_menu')")
	public Result genMenu(@Valid @RequestBody SchemeGenDto schemeGenDto) {
		SchemeDto schemeDto = schemeService.getOneDto(schemeGenDto.getId());
		TableDto tableDto = schemeDto.getTableDto();
		if (tableDto == null) {
			tableDto = tableService.getOneDto(schemeDto.getTableId());
		}
		String url = StringUtil.toAppendStr(StringUtil.SLASH, StringUtil.lowerCase(schemeDto.getModuleName()), (StringUtil.isNotBlank(schemeDto.getSubModuleName()) ? StringUtil.SLASH + StringUtil.lowerCase(schemeDto.getSubModuleName()) : ""), StringUtil.SLASH,
			StringUtil.toRevertCamelCase(StringUtil.lowerFirst(tableDto.getClassName()), CharUtil.DASHED), StringUtil.SLASH);
		menuService.saveByGenScheme(new GenSchemeDto(schemeDto.getName(), schemeGenDto.getParentMenuId(), url, tableDto.getClassName()));
		return Result.buildOk("生成", schemeDto.getName(), "菜单成功");
	}


	@LogOperate(value = "生成方案删除")
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('gen_scheme_del')")
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete User: {}", ids);
		schemeService.removeByIds(ids);
		return Result.buildOk("删除成功");
	}


}
