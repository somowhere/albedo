package com.albedo.java.modules.gen.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

/**
 * 业务表Entity
 *
 * @version 2013-10-15
 */
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class TableQuery implements Serializable {

	private static final long serialVersionUID = 1L;

	private String name; // 名称

	private List<String> notNames;

	private List<String> notLikeNames;

}
