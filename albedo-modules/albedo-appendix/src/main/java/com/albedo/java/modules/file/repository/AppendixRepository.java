package com.albedo.java.modules.file.repository;

import com.albedo.java.modules.file.domain.Appendix;
import com.albedo.java.plugins.database.mybatis.repository.BaseRepository;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * Mapper 接口
 * 业务附件
 * </p>
 *
 * @author somewhere
 * @date 2021-06-30
 * @create [2021-06-30] [somewhere] [初始创建]
 */
@Mapper
public interface AppendixRepository extends BaseRepository<Appendix> {

}
