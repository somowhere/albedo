package com.albedo.java.modules.gen.domain.vo;

import com.albedo.java.common.core.vo.SelectVo;
import com.albedo.java.modules.gen.domain.dto.SchemeDto;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

/**
 * 生成方案Entity
 *
 * @author somewhere
 * @version 2013-10-15
 */
@Data
@ToString
@NoArgsConstructor
public class SchemeFormDataVo implements Serializable {

	private static final long serialVersionUID = 1L;

	private SchemeDto schemeVo;

	private GenConfig config;

	private List<SelectVo> categoryList;

	private List<SelectVo> viewTypeList;

	private List<SelectVo> tableList;

}
