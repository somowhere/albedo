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

import com.albedo.java.common.core.exception.code.ResponseCode;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.modules.file.domain.dto.FileQueryCriteria;
import com.albedo.java.modules.file.domain.vo.param.FileUploadVo;
import com.albedo.java.modules.file.domain.vo.result.FileResultVo;
import com.albedo.java.modules.file.service.FileService;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 通用请求处理
 *
 * @author somewhere
 */
@RestController
@Slf4j
@RequestMapping("${application.admin-path}/file")
@AllArgsConstructor
@Tag(name = "文件管理")
public class FileResource {

	private final FileService fileService;

	/**
	 * 上传文件
	 */
	@Operation(summary = "附件上传", description = "附件上传")
	@Parameters({
		@Parameter(name = "file", description = "附件", required = true),
	})
	@PostMapping(value = "/anyone/upload")
	@LogOperate("上传附件")
	public Result<FileResultVo> upload(@RequestParam(value = "file") MultipartFile file,
									   @Validated FileUploadVo attachmentVo) {
		// 忽略路径字段,只处理文件类型
		if (file.isEmpty()) {
			return Result.build(ResponseCode.BASE_VALID_PARAM.build("请上传有效文件"));
		}
		return Result.buildOkData(fileService.upload(file, attachmentVo));
	}


	/**
	 * 根据文件相对路径，获取访问路径
	 *
	 * @param paths 文件路径
	 */
	@Operation(summary = "批量根据文件相对路径，获取文件临时的访问路径", description = "批量根据文件相对路径，获取文件临时的访问路径")
	@PostMapping(value = "/anyone/findUrlByPath")
	@LogOperate("批量根据文件相对路径，获取文件临时的访问路径")
	public Result<Map<String, String>> findUrlByPath(@RequestBody List<String> paths) {
		return Result.buildOkData(fileService.findUrlByPath(paths));
	}

	/**
	 * 根据文件id，获取访问路径
	 *
	 * @param ids 文件id
	 */
	@Operation(summary = "根据文件id，获取文件临时的访问路径", description = "根据文件id，获取文件临时的访问路径")
	@PostMapping(value = "/anyone/findUrlById")
	@LogOperate("根据文件id，获取文件临时的访问路径")
	public Result<Map<Long, String>> findUrlById(@RequestBody List<Long> ids) {
		return Result.buildOkData(fileService.findUrlById(ids));
	}

	/**
	 * 下载一个文件或多个文件打包下载
	 *
	 * @param ids 文件id
	 */
	@Operation(summary = "根据文件id打包下载", description = "根据附件id下载多个打包的附件")
	@PostMapping(value = "/download", produces = "application/octet-stream")
	@LogOperate("下载附件")
	public void download(@RequestBody List<Long> ids, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArgumentAssert.notEmpty(ids, "请选择至少一个附件");
		fileService.download(request, response, ids);
	}

	/**
	 * 分页查询文件
	 *
	 * @param pageModel 参数集
	 * @return 附件集合
	 */
	@GetMapping
	@LogOperate(value = "文件分页查看")
	@PreAuthorize("@pms.hasPermission('sys_file_view')")
	public Result<IPage> findPage(PageModel pageModel, FileQueryCriteria fileQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pageModel, fileQueryCriteria);
		return Result.buildOkData(fileService.page(pageModel, wrapper));
	}

	/**
	 * 删除操作文件
	 *
	 * @param ids ID
	 * @return success/false
	 */
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('sys_file_del')")
	@LogOperate(value = "附件删除")
	public Result removeById(@RequestBody Set<Long> ids) {
		return Result.buildOkData(fileService.removeByIds(ids));
	}

}
