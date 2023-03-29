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

package com.albedo.java.common.core.util;

import cn.hutool.core.io.FileUtil;
import com.albedo.java.common.core.config.ApplicationConfig;
import com.albedo.java.common.core.exception.BizException;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

/**
 * 文件上传工具类
 *
 * @author somewhere
 */
public class FileUploadUtil {

	/**
	 * 默认大小 50M
	 */
	public static final long DEFAULT_MAX_SIZE = 50 * 1024 * 1024;

	/**
	 * 默认的文件名最大长度 100
	 */
	public static final int DEFAULT_FILE_NAME_LENGTH = 100;

	/**
	 * 默认上传的地址
	 */
	private static String defaultBaseDir = ApplicationConfig.getStaticFileDirectory();

	private static int counter = 0;

	public static String getDefaultBaseDir() {
		return defaultBaseDir;
	}

	public static void setDefaultBaseDir(String defaultBaseDir) {
		FileUploadUtil.defaultBaseDir = defaultBaseDir;
	}

	/**
	 * 以默认配置进行文件上传
	 *
	 * @param file 上传的文件
	 * @return 文件名称
	 * @throws Exception
	 */
	public static final String upload(MultipartFile file) throws IOException {
		try {
			return upload(getDefaultBaseDir(), file, MimeTypeUtil.DEFAULT_ALLOWED_EXTENSION);
		} catch (Exception e) {
			throw new IOException(e.getMessage(), e);
		}
	}

	/**
	 * 根据文件路径上传
	 *
	 * @param baseDir 相对应用的基目录
	 * @param file    上传的文件
	 * @return 文件名称
	 * @throws IOException
	 */
	public static final String upload(String baseDir, MultipartFile file) throws IOException {
		try {
			return upload(baseDir, file, MimeTypeUtil.DEFAULT_ALLOWED_EXTENSION);
		} catch (Exception e) {
			throw new IOException(e.getMessage(), e);
		}
	}

	/**
	 * 文件上传
	 *
	 * @param baseDir          相对应用的基目录
	 * @param file             上传的文件
	 * @param allowedExtension 上传文件类型
	 * @return 返回上传成功的文件名
	 * @throws IOException 比如读写文件出错时
	 */
	public static final String upload(String baseDir, MultipartFile file, String[] allowedExtension)
		throws IOException {
		int fileNamelength = file.getOriginalFilename().length();
		if (fileNamelength > FileUploadUtil.DEFAULT_FILE_NAME_LENGTH) {
			throw new BizException("最大文件名长度：" + FileUploadUtil.DEFAULT_FILE_NAME_LENGTH);
		}

		assertAllowed(file, allowedExtension);

		String fileName = extractFilename(file);

		File desc = getAbsoluteFile(baseDir, fileName);
		file.transferTo(desc);
		String pathFileName = getPathFileName(baseDir, fileName);
		return pathFileName;
	}

	/**
	 * 编码文件名
	 */
	public static final String extractFilename(MultipartFile file) {
		String fileName = file.getOriginalFilename();
		String extension = getExtension(file);
		fileName = DateUtil.datePath() + StringUtil.SLASH + encodingFilename(fileName) + StrPool.DOT + extension;
		return fileName;
	}

	private static final File getAbsoluteFile(String uploadDir, String fileName) throws IOException {
		File desc = new File(uploadDir + File.separator + fileName).getCanonicalFile();

		if (!desc.getParentFile().exists()) {
			desc.getParentFile().mkdirs();
		}
		return desc;
	}

	private static final String getPathFileName(String uploadDir, String fileName) throws IOException {
		int dirLastIndex = uploadDir.lastIndexOf(StringUtil.SLASH) + 1;
		String currentDir = StringUtil.subSuf(uploadDir, dirLastIndex);
		String pathFileName = "/asset-file/" + currentDir + StringUtil.SLASH + fileName;
		return pathFileName;
	}

	/**
	 * 编码文件名
	 */
	private static final String encodingFilename(String fileName) {
		fileName = fileName.replace("_", " ");
		fileName = Md5Util.hash(fileName + System.nanoTime() + counter++);
		return fileName;
	}

	/**
	 * 文件大小校验
	 *
	 * @param file 上传的文件
	 * @return
	 */
	public static final void assertAllowed(MultipartFile file, String[] allowedExtension) {
		long size = file.getSize();
		if (DEFAULT_MAX_SIZE != -1 && size > DEFAULT_MAX_SIZE) {
			throw new BizException("最大上传文件大小：" + (DEFAULT_MAX_SIZE / 1024 / 1024));
		}

		String fileName = file.getOriginalFilename();
		String extension = getExtension(file);
		if (allowedExtension != null && !isAllowedExtension(extension, allowedExtension)) {
			throw new BizException(
				String.format("InvalidExtensionException : allowedExtension-{} extension-{} fileName-{}",
					allowedExtension, extension, fileName));
		}

	}

	/**
	 * 判断MIME类型是否是允许的MIME类型
	 *
	 * @param extension
	 * @param allowedExtension
	 * @return
	 */
	public static final boolean isAllowedExtension(String extension, String[] allowedExtension) {
		for (String str : allowedExtension) {
			if (str.equalsIgnoreCase(extension)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 获取文件名的后缀
	 *
	 * @param file 表单文件
	 * @return 后缀名
	 */
	public static final String getExtension(MultipartFile file) {
		String extension = FileUtil.extName(file.getOriginalFilename());
		if (StringUtil.isEmpty(extension)) {
			extension = MimeTypeUtil.getExtension(file.getContentType());
		}
		return extension;
	}

}
