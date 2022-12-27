package com.albedo.java.modules.file.strategy;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.MapHelper;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.StrPool;
import com.albedo.java.modules.file.domain.FileDeleteBo;
import com.albedo.java.modules.file.domain.FileDo;
import com.albedo.java.modules.file.domain.FileGetUrlBo;
import com.albedo.java.modules.file.domain.dto.FileChunksMergeDto;
import com.albedo.java.modules.file.domain.enums.FileStorageType;
import com.albedo.java.modules.file.domain.vo.param.FileUploadVo;
import com.albedo.java.modules.file.properties.FileServerProperties;
import com.albedo.java.modules.file.repository.FileRepository;
import com.albedo.java.modules.file.utils.ZipUtils;
import com.albedo.java.plugins.database.mybatis.conditions.Wraps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.toList;

/**
 * @author somewhere
 * @date 2021/7/8 10:26
 */
@Slf4j
@Component
public class FileContext {
	private final Map<String, FileStrategy> contextStrategyMap = new ConcurrentHashMap<>();
	private final Map<String, FileChunkStrategy> contextChunkStrategyMap = new ConcurrentHashMap<>();
	private final FileServerProperties fileServerProperties;
	private final FileRepository fileMapper;

	public FileContext(Map<String, FileStrategy> map,
					   Map<String, FileChunkStrategy> chunkMap,
					   FileServerProperties fileServerProperties,
					   FileRepository fileMapper) {
		map.forEach(this.contextStrategyMap::put);
		chunkMap.forEach(this.contextChunkStrategyMap::put);
		this.fileServerProperties = fileServerProperties;
		this.fileMapper = fileMapper;
	}

	private static Predicate<FileDo> getFilePredicate() {
		return file -> file != null && StrUtil.isNotEmpty(file.getUrl());
	}

	private static String buildNewFileName(String filename, Integer order) {
		return StrUtil.strBuilder(filename).insert(filename.lastIndexOf(StrPool.DOT), "(" + order + ")").toString();
	}

	/**
	 * 文件上传
	 *
	 * @param file         文件
	 * @param fileUploadVo 文件上传参数
	 * @return 文件对象
	 */
	public FileDo upload(MultipartFile file, FileUploadVo fileUploadVo) {
		FileStrategy fileStrategy = getFileStrategy(fileUploadVo.getStorageType());
		return fileStrategy.upload(file, fileUploadVo.getBucket(), fileUploadVo.getBizType());
	}

	private FileStrategy getFileStrategy(FileStorageType storageType) {
		storageType = storageType == null ? fileServerProperties.getStorageType() : storageType;
		FileStrategy fileStrategy = contextStrategyMap.get(storageType.name());
		ArgumentAssert.notNull(fileStrategy, "请配置正确的文件存储类型");
		return fileStrategy;
	}

	/**
	 * 删除源文件
	 *
	 * @param list 列表
	 * @return 是否成功
	 */
	public boolean delete(List<FileDo> list) {
		if (!fileServerProperties.getDelFile()) {
			return false;
		}

		list.forEach(item -> {
			FileDeleteBo fileDeleteBo = FileDeleteBo.builder()
				.bucket(item.getBucket())
				.path(item.getPath())
				.storageType(item.getStorageType())
				.build();
			FileStrategy fileStrategy = getFileStrategy(item.getStorageType());
			fileStrategy.delete(fileDeleteBo);
		});
		return true;
	}

	/**
	 * 根据路径获取访问地址
	 *
	 * @param paths 文件查询对象
	 * @return
	 */
	public Map<String, String> findUrlByPath(List<String> paths) {
		List<FileDo> pathFileDos = fileMapper.selectList(Wraps.<FileDo>lambdaQueryWrapperX().in(FileDo::getPath, paths));

		return findUrl(pathFileDos);
	}

	private Map<String, String> findUrl(List<FileDo> pathFileDos) {
		Map<String, List<FileDo>> pathMap = pathFileDos.stream().collect(Collectors.groupingBy(FileDo::getPath, LinkedHashMap::new, toList()));

		Map<String, String> map = new LinkedHashMap<>(MapHelper.initialCapacity(pathMap.size()));
		pathMap.forEach((path, files) -> {
			if (CollUtil.isEmpty(files)) {
				return;
			}
			FileDo fileFileDo = files.get(0);

			if (FileStorageType.LOCAL.eq(fileFileDo.getStorageType())) {
				map.put(path, fileFileDo.getUrl());
			} else {
				FileStrategy fileStrategy = getFileStrategy(fileFileDo.getStorageType());
				map.put(path, fileStrategy.getUrl(FileGetUrlBo.builder()
					.bucket(fileFileDo.getBucket())
					.path(fileFileDo.getPath())
					.originalFileName(fileFileDo.getOriginalFileName())
					.build()));
			}
		});
		return map;
	}

