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
import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.tree.TreeUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.modules.sys.domain.Dept;
import com.albedo.java.modules.sys.domain.DeptRelation;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.dto.DeptDto;
import com.albedo.java.modules.sys.domain.dto.DeptQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.DeptVo;
import com.albedo.java.modules.sys.repository.DeptRepository;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.DeptRelationService;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.modules.sys.util.SysCacheUtil;
import com.albedo.java.plugins.database.mybatis.service.impl.TreeServiceImpl;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
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
@CacheConfig(cacheNames = CacheNameConstants.DEPT_DETAILS)
@AllArgsConstructor
public class DeptServiceImpl extends TreeServiceImpl<DeptRepository, Dept, DeptDto> implements DeptService {

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
			DeptRelation relation = new DeptRelation();
			relation.setAncestor(deptDto.getParentId());
			relation.setDescendant(deptDto.getId());
			deptRelationService.updateDeptRelation(relation);
			SysCacheUtil.delDeptCaches(deptDto.getId());
		}
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
				.list(Wrappers.<DeptRelation>query().lambda().eq(DeptRelation::getAncestor, id)).stream()
				.map(DeptRelation::getDescendant).collect(Collectors.toSet());

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
		List<User> userList = userRepository.selectList(Wrappers.<User>lambdaQuery().eq(User::getDeptId, deptId));
		if (CollUtil.isNotEmpty(userList)) {
			throw new BizException("操作失败！用户："
				+ CollUtil.convertToString(userList, User.F_USERNAME, StringUtil.COMMA) + "所属要操作的部门：" + deptName);
		}
		List<Role> roleList = roleRepository.findListByDeptId(deptId);
		if (CollUtil.isNotEmpty(roleList)) {
			throw new BizException("操作失败！角色：" + CollUtil.convertToString(roleList, Role.F_NAME, StringUtil.COMMA)
				+ "的权限信息属于要操作的部门：" + deptName);
		}
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	@Cacheable(key = "'findDescendantIdList:' + #p0")
	public List<Long> findDescendantIdList(Long deptId) {
		List<Long> descendantIdList = deptRelationService
			.list(Wrappers.<DeptRelation>query().lambda().eq(DeptRelation::getAncestor, deptId)).stream()
			.map(DeptRelation::getDescendant).collect(Collectors.toList());
		return descendantIdList;
	}

	@Override
	@Cacheable(key = "'findTreeNode:' + #p0")
	public <Q> List<TreeNode> findTreeNode(Q queryCriteria) {
		return super.getNodeTree(repository.selectList(QueryWrapperUtil.<Dept>getWrapper(queryCriteria).lambda()
			.eq(Dept::getAvailable, CommonConstants.STR_YES).orderByAsc(Dept::getSort)));
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public IPage<DeptVo> findTreeList(DeptQueryCriteria deptQueryCriteria) {
		List<DeptVo> deptVoList = repository.findVoList(QueryWrapperUtil.<Dept>getWrapper(deptQueryCriteria)
			.eq(TreeEntity.F_SQL_DEL_FLAG, TreeEntity.FLAG_NORMAL).orderByAsc(TreeEntity.F_SQL_SORT));
		return new PageModel<>(Lists.newArrayList(TreeUtil.buildByLoopAutoRoot(deptVoList)), deptVoList.size());
	}

}
