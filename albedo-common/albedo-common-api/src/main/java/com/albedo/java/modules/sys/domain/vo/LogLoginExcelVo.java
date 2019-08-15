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

package com.albedo.java.modules.sys.domain.vo;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.annotation.ExcelField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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
public class LogLoginExcelVo implements Serializable {

	private static final long serialVersionUID = 1L;
	/**
	 * 登录时间
	 */
	@ExcelField(title = "登录时间")
	protected LocalDateTime loginTime;
	/**
	 * 编号
	 */
	@TableId(value = "id", type = IdType.AUTO)
	private Long id;
	/**
	 * 登录账号
	 */
	@NotBlank(message = "登录账号不能为空")
	@ExcelField(title = "登录账号")
	private String loginName;
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
	@DictType("sys_business_type")
	private Integer businessType;
	/**
	 * 操作类别（0其它 1后台用户 2手机端用户）
	 */
	@ExcelField(title = "操作类别", dictType = "sys_operator_type")
	@DictType("sys_operator_type")
	private Integer operatorType;
	/**
	 * 操作IP地址
	 */
	@ExcelField(title = "操作IP")
	private String ipAddress;
	/**
	 * 登录地点
	 */
	@ExcelField(title = "登录地点")
	private String loginLocation;
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
	 * 提示消息
	 */
	@ExcelField(title = "提示消息")
	private String message;


}