	public Map<Long, String> findUrlById(List<Long> ids) {
		List<FileDo> pathFileDos = fileMapper.selectList(Wraps.<FileDo>lambdaQueryWrapperX().in(FileDo::getId, ids));

		Map<Long, List<FileDo>> pathMap = pathFileDos.stream().collect(Collectors.groupingBy(FileDo::getId, LinkedHashMap::new, toList()));

		Map<Long, String> map = new LinkedHashMap<>(MapHelper.initialCapacity(pathMap.size()));
		pathMap.forEach((id, files) -> {
			if (CollUtil.isEmpty(files)) {
				return;
			}
			FileDo fileFileDo = files.get(0);

			FileStrategy fileStrategy = getFileStrategy(fileFileDo.getStorageType());
			map.put(id, fileStrategy.getUrl(FileGetUrlBo.builder()
				.bucket(fileFileDo.getBucket())
				.path(fileFileDo.getPath())
				.originalFileName(fileFileDo.getOriginalFileName())
				.build()));
		});
		return map;
	}

	public void download(HttpServletRequest request, HttpServletResponse response, List<FileDo> list) throws Exception {
		for (FileDo fileFileDo : list) {
			FileStrategy fileStrategy = getFileStrategy(fileFileDo.getStorageType());
			String url = fileStrategy.getUrl(FileGetUrlBo.builder()
				.bucket(fileFileDo.getBucket())
				.path(fileFileDo.getPath())
				.build());
			fileFileDo.setUrl(url);
		}
		down(request, response, list);
	}

	public void down(HttpServletRequest request, HttpServletResponse response, List<FileDo> list) throws Exception {
		long fileSize = list.stream().filter(getFilePredicate())
			.mapToLong(file -> Convert.toLong(file.getSize(), 0L)).sum();
		String packageName = list.get(0).getOriginalFileName();
		if (list.size() > 1) {
			packageName = StrUtil.subBefore(packageName, ".", true) + "等.zip";
		}

		Map<String, String> map = new LinkedHashMap<>(MapHelper.initialCapacity(list.size()));
		Map<String, Integer> duplicateFile = new HashMap<>(map.size());
		list.stream()
			//过滤不符合要求的文件
			.filter(getFilePredicate())
			//循环处理相同的文件名
			.forEach(file -> {
				String originalFileName = file.getOriginalFileName();
				if (map.containsKey(originalFileName)) {
					if (duplicateFile.containsKey(originalFileName)) {
						duplicateFile.put(originalFileName, duplicateFile.get(originalFileName) + 1);
					} else {
						duplicateFile.put(originalFileName, 1);
					}
					originalFileName = buildNewFileName(originalFileName, duplicateFile.get(originalFileName));
				}
				map.put(originalFileName, file.getUrl());
			});


		ZipUtils.zipFilesByInputStream(map, fileSize, packageName, request, response);
	}

	private FileChunkStrategy getFileChunkStrategy(FileStorageType storageType) {
		storageType = storageType == null ? fileServerProperties.getStorageType() : storageType;
		FileChunkStrategy fileStrategy = contextChunkStrategyMap.get(storageType.name());
		ArgumentAssert.notNull(fileStrategy, "请配置正确的文件存储类型");
		return fileStrategy;
	}

	/**
	 * 根据md5检测文件
	 *
	 * @param md5    md5
	 * @param userId 用户id
	 * @return 附件
	 */
	public FileDo md5Check(String md5, Long userId) {
		FileChunkStrategy fileChunkStrategy = getFileChunkStrategy(fileServerProperties.getStorageType());
		return fileChunkStrategy.md5Check(md5, userId);
	}

	/**
	 * 合并文件
	 *
	 * @param merge 合并参数
	 * @return 附件
	 */
	public Result<FileDo> chunksMerge(FileChunksMergeDto merge) {
		FileChunkStrategy fileChunkStrategy = getFileChunkStrategy(fileServerProperties.getStorageType());
		return fileChunkStrategy.chunksMerge(merge);
	}
}
