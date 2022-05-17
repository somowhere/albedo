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

import cn.hutool.core.text.CharSequenceUtil;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * 数据TreeEntity类
 *
 * @author somewhere version 2013-12-27 下午12:27:10
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class TreeEntity<T extends TreeEntity<T>> extends IdEntity<T, Long> {

	public static final String F_NAME = "name";

	public static final String F_PARENT_ID = "parentId";

	public static final String F_PARENT_IDS = "parentIds";

	public static final String F_LEAF = "leaf";

	public static final String F_SORT = "sort";

	public static final String F_PARENT = "parent";

	public static final String F_SQL_NAME = "name";

	public static final String F_SQL_PARENT_ID = "parent_id";

	public static final String F_SQL_PARENT_IDS = "parent_ids";

	public static final String F_SQL_LEAF = "leaf";

	public static final String F_SQL_SORT = "sort";

	private static final long serialVersionUID = 1L;

	/*** 组织名称 */
	@TableField
	@NotBlank(message = "名称不能为空")
	protected String name;

	/*** 上级组织 */
	@TableField
	@NotNull(message = "父ID不能为空")
	protected Long parentId;

	/*** 所有父编号 */
	@TableField
	protected String parentIds;

	/*** 上级组织 */
	@TableField(exist = false)
	@JsonIgnore
	protected T parent;

	/*** 序号 */
	@TableField
	protected Integer sort;

	/*** 父模块名称 */
	@TableField(exist = false)
	protected String parentName;

	/*** 1 叶子节点 0非叶子节点 */
	@TableField
	private boolean leaf = false;

	public TreeEntity() {
		super();
		this.sort = 30;
	}

	public TreeEntity(Long id) {
		super();
		this.id = id;
		this.sort = 30;
	}

	public String getParentName() {
		if (CharSequenceUtil.isEmpty(parentName) && parent != null) {
			parentName = parent.getName();
		}
		return parentName;
	}

}
