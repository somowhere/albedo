package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.TreeEntityVo;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.common.core.vo.TreeQuery;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.repository.TreeRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface TreeVoService<Repository extends TreeRepository<T>,
	T extends TreeEntity, V extends TreeEntityVo> extends
	DataService<Repository, T, String>, TreeService<Repository, T> {
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	V findOneVo(String id);

	boolean doCheckByProperty(V entityForm);

	boolean doCheckByPK(V entityForm);

	void copyBeanToVo(T module, V result);

	V copyBeanToVo(T module);

	void copyVoToBean(V form, T entity);

	T copyVoToBean(V form);

	V save(V form);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<V> findAllVoByParentId(String parentId);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	Optional<V> findOptionalTopByParentId(String parentId);


	/**
	 * 查询部门树菜单
	 *
	 * @return 树
	 */
	List<TreeNode> listTrees(TreeQuery treeQuery);
}
