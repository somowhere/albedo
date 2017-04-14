package com.albedo.java.common.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.common.repository.data.JpaCustomeRepository;
import com.albedo.java.common.repository.service.BaseService;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Assert;
import com.google.common.collect.Lists;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

@Service
@Transactional
public class TreeService<Repository extends JpaRepository<T, String>, T extends TreeEntity<T>> extends BaseService<Repository, T> {

}
