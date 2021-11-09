package com.albedo.java.modules.file.utils;


import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.enumeration.FileTypeEnum;
import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * 根据类型识别工具
 *
 * @author somewhere
 * @date 2019-05-06
 */
@Slf4j
public final class FileTypeUtil {
	private static final DateTimeFormatter DTF = DateTimeFormatter.ofPattern("yyyy/MM");
	private static final String IMAGE = "image";
	private static final String VIDEO = "video";
	private static final String AUDIO = "audio";
	private static final String TEXT = "text";
	private static final String[] TEXT_MIME = {
		"application/vnd.ms-excel",
		"application/msword",
		"application/pdf",
		"application/vnd.ms-project",
		"application/vnd.ms-works",
		"application/x-javascript",
		"application/vnd.openxmlformats-officedocument",
		"application/vnd.ms-word.document.macroEnabled",
		"application/vnd.ms-word.template.macroEnabled",
		"application/vnd.ms-powerpoint"
	};

	private FileTypeUtil() {
	}

	/**
	 * 根据mine类型，返回文件类型
	 *
	 * @param contentType 类型
	 * @author somewhere
	 * @date 2019-05-06 13:41
	 */
	public static FileTypeEnum getFileType(String contentType) {
		if (contentType == null || "".equals(contentType)) {
			return FileTypeEnum.OTHER;
		}
		if (contentType.contains(IMAGE)) {
			return FileTypeEnum.IMAGE;
		} else if (contentType.contains(TEXT) || StrUtil.startWithAny(contentType, TEXT_MIME)) {
			return FileTypeEnum.DOC;
		} else if (contentType.contains(VIDEO)) {
			return FileTypeEnum.VIDEO;
		} else if (contentType.contains(AUDIO)) {
			return FileTypeEnum.AUDIO;
		} else {
			return FileTypeEnum.OTHER;
		}
	}

	public static String getUploadPathPrefix(String uploadPathPrefix) {
		//日期文件夹
		String secDir = LocalDate.now().format(DTF);
		// web服务器存放的绝对路径
		return Paths.get(uploadPathPrefix, secDir).toString();
	}

	public static String getRelativePath(String pathPrefix, String path) {
		String fileName = StrUtil.subAfter(path, "/", true);
		return StrUtil.subBetween(path, pathPrefix + File.separator, File.separator + fileName);
	}

}
