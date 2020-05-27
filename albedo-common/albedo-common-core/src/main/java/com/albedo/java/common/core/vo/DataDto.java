package com.albedo.java.common.core.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiParam;
import lombok.Data;

import java.io.Serializable;
import java.util.Objects;

/**
 * 通常的数据基类 copyright 2014 albedo all right reserved author somewhere created on 2014年12月31日 下午1:57:09
 * @author somewhere
 */
@Data
public class DataDto<PK extends Serializable> extends GeneralDto {

	private PK id;
	@JsonIgnore
	@ApiModelProperty(hidden = true)
	private String delFlag;
	private String description;

	@Override
	public boolean equals(Object o) {
		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		return Objects.equals(id, ((DataDto) o).id);
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
}
