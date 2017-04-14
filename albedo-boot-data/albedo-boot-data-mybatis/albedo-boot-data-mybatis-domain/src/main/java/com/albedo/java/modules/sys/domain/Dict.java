package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.SearchField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlAttribute;

/**
 * Copyright 2013 albedo All right reserved Author lijie Created on 2013-10-23
 * 下午1:55:43
 */
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Dict extends TreeEntity<Dict> {

	private static final long serialVersionUID = 1L;
	/** 叶子节点 */
	public static final String FLAG_LEAF = "0";
	/** 非叶子节点 */
	public static final String FLAG_UNLEAF = "1";
	public static final String F_CODE = "code";
	public static final String F_VAL = "val";
	
	/*** 编码 */
	@SearchField
	private String code;
	/*** 字典值 */
	private String val;
	/*** 资源文件key */
	private String showName;
	@NotNull
	@DictType(name = "sys_yes_no")
	private Integer isShow = 1;
	private String parentCode;
	

	public Dict(String id) {
		this.id=id;
	}

	@XmlAttribute
	public String getVal() {
		return val;
	}

	@XmlAttribute
	public String getDescription() {
		return super.getDescription();
	}	


	@XmlAttribute
	public String getName() {
		return super.getName();
	}
	

	public String getParentCode() {
		if(PublicUtil.isEmpty(parentCode) && parent!=null){
			parentCode=parent.getCode();
		}
		return parentCode;
	}

}
