package com.albedo.java.modules.file.strategy.impl;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.exception.code.ResponseCode;
import com.albedo.java.common.core.util.DateUtil;
import com.albedo.java.common.core.util.StrPool;
import com.albedo.java.modules.file.domain.FileGetUrlBo;
import com.albedo.java.modules.file.entity.File;
import com.albedo.java.modules.file.properties.FileServerProperties;
import com.albedo.java.modules.file.repository.FileRepository;
import com.albedo.java.modules.file.strategy.FileStrategy;
import com.albedo.java.modules.file.utils.FileTypeUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.StringJoiner;
import java.util.UUID;


/**
 * 文件抽象策略 处理类
 *
 * @author somewhere
 * @date 2019/06/17
 */
@Slf4j
@RequiredArgsConstructor
public abstract class AbstractFileStrategy implements FileStrategy {

	private static final String FILE_SPLIT = ".";
	protected final FileServerProperties fileProperties;
	protected final FileRepository fileMapper;

	/**
	 * 上传文件
	 *
	 * @param multipartFile 文件
	 * @return 附件
	 */
	@Override
	public File upload(MultipartFile multipartFile, String bucket, String bizType) {
		try {
			if (!StrUtil.contains(multipartFile.getOriginalFilename(), FILE_SPLIT)) {
				throw BizException.wrap(ResponseCode.BASE_VALID_PARAM.build("文件缺少后缀名"));
			}

			File file = File.builder()
				.originalFileName(multipartFile.getOriginalFilename())
				.contentType(multipartFile.getContentType())
				.size(multipartFile.getSize())
				.bizType(bizType)
				.suffix(FilenameUtils.getExtension(multipartFile.getOriginalFilename()))
				.fileType(FileTypeUtil.getFileType(multipartFile.getContentType()))
				.build();
			uploadFile(file, multipartFile, bucket);
			return file;
		} catch (Exception e) {
			log.error("ex", e);
			throw BizException.wrap(ResponseCode.BASE_VALID_PARAM.build("文件上传失败"), e);
		}
	}

	/**
	 * 具体类型执行上传操作
	 *
	 * @param file          附件
	 * @param multipartFile 文件
	 * @param bucket        bucket
	 * @throws Exception 异常
	 */
	protected abstract void uploadFile(File file, MultipartFile multipartFile, String bucket) throws Exception;

	@Override
	public String getUrl(FileGetUrlBo fileGet) {
		return findUrl(Arrays.asList(fileGet)).get(fileGet.getPath());
	}

	/**
	 * 获取年月日 2020/09/01
	 *
	 * @return
	 */
	protected String getDateFolder() {
		return LocalDate.now().format(DateTimeFormatter.ofPattern(DateUtil.DATE_FORMAT_SLASH));
	}

	/**
	 * 企业/年/月/日/业务类型/唯一文件名
	 */
	protected String getPath(String bizType, String uniqueFileName) {
		return new StringJoiner(StrPool.SLASH).add(String.valueOf(ContextUtil.getTenant()))
			.add(bizType).add(getDateFolder()).add(uniqueFileName).toString();
	}

	protected String getUniqueFileName(File file) {
		return new StringJoiner(StrPool.DOT)
			.add(UUID.randomUUID().toString().replace("-", ""))
			.add(file.getSuffix()).toString();
	}
}
