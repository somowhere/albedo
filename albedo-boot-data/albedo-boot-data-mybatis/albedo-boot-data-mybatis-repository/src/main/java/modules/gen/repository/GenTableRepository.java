package modules.gen.repository;

import com.albedo.java.modules.gen.domain.GenTable;
import org.springframework.data.mybatis.repository.support.MybatisRepository;

import java.util.Optional;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface GenTableRepository extends MybatisRepository<GenTable, String> {

}
