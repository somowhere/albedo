package com.albedo.java.modules.file.strategy;

import com.albedo.java.modules.file.domain.FileDeleteBo;
import com.albedo.java.modules.file.domain.FileDo;
import com.albedo.java.modules.file.domain.FileGetUrlBo;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * 文件策略接口
 *
 * @author somewhere
 * @date 2019/06/17
 */
public interface FileStrategy {
	/**
	 * 文件上传
	 *
	 * @param file    文件
	 * @param bucket  桶
	 * @param bizType 业务类型
	 * @return 文件对象
	 */
	FileDo upload(MultipartFile file, String bucket, String bizType);

	/**
	 * 删除源文件
	 *
	 * @param fileDeleteBo 待删除文件
	 * @return 是否成功
	 */
	boolean delete(FileDeleteBo fileDeleteBo);

	/**
	 * 根据路径获取访问地址
	 *
	 * @param fileGets 文件查询对象
	 * @return
	 */
	Map<String, String> findUrl(List<FileGetUrlBo> fileGets);

	/**
	 * 根据路径获取访问地址
	 *
	 * @param fileGet 文件查询对象
	 * @return
	 */
	String getUrl(FileGetUrlBo fileGet);
}
