package modules.sys.repository;

import com.albedo.java.modules.sys.domain.Org;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Optional;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface OrgRepository extends JpaRepository<Org, String>, JpaSpecificationExecutor<Org> {

	Optional<Org> findOneById(String id);

	Org findFirstByParentId(String id);

	List<Org> findFirstByParentIdsLike(String parentIds);

	List<Org> findAllByParentIdAndStatusNot(String parentId, Integer flagDelete);
}
