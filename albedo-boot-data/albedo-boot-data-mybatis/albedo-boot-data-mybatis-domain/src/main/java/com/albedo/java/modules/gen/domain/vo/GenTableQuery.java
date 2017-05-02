package com.albedo.java.modules.gen.domain.vo;

import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.modules.gen.domain.GenTableColumn;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.annotation.SearchField;
import com.albedo.java.util.base.Collections3;
import com.albedo.java.util.config.SystemConfig;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.alibaba.fastjson.annotation.JSONField;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mybatis.annotations.*;

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
public class GenTableQuery implements Serializable {

	private static final long serialVersionUID = 1L;

	private String name; // 名称

	private List<String> notNames;


	private List<String> notLikeNames;

}
