package com.albedo.java.modules.file.repository;

import com.albedo.java.modules.file.domain.Appendix;
import com.albedo.java.plugins.mybatis.repository.BaseRepository;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * Mapper 接口
 * 业务附件
 * </p>
 *
 * @author tangyh
 * @date 2021-06-30
 * @create [2021-06-30] [tangyh] [初始创建]
 */
@Repository
public interface AppendixRepository extends BaseRepository<Appendix> {

}
