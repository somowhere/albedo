package com.albedo.java.common.core.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Created by somewhere on 2017/3/2.
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DictTreeResult {

	private String id;
	private String pid;
	private String name;
	private String value;
	private String label;


}
