/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

import com.albedo.java.common.core.basic.domain.TreeEntity;
import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.tree.TreeUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.SelectVo;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.modules.sys.cache.DictCacheKeyBuilder;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.domain.dto.DictDto;
import com.albedo.java.modules.sys.domain.dto.DictQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.DictVo;
import com.albedo.java.modules.sys.repository.DictRepository;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.modules.sys.util.DictUtil;
import com.albedo.java.plugins.database.mybatis.service.impl.TreeCacheServiceImpl;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
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
@AllArgsConstructor
public class DictServiceImpl extends TreeCacheServiceImpl<DictRepository, Dict, DictDto>
	implements DictService {
	public final String CACHE_FIND_CODES = "findCodes";


	@Override
	public List<Dict> findAllOrderBySort() {
		return repository.selectList(Wrappers.<Dict>lambdaQuery().orderByAsc(Dict::getSort));
	}

	public Boolean exitUserByCode(DictDto dictDto) {
		return getOne(Wrappers.<Dict>query().ne(ObjectUtil.isNotEmpty(dictDto.getId()), DictDto.F_ID, dictDto.getId())
			.eq(DictDto.F_CODE, dictDto.getCode())) != null;
	}

	@Override
	public void saveOrUpdate(DictDto dictDto) {
		// code before comparing with database
		if (exitUserByCode(dictDto)) {
			throw new EntityExistException(DictDto.class, "code", dictDto.getCode());
		}
		super.saveOrUpdate(dictDto);
		cacheOps.del(new DictCacheKeyBuilder().key(CACHE_FIND_CODES));
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public Map<String, List<SelectVo>> findCodes(String codes) {
		CacheKey cacheKey = new DictCacheKeyBuilder().key(CACHE_FIND_CODES, codes);
		return cacheOps.get(cacheKey, (k) -> codes != null ?
			DictUtil.convertSelectVoMapByCodes(findAllOrderBySort(), codes.split(StringUtil.SPLIT_DEFAULT))
			: DictUtil.convertSelectVoMapByCodes(findAllOrderBySort()));
	}

	@Override
	public <Q> List<TreeNode> findTreeNode(Q queryCriteria) {
		return super.findTreeNode(queryCriteria);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public IPage<DictVo> findTreeList(DictQueryCriteria dictQueryCriteria) {
		List<DictVo> dictVoList = repository.findDictVoList(QueryWrapperUtil.<Dict>getWrapper(dictQueryCriteria)
			.eq(TreeEntity.F_SQL_DEL_FLAG, TreeEntity.FLAG_NORMAL).orderByAsc(TreeEntity.F_SQL_SORT));
		return new PageModel<>(Lists.newArrayList(TreeUtil.buildByLoopAutoRoot(dictVoList)), dictVoList.size());
	}

	@Override
	public void lockOrUnLock(Set<Long> ids) {
		List<Dict> dictList = Lists.newArrayList();
		repository.selectBatchIds(ids).forEach(dict -> {
			dictList.addAll(repository.selectList(
				Wrappers.<Dict>lambdaQuery().likeRight(Dict::getParentIds, TreeUtil.ROOT.equals(dict.getParentId())
					? (dict.getId() + ",") : (dict.getParentIds() + dict.getId()))));
			dictList.add(dict);
			repository.updateAvailableByIdList(dictList.stream().map(Dict::getId).collect(Collectors.toList()),
				CommonConstants.YES.equals(dict.getAvailable()) ? CommonConstants.NO : CommonConstants.YES);
		});
	}

	@Override
	protected CacheKeyBuilder cacheKeyBuilder() {
		return new DictCacheKeyBuilder();
	}

	@Override
	public boolean removeByIds(Collection<?> ids) {
		ids.forEach(id -> {
			// 查询父节点为当前节点的节点
			List<Dict> menuList = this.list(Wrappers.<Dict>query().lambda().eq(Dict::getParentId, id));
			if (CollUtil.isNotEmpty(menuList)) {
				throw new BizException("字典含有下级不能删除");
			}
		});
		boolean b = super.removeByIds(ids);
		cacheOps.del(new DictCacheKeyBuilder().key(CACHE_FIND_CODES));
		return b;
	}

}
