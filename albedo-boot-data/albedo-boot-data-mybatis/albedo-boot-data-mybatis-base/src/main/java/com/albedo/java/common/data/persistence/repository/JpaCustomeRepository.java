package com.albedo.java.common.data.persistence.repository;

import com.albedo.java.common.data.persistence.GeneralEntity;
import com.albedo.java.util.domain.Combo;
import com.albedo.java.util.domain.ComboData;

import java.util.List;

public interface JpaCustomeRepository<T extends GeneralEntity> {


    List<ComboData> findJson(Combo item);

}
