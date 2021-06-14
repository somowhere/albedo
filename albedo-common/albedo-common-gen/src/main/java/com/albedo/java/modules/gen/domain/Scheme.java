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

package com.albedo.java.modules.gen.domain;

import com.albedo.java.common.core.annotation.BeanField;
import com.albedo.java.common.persistence.domain.IdEntity;
import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.Size;


/**
 * 生成方案Entity
 *
 * @author somewhere
 * @version 2013-10-15
 */
@TableName("gen_scheme")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class Scheme extends IdEntity<Scheme> {

	/**
	 * @Fields CATEGORY_CURD : 增删改查（单表）
	 */
	public static final String CATEGORY_CURD = "curd";
	/**
	 * @Fields CATEGORY_CURD_MANY : 增删改查（一对多）
	 */
	public static final String CATEGORY_CURD_MANY = "curd_many";
	/**
	 * @Fields CATEGORY_SERVICE : 仅持久层（common/domain）
	 */
	public static final String CATEGORY_SERVICE = "common";
	/**
	 * @Fields CATEGORY_CURD : 数据层（domain）
	 */
	public static final String CATEGORY_ENITY = "domain";
	/**
	 * @Fields CATEGORY_CURD : 树结构表（一体）
	 */
	public static final String CATEGORY_TREETABLE = "treeTable";
	private static final long serialVersionUID = 1L;
	@Size(min = 1, max = 200)
	@TableField("name")
	private String name;
	@TableField("category")
	private String category;
	@TableField("view_type")
	private Integer viewType;
	/**
	 * 生成包路径
	 */
	@TableField("package_name")
	private String packageName;
	/**
	 * 生成模块名
	 */
	@TableField("module_name")
	private String moduleName;
	/**
	 * 生成子模块名
	 */
	@TableField("sub_module_name")
	private String subModuleName;
	/**
	 * 生成功能名
	 */
	@TableField("function_name")
	private String functionName;
	/**
	 * 生成功能名（简写）
	 */
	@TableField("function_name_simple")
	private String functionNameSimple;
	/**
	 * 生成功能作者
	 */
	@TableField("function_author")
	private String functionAuthor;
	/**
	 * 业务表名
	 */
	@TableField(exist = false)
	@BeanField(ingore = true)
	private Table table;
	/**
	 * 业务表名主键
	 */
	@TableField("gen_table_id")
	private String tableId;
	/**
	 * flase：保存方案； ture：保存方案并生成代码
	 */
	@JSONField(serialize = false)
	@TableField(exist = false)
	private Boolean genCode = false;
	/**
	 * 是否替换现有文件 true：替换文件 ；false：不替换；
	 */
	@JSONField(serialize = false)
	@TableField(exist = false)
	private Boolean replaceFile = false;
	/**
	 * 是否同步菜单数据 true：同步；false：不同步
	 */
	@JSONField(serialize = false)
	@TableField(exist = false)
	private Boolean syncMenu = false;
	/**
	 * 上级模块 ID 仅当syncMenu 为 true有效
	 */
	@JSONField(serialize = false)
	@TableField(exist = false)
	private String parentMenuId;

	public Scheme(String id) {
		super();
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPackageName() {
		return packageName;
	}

	public Integer getViewType() {
		return viewType;
	}

	public void setViewType(Integer viewType) {
		this.viewType = viewType;
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
