
/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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

import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.domain.TreeDo;
import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.common.core.domain.vo.TreeNode;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.tree.TreeUtil;
import com.albedo.java.modules.sys.cache.DeptCacheKeyBuilder;
import com.albedo.java.modules.sys.domain.DeptDo;
import com.albedo.java.modules.sys.domain.DeptRelationDo;
import com.albedo.java.modules.sys.domain.RoleDo;
import com.albedo.java.modules.sys.domain.UserDo;
import com.albedo.java.modules.sys.domain.dto.DeptDto;
import com.albedo.java.modules.sys.domain.dto.DeptQueryDto;
import com.albedo.java.modules.sys.domain.vo.DeptVo;
import com.albedo.java.modules.sys.feign.RemoteDeptService;
import com.albedo.java.modules.sys.repository.DeptRepository;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.DeptRelationService;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.modules.sys.util.SysCacheUtil;
import com.albedo.java.plugins.database.mybatis.service.impl.AbstractTreeCacheServiceImpl;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p>
 * 部门管理 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@AllArgsConstructor
public class DeptServiceImpl extends AbstractTreeCacheServiceImpl<DeptRepository, DeptDo, DeptDto> implements DeptService, RemoteDeptService {

	private final DeptRelationService deptRelationService;

	private final UserRepository userRepository;

	private final RoleRepository roleRepository;

	/**
	 * 添加信息部门
	 *
	 * @param deptDto 部门
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void saveOrUpdate(DeptDto deptDto) {
		boolean add = ObjectUtil.isEmpty(deptDto.getId());
		super.saveOrUpdate(deptDto);
		if (add) {
			deptRelationService.saveDeptRelation(deptDto);
		} else {
			// 更新部门关系
			DeptRelationDo relation = new DeptRelationDo();
			relation.setAncestor(deptDto.getParentId());
			relation.setDescendant(deptDto.getId());
			deptRelationService.updateDeptRelation(relation);
		}
		SysCacheUtil.delDeptCaches(deptDto.getId());
	}

	/**
	 * 删除部门
	 *
	 * @param ids 部门 ID
	 * @return 成功、失败
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean removeByIds(Set<Long> ids) {
		repository.selectBatchIds(ids).forEach(dept -> {
			checkDept(dept.getId(), dept.getName());
		});
		ids.forEach(id -> {
			SysCacheUtil.delDeptCaches(id);
			// 级联删除部门
			Set<Long> idList = deptRelationService
				.list(Wrappers.<DeptRelationDo>query().lambda().eq(DeptRelationDo::getAncestor, id)).stream()
				.map(DeptRelationDo::getDescendant).collect(Collectors.toSet());

			if (CollUtil.isNotEmpty(idList)) {
				super.removeByIds(idList);
			}

			// 删除部门级联关系
			deptRelationService.removeDeptRelationById(id);
		});
		return Boolean.TRUE;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void lockOrUnLock(Set<Long> ids) {
		repository.selectBatchIds(ids).forEach(dept -> {
			checkDept(dept.getId(), dept.getName());
			dept.setAvailable(
				CommonConstants.YES.equals(dept.getAvailable()) ? CommonConstants.NO : CommonConstants.YES);
			repository.updateById(dept);
			SysCacheUtil.delDeptCaches(dept.getId());
		});
	}

	/**
	 * 检查角色是否有用户信息
	 *
	 * @return
	 */
	private void checkDept(Long deptId, String deptName) {
		List<UserDo> userDoList = userRepository.selectList(Wrappers.<UserDo>lambdaQuery().eq(UserDo::getDeptId, deptId));
		ArgumentAssert.empty(userDoList, () -> new BizException("操作失败！用户："
			+ CollUtil.convertToString(userDoList, UserDo.F_USERNAME, StringUtil.COMMA) + "所属要操作的部门：" + deptName));
		List<RoleDo> roleList = roleRepository.findListByDeptId(deptId);
		ArgumentAssert.empty(roleList, () -> new BizException("操作失败！角色：" + CollUtil.convertToString(roleList, RoleDo.F_NAME, StringUtil.COMMA)
			+ "的权限信息属于要操作的部门：" + deptName));
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<Long> findDescendantIdList(Long deptId) {
		CacheKey cacheKey = new DeptCacheKeyBuilder().key("findDescendantIdList", deptId);
		return cacheOps.get(cacheKey, (k) -> deptRelationService
			.list(Wrappers.<DeptRelationDo>query().lambda().eq(DeptRelationDo::getAncestor, deptId)).stream()
			.map(DeptRelationDo::getDescendant).collect(Collectors.toList()));
	}

	@Override
	public <Q> List<TreeNode<?>> findTreeNode(Q queryCriteria) {
		return super.getNodeTree(repository.selectList(QueryWrapperUtil.<DeptDo>getWrapper(queryCriteria).lambda()
			.eq(DeptDo::getAvailable, CommonConstants.STR_YES).orderByAsc(DeptDo::getSort)));
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public IPage<DeptVo> findTreeList(DeptQueryDto deptQueryDto) {
		List<DeptVo> deptVoList = repository.findVoList(QueryWrapperUtil.<DeptDo>getWrapper(deptQueryDto)
			.eq(TreeDo.F_SQL_DEL_FLAG, TreeDo.FLAG_NORMAL).orderByAsc(TreeDo.F_SQL_SORT));
		return new PageModel<>(Lists.newArrayList(TreeUtil.buildByLoopAutoRoot(deptVoList)), deptVoList.size());
	}

	@Override
	protected CacheKeyBuilder cacheKeyBuilder() {
		return new DeptCacheKeyBuilder();
	}
}
