package com.albedo.java.modules.gen.domain.xml;

import javax.xml.bind.annotation.XmlAttribute;

/**
 * Created by somewhere on 2017/4/19.
 */
public class DictTemp {

	private String name;
	private String val;
	private String description;

	@XmlAttribute
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@XmlAttribute
	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	@XmlAttribute
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
