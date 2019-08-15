package com.albedo.java.modules.gen.service.impl;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.gen.domain.Template;
import com.albedo.java.modules.gen.repository.TemplateRepository;
import org.springframework.stereotype.Service;

/**
 * Service class for managing tables.
 *
 * @author somewhere
 */
@Service
public class TemplateServiceImpl extends DataServiceImpl<TemplateRepository, Template, String> implements com.albedo.java.modules.gen.service.TemplateService {

}
