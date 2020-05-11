package com.albedo.java.common.persistence.service;

import com.albedo.java.common.persistence.domain.GeneralEntity;
import com.albedo.java.common.persistence.repository.BaseRepository;
import com.baomidou.mybatisplus.extension.service.IService;

public interface BaseService<Repository extends BaseRepository<T>, T extends GeneralEntity> extends IService<T> {

}
