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

package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.config.ApplicationConfig;
import com.albedo.java.common.core.util.FileUploadUtil;
import com.albedo.java.common.core.util.FileUtil;
import com.albedo.java.common.core.util.Result;
import com.google.common.collect.Maps;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

/**
 * 通用请求处理
 *
 * @author somewhere
 */
@Controller
@Slf4j
@RequestMapping("${application.admin-path}/file")
@Api(tags = "文件管理")
public class FileResource {


	/**
	 * 通用下载请求
	 *
	 * @param fileName 文件名称
	 * @param delete   是否删除
	 */
	@GetMapping("/download")
	public void fileDownload(String fileName, Boolean delete, HttpServletResponse response, HttpServletRequest request) {
		try {
			if (!FileUtil.isValidFilename(fileName)) {
				throw new Exception(String.format("文件名称({})非法，不允许下载。 ", fileName));
			}
			String realFileName = System.currentTimeMillis() + fileName.substring(fileName.indexOf("_") + 1);
			String filePath = ApplicationConfig.getDownloadPath() + fileName;

			response.setCharacterEncoding("utf-8");
			response.setContentType("multipart/form-data");
			response.setHeader("Content-Disposition",
				"attachment;fileName=" + FileUtil.setFileDownloadHeader(request, realFileName));
			FileUtil.writeBytes(filePath, response.getOutputStream());
			if (delete) {
				FileUtil.deleteFile(filePath);
			}
		} catch (Exception e) {
			log.error("下载文件失败", e);
		}
	}

	/**
	 * 通用上传请求
	 */
	@PostMapping("/upload")
	@ResponseBody
	public Result uploadFile(MultipartFile file, HttpServletRequest request) throws IOException {
		// 上传文件路径
		String filePath = ApplicationConfig.getUploadPath();
		// 上传并返回新文件名称
		String fileName = FileUploadUtil.upload(filePath, file);
		String url = getDomain(request) + fileName;
		HashMap<Object, Object> data = Maps.newHashMap();
		data.put("fileName", fileName);
		data.put("url", url);
		return Result.buildOkData(data);
	}

	private String getDomain(HttpServletRequest request) {
		StringBuffer url = request.getRequestURL();
		String contextPath = request.getServletContext().getContextPath();
		return url.delete(url.length() - request.getRequestURI().length(), url.length()).append(contextPath).toString();
	}
}
