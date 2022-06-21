/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity支持类
 *
 * @author somewhere
 * @version 2014-05-16
 */
public abstract class BaseDo<T extends GeneralDo<T>> extends GeneralDo<T> {

	private static final long serialVersionUID = 1L;

	@TableField(value = GeneralDo.F_SQL_DEL_FLAG)
	@TableLogic(delval = FLAG_DELETE)
	@JsonIgnore
	protected String delFlag;

	protected BaseDo() {
		super();
		this.delFlag = FLAG_NORMAL;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

}
