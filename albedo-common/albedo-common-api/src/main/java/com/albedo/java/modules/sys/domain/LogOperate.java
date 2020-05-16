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

package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.constant.DictNameConstants;
import com.albedo.java.common.persistence.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import javax.validation.constraints.NotBlank;
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
@TableName("sys_log_operate")
public class LogOperate extends BaseEntity<LogOperate> {

	private static final long serialVersionUID = 1L;
	protected String createdBy;
	/**
	 * 创建时间
	 */
	@ExcelField(title = "创建时间")
	protected LocalDateTime createdDate;
	/**
	 * 编号
	 */
	@TableId(value = "id", type = IdType.AUTO)
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
	 * 业务类型（0其它 1新增 2修改 3删除）
	 */
	@ExcelField(title = "业务类型", dictType = "sys_business_type")
	@DictType(DictNameConstants.SYS_BUSINESS_TYPE)
	private Integer businessType;
	/**
	 * 操作类别（0其它 1后台用户 2手机端用户）
	 */
	@ExcelField(title = "操作类别", dictType = "sys_operator_type")
	@DictType(DictNameConstants.SYS_OPERATOR_TYPE)
	private Integer operatorType;
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
	@ExcelField(title = "异常信息")
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

}
