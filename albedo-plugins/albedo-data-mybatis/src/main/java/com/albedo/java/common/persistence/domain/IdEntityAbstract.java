package com.albedo.java.common.persistence.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;
import java.util.Objects;


/**
 * @author somewhere
 */
public class IdEntityAbstract<T extends BaseEntity<T>> extends AbstractDataEntity<T> {

	private static final long serialVersionUID = 1L;
	@TableId(value = GeneralEntity.F_SQL_ID, type = IdType.ASSIGN_UUID)
	protected String id;

	public IdEntityAbstract() {
		super();
	}

	@Override
	public Serializable pkVal() {
		return this.getId();
	}

	@Override
	public void setPk(Serializable pk) {
		this.setId((String) pk);
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public boolean equals(Object o) {

		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		IdEntityAbstract idEntity = (IdEntityAbstract) o;
		if (idEntity.getId() == null || getId() == null) {
			return false;
		}
		return Objects.equals(getId(), idEntity.getId());
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(getId());
	}
}
