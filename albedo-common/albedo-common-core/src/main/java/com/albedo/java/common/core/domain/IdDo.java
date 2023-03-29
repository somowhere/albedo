/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.core.domain;

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
public class IdDo<T extends BaseDo<T>, PK extends Serializable> extends BaseDataDo<T, PK> {

	private static final long serialVersionUID = 1L;

	@TableId(value = GeneralDo.F_SQL_ID, type = IdType.INPUT)
	@Getter
	@Setter
	protected PK id;

	public IdDo() {
		super();
	}

	@Override
	public Serializable pkVal() {
		return this.getId();
	}

	@Override
	public void setPk(PK pk) {
		this.setId(pk);
	}

	@Override
	public boolean equals(Object o) {

		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		IdDo idDo = (IdDo) o;
		if (idDo.getId() == null || getId() == null) {
			return false;
		}
		return Objects.equals(getId(), idDo.getId());
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(getId());
	}

}
