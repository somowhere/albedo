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

package com.albedo.java.common.log.enums;

/**
 * 业务操作类型
 *
 * @author somewhere
 */
public enum BusinessType {

	/**
	 * 查看
	 */
	VIEW,

	/**
	 * 编辑
	 */
	EDIT,
	/**
	 * 锁定
	 */
	LOCK,

	/**
	 * 删除
	 */
	DELETE,

	/**
	 * 导出
	 */
	EXPORT,

	/**
	 * 导入
	 */
	IMPORT,

	/**
	 * 强退
	 */
	FORCE_LOGOUT,
	/**
	 * 登录
	 */
	LOGIN,

	/**
	 * 生成代码
	 */
	GENCODE,
	/**
	 * 清空
	 */
	CLEAN,

	/**
	 * 其它
	 */
	OTHER

}
