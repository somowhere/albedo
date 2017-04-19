package com.albedo.java.common.domain.base;

import com.albedo.java.common.data.mybatis.persistence.IdGen;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.annotation.SearchField;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.Id;
import org.springframework.data.mybatis.annotations.MappedSuperclass;

@MappedSuperclass
public abstract class IdEntity extends DataEntity<String> {

	private static final long serialVersionUID = 1L;
	@SearchField
	@Id(strategy = Id.GenerationType.UUID)
	@Column(name = "id_")
	protected String id; // 编号

	public IdEntity() {
		super();
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
