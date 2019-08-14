package com.albedo.java.common.core.vo;

import lombok.Data;

/**
 * Created by somewhere on 2017/3/2.
 */
@Data
public class TreeResult {

	private String id;
	private String pid;
	private String label;
	private String value;
	private String key;
	private String iconCls;
	private Boolean disabled = false;
}
