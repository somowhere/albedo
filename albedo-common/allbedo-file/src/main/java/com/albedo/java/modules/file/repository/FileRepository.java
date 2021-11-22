package com.albedo.java.modules.file.repository;

import com.albedo.java.modules.file.entity.File;
import com.albedo.java.plugins.database.mybatis.repository.BaseRepository;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * Mapper 接口
 * 增量文件上传日志
 * </p>
 *
 * @author tangyh
 * @date 2021-06-30
 * @create [2021-06-30] [tangyh] [初始创建]
 */
@Repository
public interface FileRepository extends BaseRepository<File> {

}
