/*
 *  Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.domain.vo;

import com.albedo.java.common.persistence.domain.IdEntityAbstract;
import com.albedo.java.modules.sys.domain.Role;
import lombok.Data;

import java.io.Serializable;
import java.util.Objects;

/**
 * @author somewhere
 * @date 2019/2/1
 * 角色Dto
 */
@Data
public class RoleComboVo implements Serializable {

	private String id;
	private Integer level;
	private String name;


	public RoleComboVo(Role role) {
		this.id = role.getId();
		this.name = role.getName();
		this.level = role.getLevel();
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
