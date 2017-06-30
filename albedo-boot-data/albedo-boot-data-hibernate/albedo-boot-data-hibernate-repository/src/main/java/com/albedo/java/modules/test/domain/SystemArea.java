/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.test.domain;

import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.SearchField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import javax.persistence.*;
import javax.validation.constraints.NotNull;


@Entity
@Table(name = "system_area")
@DynamicInsert
@DynamicUpdate
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@Data @ToString @NoArgsConstructor @AllArgsConstructor
public class SystemArea extends DataEntity {
	
	private static final long serialVersionUID = 1L;
	/** F_PARENTIDS parent_ids  :  所有上级区域节点 */
	public static final String F_PARENTIDS = "parentIds";
	/** F_PARENTID parent_id  :  上级区域 */
	public static final String F_PARENTID = "parentId";
	/** F_NAME name_  :  区域名称 */
	public static final String F_NAME = "name";
	/** F_SHORTNAME short_name  :  区域简称 */
	public static final String F_SHORTNAME = "shortName";
	/** F_SORT sort_  :  序号 */
	public static final String F_SORT = "sort";
	/** F_LEVEL level_  :  区域等级(1省/2市/3区县) */
	public static final String F_LEVEL = "level";
	/** F_CODE code_  :  区域编码 */
	public static final String F_CODE = "code";
	/** F_ISLEAF is_leaf  :  1 叶子节点 0 非叶子节点 */
	public static final String F_ISLEAF = "isLeaf";
	
	//columns START
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_")
	@SearchField
	private Long id;
	/** parentIds 所有上级区域节点 */@NotBlank @Length(max=65535)@Column(name = "parent_ids")
	private String parentIds;
	/** parentId 上级区域 */@Column(name = "parent_id")
	private Long parentId;
	/** name 区域名称 */@Length(max=32)@Column(name = "name_")
	private String name;
	/** shortName 区域简称 */@Length(max=32)@Column(name = "short_name")
	private String shortName;
	/** sort 序号 */@NotNull @Column(name = "sort_")
	private Long sort;
	/** level 区域等级(1省/2市/3区县) */@Column(name = "level_")
	private Integer level;
	/** code 区域编码 */@Length(max=32)@Column(name = "code_")
	private String code;
	/** isLeaf 1 叶子节点 0 非叶子节点 */@Length(max=1)@Column(name = "is_leaf")@DictType(name="sys_yes_no")
	private boolean isLeaf;
	//columns END

	public SystemArea(Long id) {
		this.id = id;
	}
	/** id 区域id */
	public void setId(Long id) {
		if (PublicUtil.isNotEmpty(id))this.id = id;
	}
	/** id 区域id */
	public Long getId() {
		return this.id;
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof SystemArea == false) return false;
		if(this == obj) return true;
		SystemArea other = (SystemArea)obj;
		return new EqualsBuilder()
			.append(getId(),other.getId())
			.isEquals();
	}
}
