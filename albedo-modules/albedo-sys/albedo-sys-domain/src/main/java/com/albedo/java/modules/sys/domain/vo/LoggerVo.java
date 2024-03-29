package com.albedo.java.modules.sys.domain.vo;

import ch.qos.logback.classic.Logger;
import com.fasterxml.jackson.annotation.JsonCreator;

public class LoggerVo {
	private String name;

	private String level;

	public LoggerVo(Logger logger) {
		this.name = logger.getName();
		this.level = logger.getEffectiveLevel().toString();
	}

	@JsonCreator
	public LoggerVo() {
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	@Override
	public String toString() {
		return "LoggerVM{" + "name='" + name + '\'' + ", level='" + level + '\'' + '}';
	}
}
