package com.albedo.java.modules.gen.repository;

import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.modules.gen.domain.Scheme;
import com.albedo.java.modules.gen.domain.vo.SchemeVo;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority domain.
 */
public interface SchemeRepository extends BaseRepository<Scheme> {

	/**
	 * 分页查询方案信息
	 *
	 * @param page    分页
	 * @param wrapper 查询参数
	 * @return list
	 */
	IPage<List<SchemeVo>> getSchemeVoPage(IPage page, @Param("ew") Wrapper wrapper);
}
