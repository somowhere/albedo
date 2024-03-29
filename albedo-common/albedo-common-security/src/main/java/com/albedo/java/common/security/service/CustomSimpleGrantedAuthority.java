package com.albedo.java.common.security.service;

import com.albedo.java.common.core.util.ArgumentAssert;
import org.springframework.security.core.GrantedAuthority;

/**
 * @author somewhere
 */
public class CustomSimpleGrantedAuthority implements GrantedAuthority {
	private static final long serialVersionUID = -1L;
	private String role;

	public CustomSimpleGrantedAuthority(String role) {
		ArgumentAssert.notEmpty(role, "A granted authority textual representation is required");
		this.role = role;
	}

	public CustomSimpleGrantedAuthority() {
	}

	@Override
	public String getAuthority() {
		return this.role;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		} else {
			return obj instanceof CustomSimpleGrantedAuthority ? this.role.equals(((CustomSimpleGrantedAuthority) obj).role) : false;
		}
	}

	@Override
	public int hashCode() {
		return this.role.hashCode();
	}

	@Override
	public String toString() {
		return this.role;
	}
}
