package com.albedo.java.modules.file.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.BeanUtil;
import com.albedo.java.modules.file.domain.vo.param.FileUploadVo;
import com.albedo.java.modules.file.domain.vo.result.FileResultVo;
import com.albedo.java.modules.file.entity.File;
import com.albedo.java.modules.file.repository.FileRepository;
import com.albedo.java.modules.file.service.FileService;
import com.albedo.java.modules.file.strategy.FileContext;
import com.albedo.java.plugins.database.mybatis.service.impl.BaseServiceImpl;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 业务实现类
 * 增量文件上传日志
 * </p>
 *
 * @author somewhere
 * @date 2021-06-30
 * @create [2021-06-30] [somewhere] [初始创建]
 */
@Slf4j
@Service
@Transactional(readOnly = true)

public class FileServiceImpl extends BaseServiceImpl<FileRepository, File> implements FileService {
	@Resource
	private FileContext fileContext;


	@Override
	@Transactional(rollbackFor = Exception.class)
	public FileResultVo upload(MultipartFile file, FileUploadVo fileUploadVO) {
		File fileFile = fileContext.upload(file, fileUploadVO);
		save(fileFile);
		return BeanUtil.toBean(fileFile, FileResultVo.class);
	}

	@Override
	public Map<String, String> findUrlByPath(List<String> paths) {
		return fileContext.findUrlByPath(paths);
	}

	@Override
	public Map<Long, String> findUrlById(List<Long> paths) {
		return fileContext.findUrlById(paths);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean removeByIds(Collection<? extends Serializable> ids) {
		if (CollUtil.isEmpty(ids)) {
			return false;
		}
		List<File> list = list(Wrappers.<File>lambdaQuery().in(File::getId, ids));
		if (list.isEmpty()) {
			return false;
		}
		super.removeByIds(ids);
		return fileContext.delete(list);
	}

	@Override
	public void download(HttpServletRequest request, HttpServletResponse response, List<Long> ids) throws Exception {
		List<File> list = listByIds(ids);
		ArgumentAssert.notEmpty(list, "请配置正确的文件存储类型");

		fileContext.download(request, response, list);
	}
}
