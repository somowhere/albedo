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

package com.albedo.java.modules.gen.domain.xml;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.List;

/**
 * 生成方案Entity
 *
 * @author somewhere
 * @version 2013-10-15
 */
@XmlRootElement(name = "config")
public class GenConfig implements Serializable {

	private static final long serialVersionUID = 1L;

	private String codeUiPath;

	/**
	 * 代码模板分类
	 */
	private List<GenCategory> categoryList;

	/**
	 * Java类型
	 */
	private List<DictTemp> javaTypeList;

	/**
	 * 查询类型
	 */
	private List<DictTemp> queryTypeList;

	/**
	 * 显示类型
	 */
	private List<DictTemp> showTypeList;

	/**
	 * 视图类型
	 */
	private List<DictTemp> viewTypeList;

	public GenConfig() {
		super();
	}

	@XmlElementWrapper(name = "category")
	@XmlElement(name = "category")
	public List<GenCategory> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<GenCategory> categoryList) {
		this.categoryList = categoryList;
	}

	@XmlElementWrapper(name = "javaType")
	@XmlElement(name = "dict")
	public List<DictTemp> getJavaTypeList() {
		return javaTypeList;
	}

	public void setJavaTypeList(List<DictTemp> javaTypeList) {
		this.javaTypeList = javaTypeList;
	}

	@XmlElementWrapper(name = "queryType")
	@XmlElement(name = "dict")
	public List<DictTemp> getQueryTypeList() {
		return queryTypeList;
	}

	public void setQueryTypeList(List<DictTemp> queryTypeList) {
		this.queryTypeList = queryTypeList;
	}

	@XmlElementWrapper(name = "showType")
	@XmlElement(name = "dict")
	public List<DictTemp> getShowTypeList() {
		return showTypeList;
	}

	public void setShowTypeList(List<DictTemp> showTypeList) {
		this.showTypeList = showTypeList;
	}

	@XmlElementWrapper(name = "viewType")
	@XmlElement(name = "dict")
	public List<DictTemp> getViewTypeList() {
		return viewTypeList;
	}

	public void setViewTypeList(List<DictTemp> viewTypeList) {
		this.viewTypeList = viewTypeList;
	}

	@XmlAttribute(name = "codeUiPath", required = true)
	public String getCodeUiPath() {
		return codeUiPath;
	}

	public void setCodeUiPath(String codeUiPath) {
		this.codeUiPath = codeUiPath;
	}

}
