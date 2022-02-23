package com.albedo.java.modules.file.strategy.impl.local;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.util.MapHelper;
import com.albedo.java.common.core.util.StrPool;
import com.albedo.java.modules.file.domain.FileDeleteBo;
import com.albedo.java.modules.file.domain.FileGetUrlBo;
import com.albedo.java.modules.file.domain.File;
import com.albedo.java.modules.file.domain.enums.FileStorageType;
import com.albedo.java.modules.file.properties.FileServerProperties;
import com.albedo.java.modules.file.repository.FileRepository;
import com.albedo.java.modules.file.strategy.impl.AbstractFileStrategy;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @author somewhere
 * @date 2020/11/22 5:00 下午
 */
@Slf4j

@Component("LOCAL")
public class LocalFileStrategyImpl extends AbstractFileStrategy {
	public LocalFileStrategyImpl(FileServerProperties fileProperties, FileRepository fileMapper) {
		super(fileProperties, fileMapper);
	}

	@Override
	protected void uploadFile(File file, MultipartFile multipartFile, String bucket) throws Exception {
		FileServerProperties.Local local = fileProperties.getLocal();
		bucket = StrUtil.isEmpty(bucket) ? local.getBucket() : bucket;

		//生成文件名
		String uniqueFileName = getUniqueFileName(file);
		// 相对路径
		String path = getPath(file.getBizType(), uniqueFileName);
		// web服务器存放的绝对路径
		String absolutePath = Paths.get(local.getStoragePath(), bucket, path).toString();

		// 存储文件
		java.io.File outFile = new java.io.File(absolutePath);
		FileUtils.writeByteArrayToFile(outFile, multipartFile.getBytes());

		// 返回数据
		String url = local.getUrlPrefix() + bucket + StrPool.SLASH + path;
		file.setUrl(url);
		file.setUniqueFileName(uniqueFileName);
		file.setPath(path);
		file.setBucket(bucket);
		file.setStorageType(FileStorageType.LOCAL);
	}

	@Override
	public boolean delete(FileDeleteBo file) {
		FileServerProperties.Local local = fileProperties.getLocal();
		java.io.File ioFile = new java.io.File(Paths.get(local.getStoragePath(), file.getBucket(), file.getPath()).toString());
		FileUtils.deleteQuietly(ioFile);
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
		FileServerProperties.Local local = fileProperties.getLocal();
		fileGets.forEach(item -> {
			StringBuilder url = new StringBuilder(local.getUrlPrefix())
				.append(item.getBucket())
				.append(StrPool.SLASH)
				.append(item.getPath());
			map.put(item.getPath(), url.toString());
		});
		return map;
	}
}
