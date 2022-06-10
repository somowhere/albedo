package com.albedo.java.modules.file.strategy.impl.minio;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.modules.file.domain.FileDo;
import com.albedo.java.modules.file.domain.dto.FileChunksMergeDto;
import com.albedo.java.modules.file.properties.FileServerProperties;
import com.albedo.java.modules.file.repository.FileRepository;
import com.albedo.java.modules.file.strategy.impl.AbstractFileChunkStrategy;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.util.List;

/**
 * 欢迎PR
 * <p>
 * 思路1：minIO的putObject自身就支持断点续传， 所以先将分片文件上传到文件服务器并合并成大文件后， 在将大文件通过putObject直接上传到minIO
 *
 * @author somewhere
 * @date 2020/11/22 5:02 下午
 */
@Slf4j
public class MinIoFileChunkStrategyImpl extends AbstractFileChunkStrategy {
	public MinIoFileChunkStrategyImpl(FileRepository fileMapper, FileServerProperties fileProperties) {
		super(fileMapper, fileProperties);
	}


	@Override
	protected void copyFile(FileDo fileDo) {

	}


	@Override
	protected Result<FileDo> merge(List<java.io.File> files, String path, String fileName, FileChunksMergeDto info) throws IOException {

		FileDo fileDoPo = FileDo.builder()
//                .relativePath(relativePath)
//                .url(StrUtil.replace(url, "\\\\", StrPool.SLASH))
			.build();
		return Result.buildOkData(fileDoPo);
	}
}
