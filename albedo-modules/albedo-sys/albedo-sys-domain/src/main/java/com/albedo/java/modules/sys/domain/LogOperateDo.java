
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

package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.constant.DictNameConstants;
import com.albedo.java.common.core.domain.BaseDo;
import com.albedo.java.common.core.util.StringUtil;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 日志表
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Data
@Builder
@Accessors(chain = true)
@TableName("sys_log_operate")
@NoArgsConstructor
@AllArgsConstructor
public class LogOperateDo extends BaseDo<LogOperateDo> {

	private static final long serialVersionUID = 1L;
	protected Long createdBy;
	/**
	 * 创建时间
	 */
	@ExcelField(title = "创建时间")
	protected LocalDateTime createdDate;
	/*** 备注 */
	@ExcelField(title = "描述")
	@Size(max = 500)
	protected String description;
	/**
	 * 编号
	 */
	@TableId(value = "id", type = IdType.INPUT)
	private Long id;
	/**
	 * 用户ID
	 */
	@NotBlank(message = "用户名不能为空")
	@ExcelField(title = "用户名")
	private String username;
	/**
	 * 日志标题
	 */
	@NotBlank(message = "日志标题不能为空")
	@ExcelField(title = "日志标题")
	private String title;
	/**
	 * 日志类型
	 */
	@ExcelField(title = "日志类型")
	private String logType;
	/**
	 * 操作类别（0其它 1后台用户 2手机端用户）
	 */
	@ExcelField(title = "操作类别", dictType = DictNameConstants.SYS_OPERATOR_TYPE)
	@DictType(DictNameConstants.SYS_OPERATOR_TYPE)
	private String operatorType;
	/**
	 * 操作IP地址
	 */
	@ExcelField(title = "操作IP")
	private String ipAddress;
	/**
	 * 登录地址
	 */
	@ExcelField(title = "IP位置")
	private String ipLocation;
	/**
	 * 用户代理
	 */
	@ExcelField(title = "用户代理")
	private String userAgent;
	/**
	 * 浏览器类型
	 */
	@ExcelField(title = "浏览器类型")
	private String browser;
	/**
	 * 操作系统
	 */
	@ExcelField(title = "操作系统")
	private String os;
	/**
	 * 请求URI
	 */
	@ExcelField(title = "请求URI")
	private String requestUri;

	/** 异常详细 */
	/**
	 * 操作方式
	 */
	@ExcelField(title = "操作方式")
	private String method;
	/**
	 * 操作提交的数据
	 */
	@ExcelField(title = "操作提交的数据")
	private String params;
	/**
	 * 执行时间
	 */
	@ExcelField(title = "执行时间")
	private Long time;
	/**
	 * 异常信息
	 */
	private String exception;
	/**
	 * 服务ID
	 */
	@ExcelField(title = "服务ID")
	private String serviceId;

	@Override
	public Serializable pkVal() {
		return id;
	}

	public void setDescription(String description) {
		if (description != null) {
			this.description = description.length() > 500 ? StringUtil.subPre(description, 500) : description;

		}
	}
}
