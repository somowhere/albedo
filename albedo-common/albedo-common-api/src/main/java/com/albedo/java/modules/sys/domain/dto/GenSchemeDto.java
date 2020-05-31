package com.albedo.java.modules.sys.domain.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
* @Description:
* @Author: somewhere
* @Date: 2020/5/30 11:24 下午
*/
@Data
@AllArgsConstructor
@NoArgsConstructor
public class GenSchemeDto {
	private String schemeName;
	private String parentMenuId;
	private String url;
	private String className;

}
