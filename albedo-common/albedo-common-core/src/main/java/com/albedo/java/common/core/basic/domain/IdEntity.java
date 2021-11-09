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

package com.albedo.java.common.core.basic.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Objects;

/**
 * @author somewhere
 */
@Accessors(chain = true)
@AllArgsConstructor
public class IdEntity<T extends BaseEntity<T>, PK extends Serializable> extends BaseDataEntity<T> {

	private static final long serialVersionUID = 1L;

	@TableId(value = GeneralEntity.F_SQL_ID, type = IdType.INPUT)
	@Getter
	@Setter
	protected PK id;

	public IdEntity() {
		super();
	}

	@Override
	public Serializable pkVal() {
		return this.getId();
	}

	@Override
	public void setPk(Serializable pk) {
		this.setId((PK) pk);
	}

	@Override
	public boolean equals(Object o) {

		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		IdEntity idEntity = (IdEntity) o;
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
