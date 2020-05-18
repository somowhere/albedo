/*
 *  Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.common.core.annotation.BaseInit;
import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.BadRequestException;
import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.tree.TreeUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.SelectResult;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.service.impl.TreeServiceImpl;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.domain.dto.DictDto;
import com.albedo.java.modules.sys.domain.dto.DictQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.DictVo;
import com.albedo.java.modules.sys.repository.DictRepository;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.modules.sys.util.DictUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p>
 * 字典表 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@BaseInit(method = "refresh")
@CacheConfig(cacheNames = CacheNameConstants.DICT_DETAILS)
public class DictServiceImpl extends
	TreeServiceImpl<DictRepository, Dict, DictDto> implements DictService {

	@Autowired
	private CacheManager cacheManager;

	@Cacheable
	public List<Dict> findAllOrderBySort() {
		return repository.selectList(Wrappers.<Dict>query().lambda().orderByAsc(
			Dict::getSort
		));
	}

	public Boolean exitUserByCode(DictDto dictDto) {
		return getOne(Wrappers.<Dict>query()
			.ne(StringUtil.isNotEmpty(dictDto.getId()), DictDto.F_ID, dictDto.getId())
			.eq(DictDto.F_CODE, dictDto.getCode())) != null;
	}

	@Override
	@CacheEvict(allEntries = true)
	public void saveOrUpdate(DictDto dictDto) {
		// code before comparing with database
		if (exitUserByCode(dictDto)) {
			throw new EntityExistException(DictDto.class, "code", dictDto.getCode());
		}

		super.saveOrUpdate(dictDto);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public Map<String, List<SelectResult>> findCodeStr(String codes) {
		return findCodes(StringUtil.isNotEmpty(codes) ?
			codes.split(StringUtil.SPLIT_DEFAULT) : null);
	}

	@Override
	@Cacheable(key = "'" + CacheNameConstants.DICT_RESULT_ALL + "'")
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public Map<String, List<SelectResult>> findCodes(String... codes) {
		return DictUtil.getSelectResultListByCodes(findAllOrderBySort(), codes);
	}

	@Override
	public void refresh() {
		Cache cache = cacheManager.getCache(CacheNameConstants.DICT_DETAILS);
		if (cache == null || cache.get(CacheNameConstants.DICT_ALL) == null ||
			ObjectUtil.isEmpty(cache.get(CacheNameConstants.DICT_ALL))) {
			List<Dict> dictList = findAllOrderBySort();
			cache.put(CacheNameConstants.DICT_ALL, dictList);
		}
	}

	@Override
	@Cacheable
	public <Q> List<TreeNode> findTreeNode(Q queryCriteria) {
		return super.findTreeNode(queryCriteria);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public IPage<DictVo> findTreeList(DictQueryCriteria dictQueryCriteria) {
		List<DictVo> dictVoList = repository.findDictVoList(QueryWrapperUtil.<Dict>getWrapper(dictQueryCriteria)
			.eq(TreeEntity.F_SQL_DELFLAG, TreeEntity.FLAG_NORMAL).orderByAsc(TreeEntity.F_SQL_SORT));
		return new PageModel<>(Lists.newArrayList(TreeUtil.buildByLoopAutoRoot(dictVoList)),
			dictVoList.size());
	}

	@Override
	@CacheEvict(allEntries = true)
	public void lockOrUnLock(Set<String> ids) {
		List<Dict> dictList = Lists.newArrayList();
		repository.selectBatchIds(ids).forEach(dict -> {
			dictList.addAll(repository.selectList(Wrappers.<Dict>lambdaQuery().likeRight(Dict::getParentIds,
				TreeUtil.ROOT.equals(dict.getParentId()) ? (dict.getId() + ",") : (dict.getParentIds() + dict.getId()))));
			dictList.add(dict);
			repository.updateAvailableByIdList(dictList.stream().map(Dict::getId).collect(Collectors.toList()),
				CommonConstants.YES.equals(dict.getAvailable()) ? CommonConstants.NO : CommonConstants.YES);
		});
	}

	@Override
	@CacheEvict(allEntries = true)
	public boolean removeByIds(Collection<? extends Serializable> ids) {
		ids.forEach(id -> {
			// 查询父节点为当前节点的节点
			List<Dict> menuList = this.list(Wrappers.<Dict>query()
				.lambda().eq(Dict::getParentId, id));
			if (CollUtil.isNotEmpty(menuList)) {
				throw new BadRequestException("字典含有下级不能删除");
			}
		});
		return super.removeByIds(ids);
	}
}
