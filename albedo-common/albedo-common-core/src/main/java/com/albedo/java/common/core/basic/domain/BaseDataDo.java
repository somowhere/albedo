/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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

package com.albedo.java.common.core.basic.domain;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.Version;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Base abstract class for entities which will hold definitions for created, last modified
 * by and created, last modified by date.
 *
 * @author somewhere
 */
@Data
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
public abstract class BaseDataDo<T extends BaseDo<T>, PK extends Serializable> extends BaseDo<T> {

	private static final long serialVersionUID = 1L;

	@TableField(value = F_SQL_CREATED_BY, fill = FieldFill.INSERT)
	protected PK createdBy;

	@TableField(value = F_SQL_CREATED_DATE, fill = FieldFill.INSERT)
	protected LocalDateTime createdDate;

	@TableField(value = F_SQL_LAST_MODIFIED_BY, fill = FieldFill.INSERT_UPDATE)
	protected PK lastModifiedBy;

	@TableField(value = F_SQL_LAST_MODIFIED_DATE, fill = FieldFill.INSERT_UPDATE)
	protected LocalDateTime lastModifiedDate;

	/*** 默认0，必填，离线乐观锁 */
	@Version
	@XmlTransient
	@TableField(F_SQL_VERSION)
	protected Integer version = 0;

	/*** 备注 */
	@XmlTransient
	@TableField(F_SQL_DESCRIPTION)
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
	public abstract void setPk(PK pk);

}
