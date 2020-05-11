package com.albedo.java.modules.sys.domain.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GenSchemeDto {
	private String schemeName;
	private String parentMenuId;
	private String url;
	private String className;

}
