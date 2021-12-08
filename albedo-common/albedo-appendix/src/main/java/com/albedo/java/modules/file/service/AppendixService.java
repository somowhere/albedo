package com.albedo.java.modules.file.service;

import com.albedo.java.common.core.basic.domain.IdEntity;
import com.albedo.java.common.core.vo.AppendixDto;
import com.albedo.java.common.core.vo.AppendixVo;
import com.albedo.java.common.core.vo.EchoVo;
import com.albedo.java.modules.file.domain.Appendix;
import com.albedo.java.plugins.database.mybatis.service.DataService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.google.common.collect.Multimap;
import lombok.*;
import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 * 业务接口
 * 业务附件
 * </p>
 *
 * @author somewhere
 * @date 2021-06-30
 * @create [2021-06-30] [somewhere] [初始创建]
 */
public interface AppendixService extends DataService<Appendix, AppendixDto> {

	/**
	 * 回显附件
	 *
	 * @param page     分页数据
	 * @param bizTypes 业务类型
	 * @author somewhere
	 * @date 2021/8/28 3:53 下午
	 * @create [2021/8/28 3:53 下午 ] [somewhere] [初始创建]
	 */
	<T extends IdEntity<T, Long> & EchoVo> void echoAppendix(IPage<T> page, String... bizTypes);

	/**
	 * 回显附件
	 *
	 * @param list     列表数据
	 * @param bizTypes 业务类型
	 * @author somewhere
	 * @date 2021/8/28 3:53 下午
	 * @create [2021/8/28 3:53 下午 ] [somewhere] [初始创建]
	 */
	<T extends IdEntity<T, Long> & EchoVo> void echoAppendix(List<T> list, String... bizTypes);

	/**
	 * 构建 listByObjectId 方法的key
	 *
	 * @param bizId   对象id
	 * @param bizType 功能点
	 * @return
	 */
	default AppendixBizKey buildBiz(@NonNull Long bizId, @NonNull String bizType) {
		return AppendixBizKey.builder().bizId(bizId).bizType(bizType).build();
	}

	/**
	 * 根据对象id 和 任意个功能点 查询附件
	 * <p>
	 * 返回值为：
	 * bizId + bizType -> [附件, ...]
	 *
	 * @param bizId   对象id
	 * @param bizType 功能点
	 * @return
	 */
	Multimap<AppendixBizKey, AppendixVo> listByBizId(@NonNull Long bizId, @Nullable String... bizType);

	/**
	 * 根据对象id 和 任意个功能点 查询附件
	 * <p>
	 * 返回值为：
	 * bizId + bizType -> [附件, ...]
	 *
	 * @param bizIds  对象id
	 * @param bizType 功能点
	 * @return
	 */
	Multimap<AppendixBizKey, AppendixVo> listByBizIds(@NonNull List<Long> bizIds, @Nullable String... bizType);

	/**
	 * 根据对象id 和 功能点 查询附件
	 * <p>
	 * 返回值为： [附件, ...]
	 *
	 * @param bizId   对象id
	 * @param bizType 功能点
	 * @return
	 */
	List<AppendixVo> listByBizIdAndBizType(@NonNull Long bizId, @NonNull String bizType);

	/**
	 * 根据对象id 和 功能点查询附件， 若查到多个附件，也只返回一个。
	 * <p>
	 * 请业务方自行确保该功能点的附件始终只有一个。
	 *
	 * @param bizId
	 * @param bizType
	 * @return
	 */
	AppendixVo getByBiz(@NonNull Long bizId, @NonNull String bizType);

	/**
	 * 新增附件信息
	 * <p>
	 * 逻辑：
	 * 1. 若objectId不为空， 根据objectId，删除附件记录
	 * 2. 若附件信息不为为空， 保存最新的附件信息
	 *
	 * @param bizId       业务id
	 * @param appendixDto 附件
	 * @return 是否成功
	 */
	Boolean save(@Nullable Long bizId, @Nullable AppendixDto appendixDto);

	/**
	 * 新增附件信息
	 * 就算你的一个表单有多个附件字段，也合并成一个list传给我
	 *
	 * <p>
	 * 逻辑：
	 * 1. 若objectId不为空， 根据objectId，删除附件记录
	 * 2. 若附件信息不为为空， 保存最新的附件信息
	 *
	 * @param bizId           业务id
	 * @param appendixDtoList 附件
	 * @return 是否成功
	 */
	Boolean save(@Nullable Long bizId, @Nullable List<AppendixDto> appendixDtoList);

	/**
	 * 新增附件信息
	 * 就算你的一个表单有多个附件字段，也合并成一个list传给我
	 *
	 * <p>
	 * 逻辑：
	 * 1. 若objectId不为空， 根据objectId，删除附件记录
	 * 2. 若附件信息不为为空， 保存最新的附件信息
	 *
	 * @param bizId           业务id
	 * @param bizType         功能点
	 * @param appendixDtoList 附件
	 * @return 是否成功
	 */
	Boolean save(@Nullable Long bizId, @Nullable String bizType, @Nullable List<AppendixDto> appendixDtoList);

	/**
	 * 根据对象id批量删除附件
	 *
	 * @param bizIds 对象id
	 * @return
	 */
	boolean removeByBizId(@NonNull List<Long> bizIds);

	/**
	 * 根据对象id批量删除附件
	 *
	 * @param bizIds 对象id
	 * @return
	 */
	boolean removeByBizId(@NonNull Long... bizIds);

	/**
	 * 根据对象id批量删除附件
	 *
	 * @param bizId   对象id
	 * @param bizType 对象id
	 * @return
	 */
	boolean removeByBizId(Long bizId, String bizType);

	@Data
	@Builder
	@NoArgsConstructor
	@AllArgsConstructor
	@ToString
	class AppendixBizKey implements Serializable {
		private Long bizId;
		private String bizType;
	}
}
