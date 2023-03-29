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

package com.albedo.java.modules.gen.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.gen.domain.DatasourceConfDo;
import com.albedo.java.modules.gen.domain.dto.DatasourceConfDto;
import com.albedo.java.modules.gen.domain.dto.DatasourceConfQueryDto;
import com.albedo.java.modules.gen.service.DatasourceConfService;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Set;

/**
 * 数据源Controller 数据源
 *
 * @author somewhere
 * @version 2020-09-20 09:36:15
 */
@RestController
@RequestMapping(value = "${application.admin-path}/gen/datasource-conf")
@AllArgsConstructor
@Tag(name = "表数据源")
public class DatasourceConfResource extends BaseResource {

	private final DatasourceConfService service;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('gen_datasourceConf_view')")
	public Result<DatasourceConfDto> get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		DatasourceConfDto datasourceConfDto = service.getOneDto(id);
		datasourceConfDto.setPassword(null);
		return Result.buildOkData(datasourceConfDto);
	}

	/**
	 * GET / : get all datasourceConf.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all datasourceConf
	 */

	@PreAuthorize("@pms.hasPermission('gen_datasourceConf_view')")
	@GetMapping
	@LogOperate(value = "数据源查看")
	public Result<PageModel<DatasourceConfDo>> getPage(PageModel<DatasourceConfDo> pm, DatasourceConfQueryDto datasourceConfQueryDto) {
		return Result.buildOkData(service.page(pm, QueryWrapperUtil.getWrapper(pm, datasourceConfQueryDto)));
	}

	/**
	 * POST / : Save a datasourceConfDto.
	 *
	 * @param datasourceConfDto the HTTP datasourceConf
	 */
	@PreAuthorize("@pms.hasPermission('gen_datasourceConf_edit')")
	@LogOperate(value = "数据源编辑")
	@PostMapping
	public Result<?> save(@Valid @RequestBody DatasourceConfDto datasourceConfDto) {
		log.debug("REST request to save DatasourceConfDto : {}", datasourceConfDto);
		service.saveOrUpdate(datasourceConfDto);
		return Result.buildOk("保存数据源成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" DatasourceConf.
	 *
	 * @param ids the id of the datasourceConf to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('gen_datasourceConf_del')")
	@LogOperate(value = "数据源删除")
	@DeleteMapping
	public Result<?> delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete DatasourceConf: {}", ids);
		service.removeByIds(ids);
		return Result.buildOk("删除数据源成功");
	}

}
