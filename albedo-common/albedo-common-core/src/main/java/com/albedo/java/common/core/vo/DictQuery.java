package com.albedo.java.common.core.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.ToString;

/**
 * Created by somewhere on 2017/3/2.
 *
 * @author somewhere
 */
@Data
@ApiModel
@ToString
public class DictQuery {

	private String code;
	private String filter;

}
