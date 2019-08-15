/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.modules.sys.domain.LogLogin;
import com.albedo.java.modules.sys.repository.LogLoginRepository;
import com.albedo.java.modules.sys.service.LogLoginService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 登录日志ServiceImpl 登录日志
 *
 * @author admin
 * @version 2019-08-15 09:32:16
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class LogLoginServiceImpl extends BaseServiceImpl<LogLoginRepository, LogLogin, String> implements LogLoginService {

}
