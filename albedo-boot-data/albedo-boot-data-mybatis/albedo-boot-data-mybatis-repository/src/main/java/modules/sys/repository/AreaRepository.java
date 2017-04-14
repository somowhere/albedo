/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package modules.sys.repository;

import com.albedo.java.modules.sys.domain.Area;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Optional;

/**
 * 区域管理Repository 区域管理
 * @author admin
 * @version 2017-01-01
 */
public interface AreaRepository extends JpaRepository<Area, String>, JpaSpecificationExecutor<Area> {

	Optional<Area> findOneById(String id);

	Area findFirstByParentId(String parentId);
	
	List<Area> findAllByParentIdsLike(String parentIds);

	List<Area> findAllByParentIdAndStatusNot(String parentId, Integer status);
	
	List<Area> findAllByStatusNot(Integer status);
	
	Area findTopByParentIdAndStatusNotOrderBySortDesc(String parentId, Integer status);
	
}