package com.albedo.java.modules.file.repository;

import com.albedo.java.modules.file.domain.FileDo;
import com.albedo.java.plugins.database.mybatis.repository.BaseRepository;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * Mapper 接口
 * 增量文件上传日志
 * </p>
 *
 * @author somewhere
 * @date 2021-06-30
 * @create [2021-06-30] [somewhere] [初始创建]
 */
@Mapper
public interface FileRepository extends BaseRepository<FileDo> {

}
