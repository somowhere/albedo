/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
 *
 * @author somewhere
 */
@Data
public abstract class BaseDataEntity<T extends BaseEntity<T>> extends BaseEntity<T> {

	private static final long serialVersionUID = 1L;
	@TableField(value = GeneralEntity.F_SQL_CREATED_BY,
		fill = FieldFill.INSERT)
	protected String createdBy;


	@TableField(value = GeneralEntity.F_SQL_CREATED_DATE,
		fill = FieldFill.INSERT)
	protected LocalDateTime createdDate;

	@TableField(value = GeneralEntity.F_SQL_LAST_MODIFIED_BY,
		fill = FieldFill.INSERT_UPDATE)
	protected String lastModifiedBy;

	@TableField(value = GeneralEntity.F_SQL_LAST_MODIFIED_DATE,
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

	/**
	 * 获取主键
	 *
	 * @return
	 */
	@Override
	public abstract Serializable pkVal();

	/**
	 * 设置主键
	 *
	 * @param pk
	 */
	public abstract void setPk(Serializable pk);
}
