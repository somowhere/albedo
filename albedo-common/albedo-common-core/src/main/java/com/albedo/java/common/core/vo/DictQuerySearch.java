package com.albedo.java.common.core.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.ToString;
import org.apache.commons.lang.StringEscapeUtils;

/**
 * Created by somewhere on 2017/3/2.
 */
@Data
@ApiModel
@ToString
public class DictQuerySearch {

	private String dictQueries;

	public void setDictQueries(String dictQueries) {
		this.dictQueries = StringEscapeUtils.unescapeHtml(dictQueries);
	}

}
