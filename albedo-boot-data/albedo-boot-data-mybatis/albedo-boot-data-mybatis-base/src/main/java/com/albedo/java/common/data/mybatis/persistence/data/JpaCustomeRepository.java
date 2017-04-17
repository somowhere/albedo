package com.albedo.java.common.data.mybatis.persistence.data;

import com.albedo.java.common.data.mybatis.persistence.GeneralEntity;
import com.albedo.java.util.domain.Combo;
import com.albedo.java.util.domain.ComboData;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.List;
import java.util.Map;

public interface JpaCustomeRepository<T extends GeneralEntity> {


    List<ComboData> findJson(Combo item);
}
