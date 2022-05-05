
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

package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.basic.domain.BaseDataEntity;
import com.albedo.java.common.core.basic.domain.TreeEntity;
import com.albedo.java.common.core.constant.DictNameConstants;
import com.albedo.java.common.core.util.StringUtil;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlAttribute;

/**
 * <p>
 * 字典表
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_dict")
public class Dict extends TreeEntity<Dict> {

	public static final String F_VAL = "val";

	public static final String F_SHOW = "show";

	public static final String F_SQL_SHOW = "show";

	private static final long serialVersionUID = 1L;

	/**
	 * 数据值
	 */
	@NotBlank(message = "字典项数据值不能为空")
	private String val;

	/**
	 * 类型
	 */
	@NotBlank(message = "字典项数据类型不能为空")
	private String code;

	@NotNull
	@DictType(DictNameConstants.SYS_FLAG)
	private Integer available = 1;

	@TableField(exist = false)
	private String parentCode;

	@XmlAttribute
	public String getVal() {
		return val;
	}

	@Override
	@XmlAttribute
	public String getDescription() {
		return super.getDescription();
	}

	@Override
	public BaseDataEntity<Dict, Long> setDescription(String description) {
		return super.setDescription(description);
	}

	@Override
	@XmlAttribute
	public String getName() {
		return super.getName();
	}

	@Override
	public void setName(String name) {
		super.setName(name);
	}

	public String getParentCode() {
		if (StringUtil.isEmpty(parentCode) && parent != null) {
			parentCode = parent.getCode();
		}
		return parentCode;
	}

}
