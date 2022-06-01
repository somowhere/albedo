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

package com.albedo.java.modules.gen.domain;

import com.albedo.java.common.core.basic.domain.IdDo;
import com.albedo.java.common.core.util.StringUtil;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.List;

/**
 * 业务表Entity
 *
 * @author somewhere
 * @version 2013-10-15
 */
@TableName("gen_table")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class TableDo extends IdDo<TableDo, String> {

	public static final String F_NAME = "name";

	public static final String F_NAMESANDTITLE = "nameAndTitle";

	private static final long serialVersionUID = 1L;

	@TableField("name")
	@Size(min = 1, max = 200)
	@NotBlank
	private String name;

	@TableField("comments")
	private String comments;

	@TableField("class_name")
	@NotBlank
	private String className;

	@TableField("parent_table")
	private String parentTable;

	@TableField("ds_name")
	@NotBlank
	private String dsName;

	@TableField("parent_table_fk")
	private String parentTableFk;

	@TableField(exist = false)
	@JsonIgnore
	private List<TableColumnDo> columnList;

	@JsonIgnore
	@TableField(exist = false)
	private TableDo parent;

	@TableField(exist = false)
	private List<TableDo> childList;

	@TableField(exist = false)
	private String nameAndTitle;

	@TableField(exist = false)
	private String nameLike;

	@TableField(exist = false)
	@JsonIgnore
	private List<String> pkList;

	@TableField(exist = false)
	@JsonIgnore
	private List<TableColumnDo> pkColumnList;

	@TableField(exist = false)
	private String category;

	@TableField(exist = false)
	@JsonIgnore
	private List<TableColumnDo> columnFormList;

	public TableDo(String id) {
		super();
		this.id = id;
	}

	public TableDo(String name, String comments) {
		this.name = name;
		this.comments = comments;
	}

	public String getName() {
		return StringUtil.lowerCase(name);
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getParentTable() {
		return StringUtil.lowerCase(parentTable);
	}

	public void setParentTable(String parentTable) {
		this.parentTable = parentTable;
	}

	public String getParentTableJavaFieldFk() {
		return StringUtil.toCamelCase(parentTableFk);
	}

	public String getParentTableFk() {
		return StringUtil.lowerCase(parentTableFk);
	}

	public void setParentTableFk(String parentTableFk) {
		this.parentTableFk = parentTableFk;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	/**
	 * 获取列名和说明
	 *
	 * @return
	 */
	public String getNameAndTitle() {
		if (StringUtil.isEmpty(nameAndTitle)) {
			nameAndTitle = getName() + (comments == null ? "" : "  :  " + comments);
		}
		return nameAndTitle;
	}

	public void setNameAndComments(String nameAndTitle) {
		this.nameAndTitle = nameAndTitle;
	}

	@Override
	public boolean equals(Object o) {
		return super.equals(o);
	}

	@Override
	public int hashCode() {
		return super.hashCode();
	}

}
