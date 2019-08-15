package com.albedo.java.modules.sys.domain.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GenSchemeDataVo {
	private String schemeName;
	private String parentMenuId;
	private String url;
	private String className;

}
