package com.albedo.java.common.core.vo;

import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 通常的数据基类 copyright 2014 albedo all right reserved author somewhere created on 2014年12月31日 下午1:57:09
 */
@Data
public class DataEntityVo<PK extends Serializable> extends GeneralEntityVo {

	private PK id;
	private String delFlag = FLAG_NORMAL;
	private String createdBy;
	private LocalDateTime createdDate;
	private String lastModifiedBy;
	private int version;
	private LocalDateTime lastModifiedDate;
	private String description;

}
