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

package com.albedo.java.modules.gen.domain;

import com.albedo.java.common.core.basic.domain.IdDo;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * 业务表字段Entity
 *
 * @author somewhere
 * @version 2013-10-15
 */
@TableName("gen_table_column")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class TableColumnDo extends IdDo<TableColumnDo, String> implements Comparable<TableColumnDo> {

	public static final String F_GENTABLEID = "tableId";

	public static final String F_SORT = "sort";

	public static final String F_SQL_GENTABLEID = "gen_table_id";

	private static final long serialVersionUID = 1L;

	@TableField(F_SQL_GENTABLEID)
	private String tableId;

	/**
	 * 列名
	 */
	@Size(min = 1, max = 200)
	@TableField("name")
	private String name;

	/**
	 * 标题
	 */
	@TableField("title")
	@NotBlank
	private String title;

	/**
	 * 描述
	 */
	@TableField("comments")
	private String comments;

	/**
	 * JDBC类型
	 */
	@TableField("jdbc_type")
	private String jdbcType;

	/**
	 * JAVA类型
	 */
	@TableField("java_type")
	private String javaType;

	/**
	 * JAVA字段名
	 */
	@TableField("java_field_name")
	private String javaFieldName;

	/**
	 * 是否主键（1：主键）
	 */
	@TableField("pk")
	private boolean pk;

	/**
	 * 是否唯一（1：是；0：否）
	 */
	@TableField("unique_field")
	private boolean uniqueField;

	/**
	 * 是否可为空（1：可为空；0：不为空）
	 */
	@TableField("null_field")
	private boolean nullField;

	/**
	 * 是否为插入字段（1：插入字段）
	 */
	@TableField("insert_field")
	private boolean insertField;

	/**
	 * 是否编辑字段（1：编辑字段）
	 */
	@TableField("edit_field")
	private boolean editField;

	/**
	 * 是否列表字段（1：列表字段）
	 */
	@TableField("list_field")
	private boolean listField;

	/**
	 * 是否查询字段（1：查询字段）
	 */
	@TableField("query_field")
	private boolean queryField;

	/**
	 * 查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）
	 */
	@TableField("query_type")
	private String queryType;

	/**
	 * 字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）
	 */
	@TableField("show_type")
	private String showType;

	/**
	 * 字典类型
	 */
	@TableField("dict_type")
	private String dictType;

	/**
	 * 排序（升序）
	 */
	@TableField("sort")
	private Integer sort;

	@TableField(exist = false)
	private String hibernateValidatorExprssion;

	@TableField(exist = false)
	private String size;

	public TableColumnDo(String id) {
		super();
		this.id = id;
	}

	public TableColumnDo(String name, boolean nullField, Integer sort, String comments, String jdbcType) {
		this.name = name;
		this.nullField = nullField;
		this.sort = sort;
		this.comments = comments;
		this.jdbcType = jdbcType;
	}

	/**
	 * 获取列名和说明
	 *
	 * @return
	 */
	public String getNameAndTitle() {
		return getName() + (comments == null ? "" : "  :  " + comments);
	}

	@Override
	public int compareTo(TableColumnDo o) {
		return o.getSort() != null ? this.sort != null ? this.sort - o.getSort() : 0 : this.sort;
	}

}
