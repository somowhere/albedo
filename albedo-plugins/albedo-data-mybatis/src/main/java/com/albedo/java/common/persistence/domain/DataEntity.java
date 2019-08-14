package com.albedo.java.common.persistence.domain;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.Version;
import lombok.Data;

import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Base abstract class for entities which will hold definitions for created, last modified by and created,
 * last modified by date.
 */
@Data
public abstract class DataEntity<T extends BaseEntity<T>> extends BaseEntity<T> {

	private static final long serialVersionUID = 1L;
	@TableField(value = GeneralEntity.F_SQL_CREATEDBY,
		fill = FieldFill.INSERT)
	protected String createdBy;


	@TableField(value = GeneralEntity.F_SQL_CREATEDDATE,
		fill = FieldFill.INSERT)
	protected LocalDateTime createdDate;

	@TableField(value = GeneralEntity.F_SQL_LASTMODIFIEDBY,
		fill = FieldFill.INSERT_UPDATE)
	protected String lastModifiedBy;

	@TableField(value = GeneralEntity.F_SQL_LASTMODIFIEDDATE,
		fill = FieldFill.INSERT_UPDATE)
	protected LocalDateTime lastModifiedDate;

	/*** 默认0，必填，离线乐观锁 */
	@Version
	@XmlTransient
	@TableField(GeneralEntity.F_SQL_VERSION)
	protected Integer version = 0;

	/*** 备注 */
	@XmlTransient
	@TableField(GeneralEntity.F_SQL_DESCRIPTION)
	protected String description;

	public abstract Serializable pkVal();

	public abstract void setPk(Serializable pk);
}
