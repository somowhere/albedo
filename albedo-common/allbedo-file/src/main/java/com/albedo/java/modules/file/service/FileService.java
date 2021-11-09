package com.albedo.java.modules.file.service;

import com.albedo.java.modules.file.entity.File;
import com.albedo.java.modules.file.vo.param.FileUploadVo;
import com.albedo.java.modules.file.vo.result.FileResultVo;
import com.albedo.java.plugins.mybatis.service.BaseService;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 业务接口
 * 增量文件上传日志
 * </p>
 *
 * @author tangyh
 * @date 2021-06-30
 * @create [2021-06-30] [tangyh] [初始创建]
 */
public interface FileService extends BaseService<File> {

	/**
	 * 上传附件
	 *
	 * @param file         文件
	 * @param attachmentVO 参数
	 * @return 附件
	 */
	FileResultVo upload(MultipartFile file, FileUploadVo attachmentVO);

	/**
	 * 获取文件的临时访问链接
	 *
	 * @param paths 文件相对路径
	 * @return
	 */
	Map<String, String> findUrlByPath(List<String> paths);

	/**
	 * 获取文件的临时访问链接
	 *
	 * @param ids 文件id
	 * @return
	 */
	Map<Long, String> findUrlById(List<Long> ids);

	/**
	 * 下载文件
	 *
	 * @param request  请求头
	 * @param response 响应头
	 * @param ids      文件id
	 * @throws Exception
	 */
	void download(HttpServletRequest request, HttpServletResponse response, List<Long> ids) throws Exception;
}
