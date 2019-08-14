package com.albedo.java.common.security.component;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.security.util.SecurityUtil;
import org.springframework.data.domain.AuditorAware;
import org.springframework.stereotype.Component;

import java.util.Optional;

/**
 * Implementation of AuditorAware based on Spring Security.
 */
@Component
public class SpringSecurityAuditorAware implements AuditorAware<String> {

	@Override
	public Optional<String> getCurrentAuditor() {
		return Optional.of(SecurityUtil.getUser() == null ? CommonConstants.SYSTEM
			: SecurityUtil.getUser().getId());
	}
}
