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

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.basic.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlTransient;
import java.util.List;

/**
 * 生成方案Entity
 *
 * @author somewhere
 * @version 2013-10-15
 */
@TableName("gen_template")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class Template extends IdEntity<Template, String> {

	public static final String F_NAME = "name";

	private static final long serialVersionUID = 1L;

	/**
	 * 名称
	 */
	@Size(min = 1, max = 200)
	@TableField("name")
	private String name;

	/**
	 * 分类
	 */
	@TableField("category")
	private String category;

	/**
	 * 生成文件路径
	 */
	@TableField("file_path")
	private String filePath;

	/**
	 * 文件名
	 */
	@TableField("file_name")
	private String fileName;

	/**
	 * 内容
	 */
	@TableField("content")
	private String content;

	private boolean ignoreOutput;

	public Template(String id) {
		super();
		this.id = id;

	}

	@XmlTransient
	public String getCategory() {
		return category;
	}

	public List<String> getCategoryList() {
		if (category == null) {
			return Lists.newArrayList();
		} else {
			return Lists.newArrayList(StringUtil.split(category, ","));
		}
	}

	public void setCategoryList(List<String> categoryList) {
		if (categoryList == null) {
			this.category = "";
		} else {
			this.category = "," + CollUtil.join(categoryList, ",") + ",";
		}
	}

}
