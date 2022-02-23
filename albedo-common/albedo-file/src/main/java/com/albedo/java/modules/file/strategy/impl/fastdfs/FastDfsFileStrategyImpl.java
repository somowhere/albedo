package com.albedo.java.modules.file.strategy.impl.fastdfs;


import com.albedo.java.common.core.util.MapHelper;
import com.albedo.java.common.core.util.StrPool;
import com.albedo.java.modules.file.domain.FileDeleteBo;
import com.albedo.java.modules.file.domain.FileGetUrlBo;
import com.albedo.java.modules.file.domain.File;
import com.albedo.java.modules.file.domain.enums.FileStorageType;
import com.albedo.java.modules.file.properties.FileServerProperties;
import com.albedo.java.modules.file.repository.FileRepository;
import com.albedo.java.modules.file.strategy.impl.AbstractFileStrategy;
import com.github.tobato.fastdfs.domain.fdfs.StorePath;
import com.github.tobato.fastdfs.service.FastFileStorageClient;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @author somewhere
 * @date 2020/11/22 5:17 下午
 */

@Component("FAST_DFS")
public class FastDfsFileStrategyImpl extends AbstractFileStrategy {
	private final FastFileStorageClient storageClient;

	public FastDfsFileStrategyImpl(FileServerProperties fileProperties, FastFileStorageClient storageClient,
								   FileRepository fileMapper) {
		super(fileProperties, fileMapper);
		this.storageClient = storageClient;
	}

	@Override
	protected void uploadFile(File file, MultipartFile multipartFile, String bucket) throws Exception {
		StorePath storePath = storageClient.uploadFile(multipartFile.getInputStream(), multipartFile.getSize(), file.getSuffix(), null);
		file.setUrl(fileProperties.getFastDfs().getUrlPrefix() + storePath.getFullPath());
		file.setBucket(storePath.getGroup());
		file.setPath(storePath.getPath());
		file.setStorageType(FileStorageType.FAST_DFS);
	}

	@Override
	public boolean delete(FileDeleteBo file) {
		storageClient.deleteFile(file.getBucket(), file.getPath());
		return true;
	}

	@Override
	public Map<String, String> findUrl(List<FileGetUrlBo> fileGets) {
		Map<String, String> map = new LinkedHashMap<>(MapHelper.initialCapacity(fileGets.size()));
		// 方式1 取上传时存的url （多查询一次数据库）
//        List<String> paths = fileGets.stream().map(FileGetUrlBO::getPath).collect(Collectors.toList());
//        List<File> list = fileMapper.selectList(Wraps.<File>lbQ().eq(File::getPath, paths));
//        list.forEach(item -> map.put(item.getPath(), item.getUrl()));

		// 方式2 重新拼接 （urlPrefix 可能跟上传时不一样）
		FileServerProperties.FastDfs fastDfs = fileProperties.getFastDfs();
		fileGets.forEach(item -> {
			StringBuilder url = new StringBuilder(fastDfs.getUrlPrefix())
				.append(item.getBucket())
				.append(StrPool.SLASH)
				.append(item.getPath());
			map.put(item.getPath(), url.toString());
		});
		return map;
	}
}

