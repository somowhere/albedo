package com.albedo.java.modules.gen.domain.vo;

import com.albedo.java.common.core.vo.SelectVo;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

/**
 * 业务表Entity
 *
 * @author somowhere
 * @version 2013-10-15
 */
@Data
@ToString
@NoArgsConstructor
public class TableFormDataVo implements Serializable {

	private static final long serialVersionUID = 1L;

	private TableDto tableVo;

	private GenConfig config;

	private List<SelectVo> dsNameList;

	private List<SelectVo> columnList;

	private List<SelectVo> tableList;

	private List<SelectVo> queryTypeList;

	private List<SelectVo> showTypeList;

	private List<SelectVo> javaTypeList;

}
